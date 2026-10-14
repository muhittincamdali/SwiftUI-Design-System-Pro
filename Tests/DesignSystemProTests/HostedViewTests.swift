#if os(macOS)
import AppKit
import SwiftUI
import Testing
@testable import DesignSystemPro

/// View-level checks that need a real view hierarchy. `ImageRenderer` draws
/// platform controls such as switches as placeholders, does not apply
/// `preferredColorScheme` and never gives a view focus, so these tests host
/// the views in AppKit and read back what was drawn.
///
/// Colors drawn by AppKit go through the display's color space, so the pixel
/// checks compare against the nearest candidate color instead of exact values.
/// Serialized because hosted text fields compete for focus when the cases
/// interleave.
@Suite("Hosted views", .serialized)
@MainActor
struct HostedViewTests {
    // MARK: Theme provider

    @Test func themeProviderForcesTheSchemeOfAnExplicitTheme() async throws {
        let manager = ThemeManager()
        manager.setTheme(DarkTheme())
        let probe = EnvironmentProbe()
        let host = HostedView(DSThemeProvider(themeManager: manager) { probe.view }, appearance: .aqua, inWindow: true)
        try await host.settle()

        #expect(probe.lastScheme == .dark)
        #expect(probe.lastThemeID == DarkTheme().id)
    }

    @Test func themeProviderFollowingTheSystemSeesLaterSystemChanges() async throws {
        let manager = ThemeManager()
        let probe = EnvironmentProbe()
        let host = HostedView(DSThemeProvider(themeManager: manager) { probe.view }, appearance: .aqua, inWindow: true)
        try await host.settle()
        #expect(probe.lastScheme == .light)
        #expect(probe.lastThemeID == LightTheme().id)

        // The system switches to dark mode. A provider that pinned the scheme
        // while following the system would keep reporting light here.
        host.setAppearance(.darkAqua)
        try await host.settle()
        #expect(probe.lastScheme == .dark)
        #expect(probe.lastThemeID == DarkTheme().id)
    }

    // MARK: Switch

    @Test("DSSwitch draws the accent of the current appearance", arguments: [false, true])
    func switchUsesAccentOfAppearance(dark: Bool) async throws {
        // Outside a window, so AppKit draws the switch as active rather than
        // in the gray of an inactive window.
        let host = HostedView(DSSwitch(isOn: .constant(true)).padding(4), appearance: dark ? .darkAqua : .aqua, inWindow: false)
        try await host.settle()
        let track = try #require(host.snapshot().dominantSaturatedColor(), "switch track not drawn")

        let accent = ColorTokens.Accent.primary
        let candidates = ["light accent": accent.light, "dark accent": accent.dark]
        #expect(track.nearest(of: candidates) == (dark ? "dark accent" : "light accent"))
    }

    @Test func switchKeepsAnExplicitTint() async throws {
        let host = HostedView(DSSwitch(isOn: .constant(true), tint: .orange).padding(4), appearance: .darkAqua, inWindow: false)
        try await host.settle()
        let track = try #require(host.snapshot().dominantSaturatedColor(), "switch track not drawn")

        let accent = ColorTokens.Accent.primary
        let candidates = ["orange": Color.orange, "light accent": accent.light, "dark accent": accent.dark]
        #expect(track.nearest(of: candidates) == "orange")
    }

    // MARK: OTP field

    @Test("The focus ring sits on the box that receives the next digit", arguments: [
        ("", 0),
        ("123", 3),
        ("123456", 5)
    ])
    func otpFocusRing(code: String, focusedBox: Int) async throws {
        let length = 6
        // In a window, so the hidden text field can become first responder.
        let host = HostedView(DSOTPField(code: .constant(code), length: length), appearance: .aqua, inWindow: true)
        try await host.settle()
        let snapshot = try host.snapshot()

        // Boxes are 48 pt wide with SpacingScale.sm between them (OTPDigitBox).
        let boxWidth = 48.0
        let pitch = boxWidth + SpacingScale.sm.rawValue
        try #require(abs(snapshot.width - (Double(length) * pitch - SpacingScale.sm.rawValue)) < 1, "unexpected layout, width \(snapshot.width)")

        // Middle of each box's top border: blue when focused, gray otherwise.
        let focused = (0..<length).filter { index in
            let border = snapshot.color(atX: Double(index) * pitch + boxWidth / 2, y: BorderTokens.Width.thin / 2)
            return border.isBlue
        }
        #expect(focused == [focusedBox], "focus border found on boxes \(focused)")
    }
}

// MARK: - Helpers

/// Records what a view inside the hierarchy reads from its environment.
@MainActor
private final class EnvironmentProbe {
    private(set) var lastScheme: ColorScheme?
    private(set) var lastThemeID: String?

    var view: some View { ProbeView(probe: self) }

    fileprivate func record(scheme: ColorScheme, themeID: String) {
        lastScheme = scheme
        lastThemeID = themeID
    }

    private struct ProbeView: View {
        let probe: EnvironmentProbe
        @Environment(\.colorScheme) private var scheme
        @Environment(\.dsTheme) private var theme

        var body: some View {
            Color.clear
                .frame(width: 10, height: 10)
                .onAppear { probe.record(scheme: scheme, themeID: theme.id) }
                .onChange(of: scheme) { _, newValue in probe.record(scheme: newValue, themeID: theme.id) }
                .onChange(of: theme.id) { _, newValue in probe.record(scheme: scheme, themeID: newValue) }
        }
    }
}

/// A SwiftUI view hosted in AppKit, optionally inside an off-screen window.
@MainActor
private final class HostedView {
    private let host: NSView
    private let window: NSWindow?

    init(_ view: some View, appearance: NSAppearance.Name, inWindow: Bool) {
        host = NSHostingView(rootView: view)
        host.frame = CGRect(origin: .zero, size: host.fittingSize)
        guard inWindow else {
            window = nil
            host.appearance = NSAppearance(named: appearance)
            return
        }
        let window = NSWindow(contentRect: host.frame, styleMask: [.borderless], backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.appearance = NSAppearance(named: appearance)
        window.contentView = host
        self.window = window
    }

    func setAppearance(_ name: NSAppearance.Name) {
        if let window {
            window.appearance = NSAppearance(named: name)
        } else {
            host.appearance = NSAppearance(named: name)
        }
    }

    /// Lets SwiftUI apply state changes (focus, preferences, appearance).
    func settle() async throws {
        for _ in 0..<5 {
            host.layoutSubtreeIfNeeded()
            try await Task.sleep(for: .milliseconds(50))
        }
    }

    func snapshot() throws -> Snapshot {
        let representation = try #require(host.bitmapImageRepForCachingDisplay(in: host.bounds))
        host.cacheDisplay(in: host.bounds, to: representation)
        return Snapshot(representation: representation, width: host.bounds.width)
    }
}

/// Pixels of a hosted view.
@MainActor
private struct Snapshot {
    let representation: NSBitmapImageRep
    /// Width in points.
    let width: Double

    private var scale: Double { Double(representation.pixelsWide) / width }

    /// The color at a point, measured from the top-left corner.
    func color(atX x: Double, y: Double) -> RGB {
        rgb(atPixelX: Int(x * scale), y: Int(y * scale)) ?? RGB(red: 0, green: 0, blue: 0)
    }

    /// The most common opaque, clearly colored (not gray) pixel color.
    func dominantSaturatedColor() -> RGB? {
        var counts: [RGB: Int] = [:]
        for y in 0..<representation.pixelsHigh {
            for x in 0..<representation.pixelsWide {
                guard let pixel = rgb(atPixelX: x, y: y), pixel.saturation > 0.3 else { continue }
                counts[pixel.quantized, default: 0] += 1
            }
        }
        return counts.max { $0.value < $1.value }?.key
    }

    private func rgb(atPixelX x: Int, y: Int) -> RGB? {
        guard let color = representation.colorAt(x: x, y: y)?.usingColorSpace(.sRGB), color.alphaComponent > 0.99 else {
            return nil
        }
        return RGB(red: color.redComponent, green: color.greenComponent, blue: color.blueComponent)
    }
}

private struct RGB: Hashable {
    let red: Double
    let green: Double
    let blue: Double

    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    init(_ color: Color) {
        let resolved = NSColor(color).usingColorSpace(.sRGB) ?? .black
        self.init(red: resolved.redComponent, green: resolved.greenComponent, blue: resolved.blueComponent)
    }

    var saturation: Double { max(red, green, blue) - min(red, green, blue) }

    /// Blue clearly dominates, as in the focus border; gray borders do not.
    var isBlue: Bool { blue - max(red, green) > 0.2 }

    /// Rounded to 1/64 so neighbouring shades of the same fill count together.
    var quantized: RGB {
        RGB(red: (red * 64).rounded() / 64, green: (green * 64).rounded() / 64, blue: (blue * 64).rounded() / 64)
    }

    func distance(to other: RGB) -> Double {
        max(abs(red - other.red), abs(green - other.green), abs(blue - other.blue))
    }

    /// The name of the candidate color closest to this one.
    func nearest(of candidates: [String: Color]) -> String? {
        candidates.min { distance(to: RGB($0.value)) < distance(to: RGB($1.value)) }?.key
    }
}
#endif

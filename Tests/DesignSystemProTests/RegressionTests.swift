import CoreGraphics
import SwiftUI
import Testing
@testable import DesignSystemPro

/// Tests for bugs fixed while restoring the v2 sources (see CHANGELOG "Fixed").
@Suite("Regressions")
@MainActor
struct RegressionTests {
    @Test func themeProviderOnlyForcesSchemeForExplicitTheme() {
        let manager = ThemeManager()
        // Following the system must not pin a scheme, or dark mode never arrives.
        #expect(manager.preferredColorScheme == nil)

        manager.setTheme(DarkTheme())
        #expect(manager.preferredColorScheme == .dark)

        manager.setTheme(PresetThemes.sunset)
        #expect(manager.preferredColorScheme == nil)

        manager.setTheme(LightTheme())
        manager.toggleFollowSystem()
        #expect(manager.preferredColorScheme == nil)
    }

    @Test func buttonLoadingStateChangesAfterFirstRender() throws {
        let renderer = ImageRenderer(content: DSButton("Save") {}.loading(false))
        let idle = try #require(renderer.cgImage)

        // Same view identity, new value: a value captured in @State at first
        // render would leave the second image identical to the first.
        renderer.content = DSButton("Save") {}.loading(true)
        let loading = try #require(renderer.cgImage)

        #expect(pixels(of: idle) != pixels(of: loading))

        renderer.content = DSButton("Save") {}.loading(false)
        let idleAgain = try #require(renderer.cgImage)
        #expect(pixels(of: idleAgain) != pixels(of: loading))
    }

    @Test func switchDefaultTintFollowsColorScheme() {
        let accent = ColorTokens.Accent.primary
        #expect(DSSwitch.resolvedTint(nil, for: .light) == accent.light)
        #expect(DSSwitch.resolvedTint(nil, for: .dark) == accent.dark)
        #expect(accent.light != accent.dark)
        #expect(DSSwitch.resolvedTint(.orange, for: .dark) == .orange)
    }

    @Test("OTP focus ring sits on the next empty box", arguments: [
        (0, 6, 0),
        (3, 6, 3),
        (6, 6, 5),
        (9, 6, 5),
        (0, 1, 0)
    ])
    func otpActiveIndex(codeCount: Int, length: Int, expected: Int) {
        #expect(DSOTPField.activeIndex(codeCount: codeCount, length: length) == expected)
    }
}

/// RGBA bytes of `image` drawn into an sRGB bitmap.
@MainActor
func pixels(of image: CGImage) -> [UInt8] {
    var data = [UInt8](repeating: 0, count: image.width * image.height * 4)
    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) ?? CGColorSpaceCreateDeviceRGB()
    data.withUnsafeMutableBytes { buffer in
        let context = CGContext(
            data: buffer.baseAddress,
            width: image.width,
            height: image.height,
            bitsPerComponent: 8,
            bytesPerRow: image.width * 4,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        context?.draw(image, in: CGRect(x: 0, y: 0, width: image.width, height: image.height))
    }
    return data
}

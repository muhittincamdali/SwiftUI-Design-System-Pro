import Foundation
import ImageIO
import SwiftUI
import Testing
@testable import DesignSystemPro

@Suite("Rendering")
@MainActor
struct RenderingTests {
    /// Set to record new reference fingerprints instead of comparing.
    private static let recordVariable = "DSP_RECORD_FINGERPRINTS"
    /// Largest allowed per-channel difference of a grid cell's average color.
    private static let colorTolerance = 0.03
    /// Largest allowed difference in rendered width or height, in points.
    private static let sizeTolerance = 6

    @Test("Every gallery section matches its reference in light and dark mode", arguments: GallerySection.allCases)
    func sectionMatchesReference(section: GallerySection) throws {
        let recording = ProcessInfo.processInfo.environment[Self.recordVariable] != nil

        for scheme in [ColorScheme.light, .dark] {
            let renderer = ImageRenderer(content: GalleryFrame(colorScheme: scheme) { section.view })
            let image = try #require(renderer.cgImage, "\(section) did not render in \(scheme)")
            let fingerprint = RenderFingerprint(image: image)
            let url = Self.referenceURL(section: section, scheme: scheme)

            if recording {
                try FileManager.default.createDirectory(
                    at: url.deletingLastPathComponent(),
                    withIntermediateDirectories: true
                )
                let encoder = JSONEncoder()
                encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
                try encoder.encode(fingerprint).write(to: url)
                continue
            }

            let data = try #require(
                try? Data(contentsOf: url),
                "No reference at \(url.path); run the tests with \(Self.recordVariable)=1 to record it"
            )
            let reference = try JSONDecoder().decode(RenderFingerprint.self, from: data)
            let differences = fingerprint.differences(
                from: reference,
                colorTolerance: Self.colorTolerance,
                sizeTolerance: Self.sizeTolerance
            )
            #expect(differences.isEmpty, "\(section) in \(scheme) drifted from \(url.lastPathComponent): \(differences)")
        }
    }

    /// `Tests/RenderingReferences/<platform>/<section>-<scheme>.json`, read from
    /// the source checkout so the same files work for `swift test` and the
    /// iOS simulator.
    private static func referenceURL(section: GallerySection, scheme: ColorScheme) -> URL {
        #if os(macOS)
        let platform = "macOS"
        #elseif os(iOS)
        let platform = "iOS"
        #else
        let platform = "other"
        #endif
        return URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("RenderingReferences/\(platform)")
            .appendingPathComponent("\(section.rawValue)-\(scheme == .dark ? "dark" : "light").json")
    }

    /// Writes the README screenshots. Enabled only through
    /// `scripts/render-screenshots.sh`, which sets the output directory.
    @Test(
        "Export README screenshots",
        .enabled(if: ProcessInfo.processInfo.environment["DSP_SCREENSHOT_DIR"] != nil)
    )
    func exportScreenshots() throws {
        let directory = URL(fileURLWithPath: try #require(ProcessInfo.processInfo.environment["DSP_SCREENSHOT_DIR"]))
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)

        for section in GallerySection.allCases {
            for scheme in [ColorScheme.light, .dark] {
                let renderer = ImageRenderer(content: GalleryFrame(colorScheme: scheme) { section.view })
                renderer.scale = 2
                let image = try #require(renderer.cgImage)
                let name = "\(section.rawValue)-\(scheme == .dark ? "dark" : "light").png"
                try writePNG(image, to: directory.appendingPathComponent(name))
            }
        }
    }

    private func writePNG(_ image: CGImage, to url: URL) throws {
        let destination = try #require(CGImageDestinationCreateWithURL(url as CFURL, "public.png" as CFString, 1, nil))
        CGImageDestinationAddImage(destination, image, nil)
        #expect(CGImageDestinationFinalize(destination))
    }
}

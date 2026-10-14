import Foundation
import ImageIO
import SwiftUI
import Testing
@testable import DesignSystemPro

@Suite("Rendering")
@MainActor
struct RenderingTests {
    @Test("Every gallery section renders in light and dark mode", arguments: GallerySection.allCases)
    func sectionRenders(section: GallerySection) throws {
        for scheme in [ColorScheme.light, .dark] {
            let renderer = ImageRenderer(content: GalleryFrame(colorScheme: scheme) { section.view })
            let image = try #require(renderer.cgImage, "\(section) did not render in \(scheme)")
            #expect(image.width > 0 && image.height > 0)
        }
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

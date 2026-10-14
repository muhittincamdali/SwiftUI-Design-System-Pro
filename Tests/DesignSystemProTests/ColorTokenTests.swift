import SwiftUI
import Testing
@testable import DesignSystemPro

@Suite("Color tokens")
struct ColorTokenTests {
    @Test("Hex strings of supported lengths round-trip", arguments: [
        ("#FF0000", "#FF0000"),
        ("00ff00", "#00FF00"),
        ("#F00", "#FF0000"),
        ("2563EB", "#2563EB"),
        ("80FF0000", "#FF0000")
    ])
    func hexRoundTrip(input: String, expected: String) {
        #expect(Color(hex: input).toHex() == expected)
    }

    @Test func eightDigitHexCarriesAlpha() {
        let resolved = Color(hex: "80FF0000").resolve(in: EnvironmentValues())
        #expect(abs(Double(resolved.opacity) - 128.0 / 255.0) < 0.01)
    }

    @Test("Unsupported hex lengths give opaque black", arguments: ["", "12345", "#1234567"])
    func invalidHexIsOpaqueBlack(input: String) {
        let color = Color(hex: input)
        #expect(color.toHex() == "#000000")
        #expect(color.resolve(in: EnvironmentValues()).opacity == 1)
    }

    @Test func semanticTokenResolvesPerScheme() {
        let token = SemanticColorToken(light: .white, dark: .black, highContrast: .red)
        #expect(token.resolved(for: .light) == .white)
        #expect(token.resolved(for: .dark) == .black)
        #expect(token.resolved(for: .dark, highContrast: true) == .red)
    }

    @Test func highContrastDefaultsToLightColor() {
        let token = SemanticColorToken(light: .white, dark: .black)
        #expect(token.resolved(for: .dark, highContrast: true) == .white)
    }
}

@Suite("WCAG contrast")
struct ContrastTests {
    @Test func blackOnWhiteIsTwentyOneToOne() {
        let ratio = ColorContrastUtility.contrastRatio(.black, .white)
        #expect(abs(ratio - 21) < 0.01)
    }

    @Test func ratioIsSymmetricAndOneForEqualColors() {
        let blue = Color(hex: "#2563EB")
        #expect(ColorContrastUtility.contrastRatio(blue, blue) == 1)
        #expect(ColorContrastUtility.contrastRatio(.white, blue) == ColorContrastUtility.contrastRatio(blue, .white))
    }

    @Test func thresholdsMatchWCAGReferenceGrays() {
        // #767676 is the lightest gray that passes AA (4.54:1) on white;
        // #777777 (4.48:1) fails AA but passes the 3:1 large-text rule.
        #expect(ColorContrastUtility.meetsWCAG_AA(Color(hex: "#767676"), .white))
        #expect(!ColorContrastUtility.meetsWCAG_AA(Color(hex: "#777777"), .white))
        #expect(ColorContrastUtility.meetsWCAG_AA_LargeText(Color(hex: "#777777"), .white))
        #expect(!ColorContrastUtility.meetsWCAG_AAA(Color(hex: "#767676"), .white))
    }

    @Test("Body text tokens reach AA on the primary background", arguments: [ColorScheme.light, .dark])
    func bodyTextTokensMeetAA(scheme: ColorScheme) {
        let background = ColorTokens.Background.primary.resolved(for: scheme)
        for token in [ColorTokens.Foreground.primary, ColorTokens.Foreground.secondary] {
            let foreground = token.resolved(for: scheme)
            #expect(ColorContrastUtility.meetsWCAG_AA(foreground, background), "\(token.accessibilityLabel) in \(scheme)")
        }
    }
}

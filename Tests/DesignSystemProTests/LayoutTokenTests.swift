import SwiftUI
import Testing
@testable import DesignSystemPro

@Suite("Typography tokens")
struct TypographyTokenTests {
    @Test func largeDynamicTypeKeepsBaseSize() {
        let token = TypographyTokens.Body.medium
        #expect(token.scaledSize(for: .large) == token.size)
    }

    @Test func scaleFactorGrowsWithEveryDynamicTypeSize() {
        let factors = DynamicTypeSize.allCases.map(TypographyToken.scaleFactor(for:))
        #expect(factors == factors.sorted())
        #expect(Set(factors).count == factors.count)
    }

    @Test func accessibilitySizesFollowSystemBodyRatios() {
        // System body text is 17 pt at .large and 53 pt at .accessibility5.
        let body = TypographyToken(scale: .bodyMD)
        let expected = (body.size * 53 / 17).rounded()
        #expect(body.scaledSize(for: .accessibility5) == expected)
        #expect(body.scaledSize(for: .xSmall) < body.size)
    }

    @Test func fluidTypographyClampsAndInterpolates() {
        let fluid = FluidTypography(minSize: 16, maxSize: 32, minViewport: 300, maxViewport: 700)
        #expect(fluid.size(for: 100) == 16)
        #expect(fluid.size(for: 300) == 16)
        #expect(fluid.size(for: 500) == 24)
        #expect(fluid.size(for: 700) == 32)
        #expect(fluid.size(for: 2000) == 32)
    }
}

@Suite("Spacing, border and shadow tokens")
struct LayoutTokenTests {
    @Test func spacingScaleIsAscendingOnATwoPointGrid() {
        let values = SpacingScale.allCases.map(\.rawValue)
        #expect(values == values.sorted())
        #expect(values.allSatisfy { $0.truncatingRemainder(dividingBy: 2) == 0 })
    }

    @Test func elevationMapsToIncreasingShadows() {
        #expect(Elevation.level0.shadow == ShadowTokens.none)
        let radii = Elevation.allCases.map { $0.shadow.layers.map(\.radius).max() ?? 0 }
        #expect(radii == radii.sorted())
        #expect(Elevation.level3.zIndex == 300)
    }

    @Test func darkModeShadowsAreStrongerButCapped() {
        let shadow = MultiLayerShadow(name: "test", layers: [
            ShadowToken(radius: 10, y: 4, opacity: 0.2),
            ShadowToken(radius: 20, y: 8, opacity: 0.8)
        ])
        let dark = ShadowTokens.forDarkMode(shadow)
        #expect(dark.name == "test_dark")
        #expect(abs(dark.layers[0].opacity - 0.3) < 0.0001)
        #expect(dark.layers[1].opacity == 1)
        #expect(dark.layers[0].radius == 12)
    }
}

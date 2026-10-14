import SwiftUI
import Testing
@testable import DesignSystemPro

@Suite("Theme engine")
@MainActor
struct ThemeTests {
    @Test func followsSystemColorSchemeByDefault() {
        let manager = ThemeManager()
        #expect(manager.followSystem)
        #expect(manager.resolvedTheme(for: .light).id == "light")
        #expect(manager.resolvedTheme(for: .dark).id == "dark")
    }

    @Test func explicitThemeOverridesSystemScheme() {
        let manager = ThemeManager()
        manager.setTheme(PresetThemes.ocean)
        #expect(!manager.followSystem)
        #expect(manager.resolvedTheme(for: .dark).id == "ocean")
        #expect(manager.resolvedTheme(for: .light).id == "ocean")
    }

    @Test func togglingFollowSystemReturnsToSystemTheme() {
        let manager = ThemeManager()
        manager.setTheme(PresetThemes.forest)
        manager.toggleFollowSystem()
        #expect(manager.resolvedTheme(for: .dark).id == "dark")
    }

    @Test func builtInThemesDeclareTheirColorScheme() {
        #expect(LightTheme().colorScheme == .light)
        #expect(DarkTheme().colorScheme == .dark)
        #expect(PresetThemes.sunset.colorScheme == nil)
    }

    @Test func brandConfigurationFeedsAccentAndRadius() {
        let brand = BrandConfiguration(primaryColor: .purple, secondaryColor: .pink, borderRadius: 12)
        let light = brand.generateTheme(id: "acme", name: "Acme")
        let dark = brand.generateTheme(id: "acme-dark", name: "Acme Dark", colorScheme: .dark)

        #expect(light.colors.accent == .purple)
        #expect(light.colors.borderFocus == .purple)
        #expect(light.borders.radiusMedium == 12)
        #expect(dark.colorScheme == .dark)
        #expect(dark.colors.backgroundPrimary != light.colors.backgroundPrimary)
    }

    @Test func whiteLabelBuildsLightAndDarkThemes() {
        let config = WhiteLabelConfiguration(
            brand: BrandConfiguration(primaryColor: .green, secondaryColor: .mint),
            appName: "Acme"
        )
        #expect(config.lightTheme.id == "acme-light")
        #expect(config.darkTheme.id == "acme-dark")
        #expect(config.darkTheme.name == "Acme Dark")
    }

    @Test func configureAppliesExplicitTheme() {
        DesignSystemPro.configure(theme: DarkTheme(), followSystemColorScheme: false)
        #expect(ThemeManager.shared.resolvedTheme(for: .light).id == "dark")
        DesignSystemPro.configure()
        #expect(ThemeManager.shared.resolvedTheme(for: .light).id == "light")
    }
}

# Theming

Choose between system-driven light and dark themes, presets and brand themes.

## Overview

A theme is a value conforming to ``DSTheme``. It bundles ``ThemeColors``,
``ThemeTypography``, ``ThemeSpacing``, ``ThemeBorders``, ``ThemeShadows`` and
``ThemeAnimations``. ``DSThemeProvider`` (installed by ``DSApp``) puts the
active theme into the environment:

```swift
struct ProfileHeader: View {
    @Environment(\.dsTheme) private var theme

    var body: some View {
        Text("Profile")
            .foregroundStyle(theme.colors.accent)
    }
}
```

The built-in components use color tokens directly and are not restyled by the
theme.

## Following the system or forcing a theme

``ThemeManager`` follows the system color scheme by default and returns
``LightTheme`` or ``DarkTheme``. Setting a theme stops following the system and
forces that theme's color scheme:

```swift
ThemeManager.shared.setTheme(PresetThemes.ocean)
ThemeManager.shared.toggleFollowSystem() // back to light/dark from the system
```

`DesignSystemPro.configure(theme:followSystemColorScheme:)` does the same at
launch.

## Brand and white-label themes

``BrandConfiguration`` turns brand colors and a corner radius into a
``CustomTheme``; ``WhiteLabelConfiguration`` builds a light and a dark variant
with ids derived from the app name:

```swift
let brand = BrandConfiguration(primaryColor: .purple, secondaryColor: .pink, borderRadius: 12)
let whiteLabel = WhiteLabelConfiguration(brand: brand, appName: "Acme")
ThemeManager.shared.setTheme(whiteLabel.darkTheme) // id "acme-dark"
```

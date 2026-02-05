// ThemeEngine.swift
// DesignSystemPro
//
// Production-grade theme engine with dynamic theming,
// brand customization, and white-label support.

import SwiftUI
import Combine

// MARK: - Theme Protocol

/// Protocol that all themes must conform to
public protocol DSTheme: Identifiable, Equatable, Sendable {
    var id: String { get }
    var name: String { get }
    var colorScheme: ColorScheme? { get }
    
    // Colors
    var colors: ThemeColors { get }
    
    // Typography
    var typography: ThemeTypography { get }
    
    // Spacing
    var spacing: ThemeSpacing { get }
    
    // Borders
    var borders: ThemeBorders { get }
    
    // Shadows
    var shadows: ThemeShadows { get }
    
    // Animations
    var animations: ThemeAnimations { get }
}

// MARK: - Theme Color Configuration

public struct ThemeColors: Sendable, Equatable {
    // Background
    public let backgroundPrimary: Color
    public let backgroundSecondary: Color
    public let backgroundTertiary: Color
    public let backgroundElevated: Color
    
    // Foreground
    public let foregroundPrimary: Color
    public let foregroundSecondary: Color
    public let foregroundTertiary: Color
    
    // Accent
    public let accent: Color
    public let accentSecondary: Color
    
    // Status
    public let success: Color
    public let warning: Color
    public let error: Color
    public let info: Color
    
    // Border
    public let border: Color
    public let borderFocus: Color
    
    public init(
        backgroundPrimary: Color = .white,
        backgroundSecondary: Color = Color(hex: "#F5F5F5"),
        backgroundTertiary: Color = Color(hex: "#EEEEEE"),
        backgroundElevated: Color = .white,
        foregroundPrimary: Color = Color(hex: "#212121"),
        foregroundSecondary: Color = Color(hex: "#757575"),
        foregroundTertiary: Color = Color(hex: "#9E9E9E"),
        accent: Color = Color(hex: "#2563EB"),
        accentSecondary: Color = Color(hex: "#9333EA"),
        success: Color = Color(hex: "#16A34A"),
        warning: Color = Color(hex: "#D97706"),
        error: Color = Color(hex: "#DC2626"),
        info: Color = Color(hex: "#2563EB"),
        border: Color = Color(hex: "#E0E0E0"),
        borderFocus: Color = Color(hex: "#3B82F6")
    ) {
        self.backgroundPrimary = backgroundPrimary
        self.backgroundSecondary = backgroundSecondary
        self.backgroundTertiary = backgroundTertiary
        self.backgroundElevated = backgroundElevated
        self.foregroundPrimary = foregroundPrimary
        self.foregroundSecondary = foregroundSecondary
        self.foregroundTertiary = foregroundTertiary
        self.accent = accent
        self.accentSecondary = accentSecondary
        self.success = success
        self.warning = warning
        self.error = error
        self.info = info
        self.border = border
        self.borderFocus = borderFocus
    }
}

// MARK: - Theme Typography Configuration

public struct ThemeTypography: Sendable, Equatable {
    public let fontFamily: String?
    public let headingWeight: Font.Weight
    public let bodyWeight: Font.Weight
    public let monospaceFontFamily: String?
    
    public init(
        fontFamily: String? = nil,
        headingWeight: Font.Weight = .semibold,
        bodyWeight: Font.Weight = .regular,
        monospaceFontFamily: String? = nil
    ) {
        self.fontFamily = fontFamily
        self.headingWeight = headingWeight
        self.bodyWeight = bodyWeight
        self.monospaceFontFamily = monospaceFontFamily
    }
}

// MARK: - Theme Spacing Configuration

public struct ThemeSpacing: Sendable, Equatable {
    public let baseUnit: CGFloat
    public let componentPadding: CGFloat
    public let screenEdge: CGFloat
    public let sectionGap: CGFloat
    
    public init(
        baseUnit: CGFloat = 8,
        componentPadding: CGFloat = 16,
        screenEdge: CGFloat = 16,
        sectionGap: CGFloat = 24
    ) {
        self.baseUnit = baseUnit
        self.componentPadding = componentPadding
        self.screenEdge = screenEdge
        self.sectionGap = sectionGap
    }
    
    public func spacing(_ multiplier: CGFloat) -> CGFloat {
        baseUnit * multiplier
    }
}

// MARK: - Theme Borders Configuration

public struct ThemeBorders: Sendable, Equatable {
    public let radiusSmall: CGFloat
    public let radiusMedium: CGFloat
    public let radiusLarge: CGFloat
    public let radiusXLarge: CGFloat
    public let widthThin: CGFloat
    public let widthMedium: CGFloat
    
    public init(
        radiusSmall: CGFloat = 4,
        radiusMedium: CGFloat = 8,
        radiusLarge: CGFloat = 12,
        radiusXLarge: CGFloat = 16,
        widthThin: CGFloat = 1,
        widthMedium: CGFloat = 2
    ) {
        self.radiusSmall = radiusSmall
        self.radiusMedium = radiusMedium
        self.radiusLarge = radiusLarge
        self.radiusXLarge = radiusXLarge
        self.widthThin = widthThin
        self.widthMedium = widthMedium
    }
}

// MARK: - Theme Shadows Configuration

public struct ThemeShadows: Sendable, Equatable {
    public let small: MultiLayerShadow
    public let medium: MultiLayerShadow
    public let large: MultiLayerShadow
    
    public init(
        small: MultiLayerShadow = ShadowTokens.sm,
        medium: MultiLayerShadow = ShadowTokens.md,
        large: MultiLayerShadow = ShadowTokens.lg
    ) {
        self.small = small
        self.medium = medium
        self.large = large
    }
}

// MARK: - Theme Animations Configuration

public struct ThemeAnimations: Sendable, Equatable {
    public let defaultDuration: Double
    public let fastDuration: Double
    public let slowDuration: Double
    public let defaultSpring: SpringConfig
    
    public init(
        defaultDuration: Double = 0.2,
        fastDuration: Double = 0.1,
        slowDuration: Double = 0.4,
        defaultSpring: SpringConfig = .default
    ) {
        self.defaultDuration = defaultDuration
        self.fastDuration = fastDuration
        self.slowDuration = slowDuration
        self.defaultSpring = defaultSpring
    }
}

// MARK: - Default Light Theme

public struct LightTheme: DSTheme {
    public let id = "light"
    public let name = "Light"
    public let colorScheme: ColorScheme? = .light
    
    public let colors = ThemeColors()
    public let typography = ThemeTypography()
    public let spacing = ThemeSpacing()
    public let borders = ThemeBorders()
    public let shadows = ThemeShadows()
    public let animations = ThemeAnimations()
    
    public init() {}
}

// MARK: - Default Dark Theme

public struct DarkTheme: DSTheme {
    public let id = "dark"
    public let name = "Dark"
    public let colorScheme: ColorScheme? = .dark
    
    public let colors: ThemeColors
    public let typography = ThemeTypography()
    public let spacing = ThemeSpacing()
    public let borders = ThemeBorders()
    public let shadows: ThemeShadows
    public let animations = ThemeAnimations()
    
    public init() {
        self.colors = ThemeColors(
            backgroundPrimary: Color(hex: "#121212"),
            backgroundSecondary: Color(hex: "#1E1E1E"),
            backgroundTertiary: Color(hex: "#2D2D2D"),
            backgroundElevated: Color(hex: "#1E1E1E"),
            foregroundPrimary: Color(hex: "#FFFFFF"),
            foregroundSecondary: Color(hex: "#B3B3B3"),
            foregroundTertiary: Color(hex: "#808080"),
            accent: Color(hex: "#60A5FA"),
            accentSecondary: Color(hex: "#C084FC"),
            success: Color(hex: "#4ADE80"),
            warning: Color(hex: "#FBBF24"),
            error: Color(hex: "#F87171"),
            info: Color(hex: "#60A5FA"),
            border: Color(hex: "#404040"),
            borderFocus: Color(hex: "#60A5FA")
        )
        
        self.shadows = ThemeShadows(
            small: ShadowTokens.forDarkMode(ShadowTokens.sm),
            medium: ShadowTokens.forDarkMode(ShadowTokens.md),
            large: ShadowTokens.forDarkMode(ShadowTokens.lg)
        )
    }
}

// MARK: - Custom Theme Builder

public struct CustomTheme: DSTheme {
    public let id: String
    public let name: String
    public let colorScheme: ColorScheme?
    public let colors: ThemeColors
    public let typography: ThemeTypography
    public let spacing: ThemeSpacing
    public let borders: ThemeBorders
    public let shadows: ThemeShadows
    public let animations: ThemeAnimations
    
    public init(
        id: String,
        name: String,
        colorScheme: ColorScheme? = nil,
        colors: ThemeColors = ThemeColors(),
        typography: ThemeTypography = ThemeTypography(),
        spacing: ThemeSpacing = ThemeSpacing(),
        borders: ThemeBorders = ThemeBorders(),
        shadows: ThemeShadows = ThemeShadows(),
        animations: ThemeAnimations = ThemeAnimations()
    ) {
        self.id = id
        self.name = name
        self.colorScheme = colorScheme
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.borders = borders
        self.shadows = shadows
        self.animations = animations
    }
}

// MARK: - Theme Manager

@MainActor
public final class ThemeManager: ObservableObject {
    public static let shared = ThemeManager()
    
    @Published public private(set) var currentTheme: any DSTheme = LightTheme()
    @Published public var followSystem: Bool = true
    
    private var systemColorScheme: ColorScheme = .light
    
    private init() {}
    
    public func setTheme(_ theme: any DSTheme) {
        currentTheme = theme
        followSystem = false
    }
    
    public func updateSystemColorScheme(_ colorScheme: ColorScheme) {
        systemColorScheme = colorScheme
        if followSystem {
            currentTheme = colorScheme == .dark ? DarkTheme() : LightTheme()
        }
    }
    
    public func toggleFollowSystem() {
        followSystem.toggle()
        if followSystem {
            currentTheme = systemColorScheme == .dark ? DarkTheme() : LightTheme()
        }
    }
}

// MARK: - Theme Environment Key

private struct ThemeKey: EnvironmentKey {
    static let defaultValue: any DSTheme = LightTheme()
}

extension EnvironmentValues {
    public var dsTheme: any DSTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// MARK: - Theme Provider View

public struct DSThemeProvider<Content: View>: View {
    @StateObject private var themeManager = ThemeManager.shared
    @Environment(\.colorScheme) private var systemColorScheme
    
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .environment(\.dsTheme, themeManager.currentTheme)
            .preferredColorScheme(themeManager.currentTheme.colorScheme)
            .onChange(of: systemColorScheme) { _, newScheme in
                themeManager.updateSystemColorScheme(newScheme)
            }
    }
}

// MARK: - Theme Modifier

public struct DSThemeModifier: ViewModifier {
    @Environment(\.dsTheme) private var theme
    
    public func body(content: Content) -> some View {
        content
            .background(theme.colors.backgroundPrimary)
            .foregroundColor(theme.colors.foregroundPrimary)
    }
}

extension View {
    /// Apply the current theme's default styling
    public func dsThemedSurface() -> some View {
        self.modifier(DSThemeModifier())
    }
}

// MARK: - Brand Configuration

public struct BrandConfiguration: Sendable {
    public let primaryColor: Color
    public let secondaryColor: Color
    public let logoImage: String?
    public let fontFamily: String?
    public let borderRadius: CGFloat
    
    public init(
        primaryColor: Color,
        secondaryColor: Color,
        logoImage: String? = nil,
        fontFamily: String? = nil,
        borderRadius: CGFloat = 8
    ) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.logoImage = logoImage
        self.fontFamily = fontFamily
        self.borderRadius = borderRadius
    }
    
    /// Generate a theme from brand configuration
    public func generateTheme(
        id: String,
        name: String,
        colorScheme: ColorScheme = .light
    ) -> CustomTheme {
        let colors: ThemeColors
        
        if colorScheme == .dark {
            colors = ThemeColors(
                backgroundPrimary: Color(hex: "#121212"),
                backgroundSecondary: Color(hex: "#1E1E1E"),
                backgroundTertiary: Color(hex: "#2D2D2D"),
                backgroundElevated: Color(hex: "#1E1E1E"),
                foregroundPrimary: .white,
                foregroundSecondary: Color(hex: "#B3B3B3"),
                foregroundTertiary: Color(hex: "#808080"),
                accent: primaryColor,
                accentSecondary: secondaryColor,
                success: Color(hex: "#4ADE80"),
                warning: Color(hex: "#FBBF24"),
                error: Color(hex: "#F87171"),
                info: primaryColor,
                border: Color(hex: "#404040"),
                borderFocus: primaryColor
            )
        } else {
            colors = ThemeColors(
                accent: primaryColor,
                accentSecondary: secondaryColor,
                info: primaryColor,
                borderFocus: primaryColor
            )
        }
        
        return CustomTheme(
            id: id,
            name: name,
            colorScheme: colorScheme,
            colors: colors,
            typography: ThemeTypography(fontFamily: fontFamily),
            borders: ThemeBorders(radiusMedium: borderRadius)
        )
    }
}

// MARK: - White Label Support

public struct WhiteLabelConfiguration {
    public let brand: BrandConfiguration
    public let appName: String
    public let lightTheme: CustomTheme
    public let darkTheme: CustomTheme
    
    public init(
        brand: BrandConfiguration,
        appName: String
    ) {
        self.brand = brand
        self.appName = appName
        self.lightTheme = brand.generateTheme(
            id: "\(appName.lowercased())-light",
            name: "\(appName) Light",
            colorScheme: .light
        )
        self.darkTheme = brand.generateTheme(
            id: "\(appName.lowercased())-dark",
            name: "\(appName) Dark",
            colorScheme: .dark
        )
    }
}

// MARK: - Preset Themes

public enum PresetThemes {
    public static let light = LightTheme()
    public static let dark = DarkTheme()
    
    public static let ocean = CustomTheme(
        id: "ocean",
        name: "Ocean",
        colors: ThemeColors(
            accent: Color(hex: "#0891B2"),
            accentSecondary: Color(hex: "#0E7490")
        )
    )
    
    public static let forest = CustomTheme(
        id: "forest",
        name: "Forest",
        colors: ThemeColors(
            accent: Color(hex: "#059669"),
            accentSecondary: Color(hex: "#047857")
        )
    )
    
    public static let sunset = CustomTheme(
        id: "sunset",
        name: "Sunset",
        colors: ThemeColors(
            accent: Color(hex: "#EA580C"),
            accentSecondary: Color(hex: "#DC2626")
        )
    )
    
    public static let lavender = CustomTheme(
        id: "lavender",
        name: "Lavender",
        colors: ThemeColors(
            accent: Color(hex: "#8B5CF6"),
            accentSecondary: Color(hex: "#A855F7")
        )
    )
}

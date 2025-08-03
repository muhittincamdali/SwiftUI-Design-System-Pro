import SwiftUI

/**
 * Design System Theme
 * 
 * Comprehensive theme system for SwiftUI Design System Pro
 * supporting dark/light modes, custom themes, and brand integration.
 */
public struct DSTheme {
    public let colors: DSColors
    public let typography: DSTypography
    public let spacing: DSSpacing
    public let animations: DSAnimations
    
    public init(
        colors: DSColors = DSColors(),
        typography: DSTypography = DSTypography(),
        spacing: DSSpacing = DSSpacing(),
        animations: DSAnimations = DSAnimations()
    ) {
        self.colors = colors
        self.typography = typography
        self.spacing = spacing
        self.animations = animations
    }
    
    public static let light = DSTheme(
        colors: DSColors.light,
        typography: DSTypography(),
        spacing: DSSpacing(),
        animations: DSAnimations()
    )
    
    public static let dark = DSTheme(
        colors: DSColors.dark,
        typography: DSTypography(),
        spacing: DSSpacing(),
        animations: DSAnimations()
    )
}

/**
 * Design System Colors
 */
public struct DSColors {
    public let primary: Color
    public let secondary: Color
    public let accent: Color
    public let background: Color
    public let surface: Color
    public let text: Color
    public let textSecondary: Color
    public let success: Color
    public let warning: Color
    public let error: Color
    public let info: Color
    
    public init(
        primary: Color = .blue,
        secondary: Color = .gray,
        accent: Color = .orange,
        background: Color = .white,
        surface: Color = Color(.systemGray6),
        text: Color = .black,
        textSecondary: Color = .gray,
        success: Color = .green,
        warning: Color = .orange,
        error: Color = .red,
        info: Color = .cyan
    ) {
        self.primary = primary
        self.secondary = secondary
        self.accent = accent
        self.background = background
        self.surface = surface
        self.text = text
        self.textSecondary = textSecondary
        self.success = success
        self.warning = warning
        self.error = error
        self.info = info
    }
    
    public static let light = DSColors(
        primary: .blue,
        secondary: .gray,
        accent: .orange,
        background: .white,
        surface: Color(.systemGray6),
        text: .black,
        textSecondary: .gray,
        success: .green,
        warning: .orange,
        error: .red,
        info: .cyan
    )
    
    public static let dark = DSColors(
        primary: .blue,
        secondary: .gray,
        accent: .orange,
        background: .black,
        surface: Color(.systemGray5),
        text: .white,
        textSecondary: .gray,
        success: .green,
        warning: .orange,
        error: .red,
        info: .cyan
    )
}

/**
 * Design System Typography
 */
public struct DSTypography {
    public let largeTitle: Font
    public let title1: Font
    public let title2: Font
    public let title3: Font
    public let headline: Font
    public let body: Font
    public let callout: Font
    public let subheadline: Font
    public let footnote: Font
    public let caption1: Font
    public let caption2: Font
    
    public init() {
        self.largeTitle = .largeTitle
        self.title1 = .title
        self.title2 = .title2
        self.title3 = .title3
        self.headline = .headline
        self.body = .body
        self.callout = .callout
        self.subheadline = .subheadline
        self.footnote = .footnote
        self.caption1 = .caption
        self.caption2 = .caption2
    }
}

/**
 * Design System Spacing
 */
public struct DSSpacing {
    public let xs: CGFloat
    public let sm: CGFloat
    public let md: CGFloat
    public let lg: CGFloat
    public let xl: CGFloat
    public let xxl: CGFloat
    
    public init(
        xs: CGFloat = 4,
        sm: CGFloat = 8,
        md: CGFloat = 16,
        lg: CGFloat = 24,
        xl: CGFloat = 32,
        xxl: CGFloat = 48
    ) {
        self.xs = xs
        self.sm = sm
        self.md = md
        self.lg = lg
        self.xl = xl
        self.xxl = xxl
    }
}

/**
 * Design System Animations
 */
public struct DSAnimations {
    public let spring: Animation
    public let easeInOut: Animation
    public let easeIn: Animation
    public let easeOut: Animation
    public let bounce: Animation
    public let slide: Animation
    
    public init() {
        self.spring = .spring(response: 0.6, dampingFraction: 0.8)
        self.easeInOut = .easeInOut(duration: 0.3)
        self.easeIn = .easeIn(duration: 0.3)
        self.easeOut = .easeOut(duration: 0.3)
        self.bounce = .interpolatingSpring(stiffness: 100, damping: 10)
        self.slide = .easeInOut(duration: 0.4)
    }
}

// MARK: - Environment Values

private struct DSThemeKey: EnvironmentKey {
    static let defaultValue = DSTheme.light
}

extension EnvironmentValues {
    public var dsTheme: DSTheme {
        get { self[DSThemeKey.self] }
        set { self[DSThemeKey.self] = newValue }
    }
}

// MARK: - View Extensions

extension View {
    /**
     * Apply design system theme to a view
     */
    public func theme(_ theme: DSTheme) -> some View {
        self.environment(\.dsTheme, theme)
    }
    
    /**
     * Apply light theme
     */
    public func lightTheme() -> some View {
        self.theme(.light)
    }
    
    /**
     * Apply dark theme
     */
    public func darkTheme() -> some View {
        self.theme(.dark)
    }
} 
// TypographyTokens.swift
// DesignSystemPro
//
// Production-grade typography system with type scale,
// font weights, line heights, and accessibility support.

import SwiftUI

// MARK: - Font Weight Tokens

public enum DSFontWeight: CaseIterable, Sendable {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
    
    public var swiftUIWeight: Font.Weight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        }
    }
    
    public var rawValue: Int {
        switch self {
        case .ultraLight: return 100
        case .thin: return 200
        case .light: return 300
        case .regular: return 400
        case .medium: return 500
        case .semibold: return 600
        case .bold: return 700
        case .heavy: return 800
        case .black: return 900
        }
    }
}

// MARK: - Font Design Tokens

public enum DSFontDesign: CaseIterable, Sendable {
    case `default`
    case rounded
    case serif
    case monospaced
    
    public var swiftUIDesign: Font.Design {
        switch self {
        case .default: return .default
        case .rounded: return .rounded
        case .serif: return .serif
        case .monospaced: return .monospaced
        }
    }
}

// MARK: - Type Scale

/// Type scale based on a modular scale (1.25 ratio - Major Third)
/// Base size: 16pt
public enum TypeScale: CaseIterable, Sendable {
    case display2XL  // 72pt - Hero headlines
    case displayXL   // 60pt - Page titles
    case displayLG   // 48pt - Section headers
    case displayMD   // 36pt - Subsection headers
    case displaySM   // 30pt - Card titles
    case headingXL   // 24pt - Large headings
    case headingLG   // 20pt - Standard headings
    case headingMD   // 18pt - Subheadings
    case headingSM   // 16pt - Small headings
    case bodyLG      // 18pt - Large body text
    case bodyMD      // 16pt - Standard body text (base)
    case bodySM      // 14pt - Small body text
    case bodyXS      // 12pt - Extra small body
    case caption     // 12pt - Captions
    case overline    // 10pt - Overline text
    case micro       // 9pt  - Micro text (badges, etc.)
    
    public var size: CGFloat {
        switch self {
        case .display2XL: return 72
        case .displayXL: return 60
        case .displayLG: return 48
        case .displayMD: return 36
        case .displaySM: return 30
        case .headingXL: return 24
        case .headingLG: return 20
        case .headingMD: return 18
        case .headingSM: return 16
        case .bodyLG: return 18
        case .bodyMD: return 16
        case .bodySM: return 14
        case .bodyXS: return 12
        case .caption: return 12
        case .overline: return 10
        case .micro: return 9
        }
    }
    
    public var lineHeight: CGFloat {
        switch self {
        case .display2XL: return 80
        case .displayXL: return 68
        case .displayLG: return 56
        case .displayMD: return 44
        case .displaySM: return 38
        case .headingXL: return 32
        case .headingLG: return 28
        case .headingMD: return 26
        case .headingSM: return 24
        case .bodyLG: return 28
        case .bodyMD: return 24
        case .bodySM: return 20
        case .bodyXS: return 18
        case .caption: return 16
        case .overline: return 14
        case .micro: return 12
        }
    }
    
    public var letterSpacing: CGFloat {
        switch self {
        case .display2XL: return -2
        case .displayXL: return -1.5
        case .displayLG: return -1
        case .displayMD: return -0.75
        case .displaySM: return -0.5
        case .headingXL: return -0.25
        case .headingLG: return -0.2
        case .headingMD: return -0.15
        case .headingSM: return 0
        case .bodyLG: return 0
        case .bodyMD: return 0
        case .bodySM: return 0.1
        case .bodyXS: return 0.2
        case .caption: return 0.3
        case .overline: return 0.8
        case .micro: return 0.5
        }
    }
    
    public var defaultWeight: DSFontWeight {
        switch self {
        case .display2XL, .displayXL, .displayLG: return .bold
        case .displayMD, .displaySM: return .semibold
        case .headingXL, .headingLG, .headingMD, .headingSM: return .semibold
        case .bodyLG, .bodyMD, .bodySM, .bodyXS: return .regular
        case .caption: return .regular
        case .overline: return .medium
        case .micro: return .medium
        }
    }
}

// MARK: - Typography Token

public struct TypographyToken: Sendable {
    public let scale: TypeScale
    public let weight: DSFontWeight
    public let design: DSFontDesign
    public let isUppercased: Bool
    
    public init(
        scale: TypeScale,
        weight: DSFontWeight? = nil,
        design: DSFontDesign = .default,
        isUppercased: Bool = false
    ) {
        self.scale = scale
        self.weight = weight ?? scale.defaultWeight
        self.design = design
        self.isUppercased = isUppercased
    }
    
    public var font: Font {
        Font.system(
            size: scale.size,
            weight: weight.swiftUIWeight,
            design: design.swiftUIDesign
        )
    }
    
    public var size: CGFloat { scale.size }
    public var lineHeight: CGFloat { scale.lineHeight }
    public var letterSpacing: CGFloat { scale.letterSpacing }
}

// MARK: - Typography Tokens Namespace

public enum TypographyTokens {
    
    // MARK: - Display Styles
    public enum Display {
        public static let hero = TypographyToken(scale: .display2XL, weight: .bold)
        public static let title = TypographyToken(scale: .displayXL, weight: .bold)
        public static let large = TypographyToken(scale: .displayLG, weight: .semibold)
        public static let medium = TypographyToken(scale: .displayMD, weight: .semibold)
        public static let small = TypographyToken(scale: .displaySM, weight: .semibold)
    }
    
    // MARK: - Heading Styles
    public enum Heading {
        public static let h1 = TypographyToken(scale: .headingXL, weight: .bold)
        public static let h2 = TypographyToken(scale: .headingLG, weight: .semibold)
        public static let h3 = TypographyToken(scale: .headingMD, weight: .semibold)
        public static let h4 = TypographyToken(scale: .headingSM, weight: .medium)
    }
    
    // MARK: - Body Styles
    public enum Body {
        public static let large = TypographyToken(scale: .bodyLG, weight: .regular)
        public static let largeStrong = TypographyToken(scale: .bodyLG, weight: .semibold)
        public static let medium = TypographyToken(scale: .bodyMD, weight: .regular)
        public static let mediumStrong = TypographyToken(scale: .bodyMD, weight: .semibold)
        public static let small = TypographyToken(scale: .bodySM, weight: .regular)
        public static let smallStrong = TypographyToken(scale: .bodySM, weight: .medium)
        public static let extraSmall = TypographyToken(scale: .bodyXS, weight: .regular)
    }
    
    // MARK: - UI Text Styles
    public enum UI {
        public static let label = TypographyToken(scale: .bodySM, weight: .medium)
        public static let labelSmall = TypographyToken(scale: .bodyXS, weight: .medium)
        public static let button = TypographyToken(scale: .bodySM, weight: .semibold)
        public static let buttonSmall = TypographyToken(scale: .bodyXS, weight: .semibold)
        public static let caption = TypographyToken(scale: .caption, weight: .regular)
        public static let captionStrong = TypographyToken(scale: .caption, weight: .medium)
        public static let overline = TypographyToken(scale: .overline, weight: .medium, isUppercased: true)
        public static let badge = TypographyToken(scale: .micro, weight: .semibold)
    }
    
    // MARK: - Code/Mono Styles
    public enum Code {
        public static let large = TypographyToken(scale: .bodyLG, weight: .regular, design: .monospaced)
        public static let medium = TypographyToken(scale: .bodyMD, weight: .regular, design: .monospaced)
        public static let small = TypographyToken(scale: .bodySM, weight: .regular, design: .monospaced)
    }
}

// MARK: - Typography View Modifier

public struct DSTypographyModifier: ViewModifier {
    let token: TypographyToken
    @Environment(\.sizeCategory) private var sizeCategory
    
    public func body(content: Content) -> some View {
        content
            .font(token.font)
            .lineSpacing(lineSpacing)
            .tracking(token.letterSpacing)
            .textCase(token.isUppercased ? .uppercase : nil)
    }
    
    private var lineSpacing: CGFloat {
        // Calculate line spacing from line height
        // lineHeight - fontSize = total extra space
        // Divide by 2 because lineSpacing adds space both above and below
        max(0, (token.lineHeight - token.size) / 2)
    }
}

// MARK: - View Extension

extension View {
    /// Apply a typography token to this view
    public func dsTypography(_ token: TypographyToken) -> some View {
        self.modifier(DSTypographyModifier(token: token))
    }
    
    /// Apply display typography
    public func dsDisplayStyle(_ style: DisplayStyle) -> some View {
        switch style {
        case .hero: return AnyView(self.dsTypography(TypographyTokens.Display.hero))
        case .title: return AnyView(self.dsTypography(TypographyTokens.Display.title))
        case .large: return AnyView(self.dsTypography(TypographyTokens.Display.large))
        case .medium: return AnyView(self.dsTypography(TypographyTokens.Display.medium))
        case .small: return AnyView(self.dsTypography(TypographyTokens.Display.small))
        }
    }
    
    /// Apply heading typography
    public func dsHeadingStyle(_ level: HeadingLevel) -> some View {
        switch level {
        case .h1: return AnyView(self.dsTypography(TypographyTokens.Heading.h1))
        case .h2: return AnyView(self.dsTypography(TypographyTokens.Heading.h2))
        case .h3: return AnyView(self.dsTypography(TypographyTokens.Heading.h3))
        case .h4: return AnyView(self.dsTypography(TypographyTokens.Heading.h4))
        }
    }
    
    /// Apply body typography
    public func dsBodyStyle(_ style: BodyStyle) -> some View {
        switch style {
        case .large: return AnyView(self.dsTypography(TypographyTokens.Body.large))
        case .medium: return AnyView(self.dsTypography(TypographyTokens.Body.medium))
        case .small: return AnyView(self.dsTypography(TypographyTokens.Body.small))
        case .extraSmall: return AnyView(self.dsTypography(TypographyTokens.Body.extraSmall))
        }
    }
}

// MARK: - Style Enums for Convenience

public enum DisplayStyle {
    case hero, title, large, medium, small
}

public enum HeadingLevel {
    case h1, h2, h3, h4
}

public enum BodyStyle {
    case large, medium, small, extraSmall
}

// MARK: - Custom Font Support

public struct CustomFontFamily: Sendable {
    public let name: String
    public let weights: [DSFontWeight: String]
    
    public init(name: String, weights: [DSFontWeight: String] = [:]) {
        self.name = name
        self.weights = weights
    }
    
    public func fontName(for weight: DSFontWeight) -> String {
        weights[weight] ?? name
    }
}

extension TypographyToken {
    /// Create a font using a custom font family
    public func font(using family: CustomFontFamily) -> Font {
        let fontName = family.fontName(for: weight)
        return Font.custom(fontName, size: scale.size)
    }
}

// MARK: - Fluid Typography

/// Fluid typography that scales between min and max based on viewport
public struct FluidTypography {
    public let minSize: CGFloat
    public let maxSize: CGFloat
    public let minViewport: CGFloat
    public let maxViewport: CGFloat
    
    public init(
        minSize: CGFloat,
        maxSize: CGFloat,
        minViewport: CGFloat = 320,
        maxViewport: CGFloat = 1200
    ) {
        self.minSize = minSize
        self.maxSize = maxSize
        self.minViewport = minViewport
        self.maxViewport = maxViewport
    }
    
    public func size(for viewportWidth: CGFloat) -> CGFloat {
        guard viewportWidth > minViewport else { return minSize }
        guard viewportWidth < maxViewport else { return maxSize }
        
        let progress = (viewportWidth - minViewport) / (maxViewport - minViewport)
        return minSize + (maxSize - minSize) * progress
    }
}

// MARK: - Text Style Protocol

public protocol DSTextStyle {
    var typography: TypographyToken { get }
    var color: SemanticColorToken { get }
}

public struct TextStyleToken: DSTextStyle {
    public let typography: TypographyToken
    public let color: SemanticColorToken
    
    public init(typography: TypographyToken, color: SemanticColorToken) {
        self.typography = typography
        self.color = color
    }
}

// MARK: - Predefined Text Styles

public enum TextStyles {
    public static let title = TextStyleToken(
        typography: TypographyTokens.Heading.h1,
        color: ColorTokens.Foreground.primary
    )
    
    public static let subtitle = TextStyleToken(
        typography: TypographyTokens.Heading.h3,
        color: ColorTokens.Foreground.secondary
    )
    
    public static let body = TextStyleToken(
        typography: TypographyTokens.Body.medium,
        color: ColorTokens.Foreground.primary
    )
    
    public static let caption = TextStyleToken(
        typography: TypographyTokens.UI.caption,
        color: ColorTokens.Foreground.secondary
    )
    
    public static let error = TextStyleToken(
        typography: TypographyTokens.UI.caption,
        color: ColorTokens.Status.error
    )
}

// BorderTokens.swift
// DesignSystemPro
//
// Production-grade border radius and border width system
// with semantic naming and component-specific tokens.

import SwiftUI

// MARK: - Border Radius Scale

/// Border radius scale for consistent rounded corners
public enum BorderRadiusScale: CGFloat, CaseIterable, Sendable {
    /// No radius - sharp corners
    case none = 0
    
    /// Extra small radius (2pt)
    case xs = 2
    
    /// Small radius (4pt)
    case sm = 4
    
    /// Medium radius (6pt)
    case md = 6
    
    /// Default radius (8pt)
    case lg = 8
    
    /// Large radius (12pt)
    case xl = 12
    
    /// Extra large radius (16pt)
    case xxl = 16
    
    /// 2XL radius (20pt)
    case xxxl = 20
    
    /// 3XL radius (24pt)
    case huge = 24
    
    /// Full/pill radius (9999pt)
    case full = 9999
}

// MARK: - Border Width Scale

/// Border width scale for consistent stroke widths
public enum BorderWidthScale: CGFloat, CaseIterable, Sendable {
    /// No border
    case none = 0
    
    /// Hairline border (0.5pt) - iOS standard
    case hairline = 0.5
    
    /// Thin border (1pt)
    case thin = 1
    
    /// Default border (1.5pt)
    case `default` = 1.5
    
    /// Medium border (2pt)
    case medium = 2
    
    /// Thick border (3pt)
    case thick = 3
    
    /// Extra thick border (4pt)
    case extraThick = 4
}

// MARK: - Border Tokens Namespace

public enum BorderTokens {
    
    // MARK: - Radius Tokens
    public enum Radius {
        /// No corner radius
        public static let none: CGFloat = BorderRadiusScale.none.rawValue
        
        /// Extra small radius for tight corners (badges, tags)
        public static let xs: CGFloat = BorderRadiusScale.xs.rawValue
        
        /// Small radius (small buttons, inputs)
        public static let sm: CGFloat = BorderRadiusScale.sm.rawValue
        
        /// Medium radius (default for most components)
        public static let md: CGFloat = BorderRadiusScale.md.rawValue
        
        /// Large radius (cards, containers)
        public static let lg: CGFloat = BorderRadiusScale.lg.rawValue
        
        /// Extra large radius (modals, large cards)
        public static let xl: CGFloat = BorderRadiusScale.xl.rawValue
        
        /// 2XL radius (sheets, large modals)
        public static let xxl: CGFloat = BorderRadiusScale.xxl.rawValue
        
        /// Full radius (pills, circular buttons)
        public static let full: CGFloat = BorderRadiusScale.full.rawValue
    }
    
    // MARK: - Width Tokens
    public enum Width {
        /// No border
        public static let none: CGFloat = BorderWidthScale.none.rawValue
        
        /// Hairline border (iOS standard divider)
        public static let hairline: CGFloat = BorderWidthScale.hairline.rawValue
        
        /// Thin border (subtle borders)
        public static let thin: CGFloat = BorderWidthScale.thin.rawValue
        
        /// Default border
        public static let `default`: CGFloat = BorderWidthScale.default.rawValue
        
        /// Medium border (focused inputs)
        public static let medium: CGFloat = BorderWidthScale.medium.rawValue
        
        /// Thick border (emphasis)
        public static let thick: CGFloat = BorderWidthScale.thick.rawValue
    }
    
    // MARK: - Component-Specific Radii
    public enum Component {
        /// Button corner radius
        public static let button: CGFloat = BorderRadiusScale.lg.rawValue
        
        /// Small button corner radius
        public static let buttonSmall: CGFloat = BorderRadiusScale.md.rawValue
        
        /// Pill button (full radius)
        public static let buttonPill: CGFloat = BorderRadiusScale.full.rawValue
        
        /// Input field corner radius
        public static let input: CGFloat = BorderRadiusScale.lg.rawValue
        
        /// Card corner radius
        public static let card: CGFloat = BorderRadiusScale.xl.rawValue
        
        /// Large card corner radius
        public static let cardLarge: CGFloat = BorderRadiusScale.xxl.rawValue
        
        /// Modal/Sheet corner radius
        public static let modal: CGFloat = BorderRadiusScale.xxl.rawValue
        
        /// Bottom sheet corner radius (top only)
        public static let bottomSheet: CGFloat = BorderRadiusScale.xxxl.rawValue
        
        /// Badge corner radius
        public static let badge: CGFloat = BorderRadiusScale.sm.rawValue
        
        /// Tag corner radius
        public static let tag: CGFloat = BorderRadiusScale.md.rawValue
        
        /// Avatar corner radius
        public static let avatar: CGFloat = BorderRadiusScale.full.rawValue
        
        /// Tooltip corner radius
        public static let tooltip: CGFloat = BorderRadiusScale.md.rawValue
        
        /// Toast corner radius
        public static let toast: CGFloat = BorderRadiusScale.lg.rawValue
        
        /// Checkbox corner radius
        public static let checkbox: CGFloat = BorderRadiusScale.sm.rawValue
        
        /// Progress bar corner radius
        public static let progressBar: CGFloat = BorderRadiusScale.full.rawValue
        
        /// Skeleton loading corner radius
        public static let skeleton: CGFloat = BorderRadiusScale.md.rawValue
        
        /// Image thumbnail corner radius
        public static let thumbnail: CGFloat = BorderRadiusScale.lg.rawValue
        
        /// Dropdown menu corner radius
        public static let dropdown: CGFloat = BorderRadiusScale.lg.rawValue
    }
}

// MARK: - Border Style Token

public struct BorderStyleToken: Sendable {
    public let width: CGFloat
    public let color: SemanticColorToken
    public let radius: CGFloat
    
    public init(
        width: CGFloat = BorderTokens.Width.thin,
        color: SemanticColorToken = ColorTokens.Border.primary,
        radius: CGFloat = BorderTokens.Radius.lg
    ) {
        self.width = width
        self.color = color
        self.radius = radius
    }
}

// MARK: - Predefined Border Styles

public enum BorderStyles {
    /// Default border style
    public static let `default` = BorderStyleToken(
        width: BorderTokens.Width.thin,
        color: ColorTokens.Border.primary,
        radius: BorderTokens.Radius.lg
    )
    
    /// Subtle border style
    public static let subtle = BorderStyleToken(
        width: BorderTokens.Width.hairline,
        color: ColorTokens.Border.primary,
        radius: BorderTokens.Radius.md
    )
    
    /// Focus border style
    public static let focus = BorderStyleToken(
        width: BorderTokens.Width.medium,
        color: ColorTokens.Border.focus,
        radius: BorderTokens.Radius.lg
    )
    
    /// Error border style
    public static let error = BorderStyleToken(
        width: BorderTokens.Width.medium,
        color: ColorTokens.Border.error,
        radius: BorderTokens.Radius.lg
    )
    
    /// Card border style
    public static let card = BorderStyleToken(
        width: BorderTokens.Width.thin,
        color: ColorTokens.Border.primary,
        radius: BorderTokens.Component.card
    )
}

// MARK: - Corner Radius Configuration

/// Configuration for different corner radii
public struct CornerRadiusConfiguration: Sendable {
    public let topLeading: CGFloat
    public let topTrailing: CGFloat
    public let bottomLeading: CGFloat
    public let bottomTrailing: CGFloat
    
    public init(
        topLeading: CGFloat,
        topTrailing: CGFloat,
        bottomLeading: CGFloat,
        bottomTrailing: CGFloat
    ) {
        self.topLeading = topLeading
        self.topTrailing = topTrailing
        self.bottomLeading = bottomLeading
        self.bottomTrailing = bottomTrailing
    }
    
    /// Uniform corner radius
    public static func uniform(_ radius: CGFloat) -> CornerRadiusConfiguration {
        CornerRadiusConfiguration(
            topLeading: radius,
            topTrailing: radius,
            bottomLeading: radius,
            bottomTrailing: radius
        )
    }
    
    /// Top corners only
    public static func top(_ radius: CGFloat) -> CornerRadiusConfiguration {
        CornerRadiusConfiguration(
            topLeading: radius,
            topTrailing: radius,
            bottomLeading: 0,
            bottomTrailing: 0
        )
    }
    
    /// Bottom corners only
    public static func bottom(_ radius: CGFloat) -> CornerRadiusConfiguration {
        CornerRadiusConfiguration(
            topLeading: 0,
            topTrailing: 0,
            bottomLeading: radius,
            bottomTrailing: radius
        )
    }
    
    /// Leading corners only
    public static func leading(_ radius: CGFloat) -> CornerRadiusConfiguration {
        CornerRadiusConfiguration(
            topLeading: radius,
            topTrailing: 0,
            bottomLeading: radius,
            bottomTrailing: 0
        )
    }
    
    /// Trailing corners only
    public static func trailing(_ radius: CGFloat) -> CornerRadiusConfiguration {
        CornerRadiusConfiguration(
            topLeading: 0,
            topTrailing: radius,
            bottomLeading: 0,
            bottomTrailing: radius
        )
    }
}

// MARK: - Custom Corner Radius Shape

public struct DSRoundedCorners: Shape {
    let configuration: CornerRadiusConfiguration
    
    public init(_ configuration: CornerRadiusConfiguration) {
        self.configuration = configuration
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let tl = configuration.topLeading
        let tr = configuration.topTrailing
        let bl = configuration.bottomLeading
        let br = configuration.bottomTrailing
        
        path.move(to: CGPoint(x: rect.minX + tl, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - tr, y: rect.minY))
        path.addArc(
            center: CGPoint(x: rect.maxX - tr, y: rect.minY + tr),
            radius: tr,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - br))
        path.addArc(
            center: CGPoint(x: rect.maxX - br, y: rect.maxY - br),
            radius: br,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.minX + bl, y: rect.maxY))
        path.addArc(
            center: CGPoint(x: rect.minX + bl, y: rect.maxY - bl),
            radius: bl,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + tl))
        path.addArc(
            center: CGPoint(x: rect.minX + tl, y: rect.minY + tl),
            radius: tl,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
        path.closeSubpath()
        
        return path
    }
}

// MARK: - View Extensions

extension View {
    /// Apply design system corner radius
    public func dsCornerRadius(_ scale: BorderRadiusScale) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: scale.rawValue, style: .continuous))
    }
    
    /// Apply component-specific corner radius
    public func dsCornerRadius(_ radius: CGFloat) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
    
    /// Apply custom corner configuration
    public func dsCornerRadius(_ configuration: CornerRadiusConfiguration) -> some View {
        self.clipShape(DSRoundedCorners(configuration))
    }
    
    /// Apply border with design system token
    public func dsBorder(
        _ style: BorderStyleToken,
        colorScheme: ColorScheme = .light
    ) -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: style.radius, style: .continuous)
                .stroke(
                    style.color.resolved(for: colorScheme),
                    lineWidth: style.width
                )
        )
    }
    
    /// Apply card styling with border and radius
    public func dsCardBorder() -> some View {
        self
            .dsCornerRadius(BorderTokens.Component.card)
            .overlay(
                RoundedRectangle(
                    cornerRadius: BorderTokens.Component.card,
                    style: .continuous
                )
                .stroke(ColorTokens.Border.primary.light, lineWidth: BorderTokens.Width.hairline)
            )
    }
    
    /// Apply pill shape (fully rounded)
    public func dsPill() -> some View {
        self.clipShape(Capsule())
    }
    
    /// Apply circular shape
    public func dsCircle() -> some View {
        self.clipShape(Circle())
    }
}

// MARK: - Stroke Border Modifier

public struct DSStrokeBorderModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    let width: CGFloat
    let color: SemanticColorToken
    let radius: CGFloat
    
    public func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: radius, style: .continuous)
                .strokeBorder(
                    color.resolved(for: colorScheme),
                    lineWidth: width
                )
        )
    }
}

extension View {
    /// Apply stroke border that respects color scheme
    public func dsStrokeBorder(
        width: CGFloat = BorderTokens.Width.thin,
        color: SemanticColorToken = ColorTokens.Border.primary,
        radius: CGFloat = BorderTokens.Radius.lg
    ) -> some View {
        self.modifier(DSStrokeBorderModifier(width: width, color: color, radius: radius))
    }
}

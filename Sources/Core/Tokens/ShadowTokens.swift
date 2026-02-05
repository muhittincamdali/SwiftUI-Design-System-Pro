// ShadowTokens.swift
// DesignSystemPro
//
// Production-grade shadow system with elevation levels,
// platform-aware rendering, and semantic naming.

import SwiftUI

// MARK: - Shadow Token

public struct ShadowToken: Sendable, Equatable {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat
    public let opacity: Double
    
    public init(
        color: Color = .black,
        radius: CGFloat,
        x: CGFloat = 0,
        y: CGFloat,
        opacity: Double = 0.1
    ) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
        self.opacity = opacity
    }
    
    /// The shadow color with applied opacity
    public var resolvedColor: Color {
        color.opacity(opacity)
    }
}

// MARK: - Multi-Layer Shadow

/// Complex shadow composed of multiple layers for realistic depth
public struct MultiLayerShadow: Sendable, Equatable {
    public let layers: [ShadowToken]
    public let name: String
    
    public init(name: String, layers: [ShadowToken]) {
        self.name = name
        self.layers = layers
    }
}

// MARK: - Elevation Levels

/// Elevation system based on Material Design principles
/// Higher elevation = larger shadow spread and offset
public enum Elevation: Int, CaseIterable, Sendable {
    case level0 = 0   // Flat, no elevation
    case level1 = 1   // Subtle lift (cards at rest)
    case level2 = 2   // Low elevation (cards on hover)
    case level3 = 3   // Medium elevation (dropdowns, popovers)
    case level4 = 4   // High elevation (modals)
    case level5 = 5   // Highest elevation (toasts, tooltips)
    
    public var shadow: MultiLayerShadow {
        switch self {
        case .level0:
            return ShadowTokens.none
        case .level1:
            return ShadowTokens.sm
        case .level2:
            return ShadowTokens.md
        case .level3:
            return ShadowTokens.lg
        case .level4:
            return ShadowTokens.xl
        case .level5:
            return ShadowTokens.xxl
        }
    }
    
    /// Z-index suggestion for this elevation level
    public var zIndex: Double {
        Double(rawValue * 100)
    }
}

// MARK: - Shadow Tokens Namespace

public enum ShadowTokens {
    
    // MARK: - Base Shadows
    
    /// No shadow
    public static let none = MultiLayerShadow(
        name: "none",
        layers: []
    )
    
    /// Extra small shadow - subtle depth
    public static let xs = MultiLayerShadow(
        name: "xs",
        layers: [
            ShadowToken(radius: 1, y: 1, opacity: 0.05)
        ]
    )
    
    /// Small shadow - cards at rest
    public static let sm = MultiLayerShadow(
        name: "sm",
        layers: [
            ShadowToken(radius: 2, y: 1, opacity: 0.05),
            ShadowToken(radius: 3, y: 2, opacity: 0.1)
        ]
    )
    
    /// Medium shadow - cards on hover, buttons
    public static let md = MultiLayerShadow(
        name: "md",
        layers: [
            ShadowToken(radius: 4, y: 2, opacity: 0.06),
            ShadowToken(radius: 6, y: 4, opacity: 0.1)
        ]
    )
    
    /// Large shadow - dropdowns, popovers
    public static let lg = MultiLayerShadow(
        name: "lg",
        layers: [
            ShadowToken(radius: 6, y: 4, opacity: 0.07),
            ShadowToken(radius: 15, y: 10, opacity: 0.1)
        ]
    )
    
    /// Extra large shadow - modals, dialogs
    public static let xl = MultiLayerShadow(
        name: "xl",
        layers: [
            ShadowToken(radius: 10, y: 8, opacity: 0.04),
            ShadowToken(radius: 25, y: 20, opacity: 0.1)
        ]
    )
    
    /// 2XL shadow - floating elements
    public static let xxl = MultiLayerShadow(
        name: "xxl",
        layers: [
            ShadowToken(radius: 25, y: 25, opacity: 0.15),
            ShadowToken(radius: 50, y: 50, opacity: 0.1)
        ]
    )
    
    // MARK: - Semantic Shadows
    
    /// Card shadow - default card elevation
    public static let card = sm
    
    /// Card hover shadow - elevated on interaction
    public static let cardHover = md
    
    /// Button shadow - subtle depth for buttons
    public static let button = xs
    
    /// Button pressed shadow - reduced on press
    public static let buttonPressed = MultiLayerShadow(
        name: "buttonPressed",
        layers: [
            ShadowToken(radius: 1, y: 0, opacity: 0.1)
        ]
    )
    
    /// Dropdown shadow - popovers and menus
    public static let dropdown = lg
    
    /// Modal shadow - dialogs and sheets
    public static let modal = xl
    
    /// Toast shadow - notifications
    public static let toast = lg
    
    /// Sticky header shadow
    public static let stickyHeader = MultiLayerShadow(
        name: "stickyHeader",
        layers: [
            ShadowToken(radius: 4, y: 2, opacity: 0.1)
        ]
    )
    
    /// Input focus shadow - glow effect
    public static let inputFocus = MultiLayerShadow(
        name: "inputFocus",
        layers: [
            ShadowToken(
                color: PrimitiveColors.Blue.blue500,
                radius: 4,
                y: 0,
                opacity: 0.25
            )
        ]
    )
    
    /// Error input shadow
    public static let inputError = MultiLayerShadow(
        name: "inputError",
        layers: [
            ShadowToken(
                color: PrimitiveColors.Red.red500,
                radius: 4,
                y: 0,
                opacity: 0.25
            )
        ]
    )
    
    /// Success input shadow
    public static let inputSuccess = MultiLayerShadow(
        name: "inputSuccess",
        layers: [
            ShadowToken(
                color: PrimitiveColors.Green.green500,
                radius: 4,
                y: 0,
                opacity: 0.25
            )
        ]
    )
    
    // MARK: - Inner Shadows
    
    /// Inner shadow for inset elements
    public static let innerSM = MultiLayerShadow(
        name: "innerSM",
        layers: [
            ShadowToken(radius: 2, y: -1, opacity: 0.06)
        ]
    )
    
    public static let innerMD = MultiLayerShadow(
        name: "innerMD",
        layers: [
            ShadowToken(radius: 4, y: -2, opacity: 0.08)
        ]
    )
}

// MARK: - Dark Mode Shadows

extension ShadowTokens {
    /// Get shadow adjusted for dark mode
    public static func forDarkMode(_ shadow: MultiLayerShadow) -> MultiLayerShadow {
        MultiLayerShadow(
            name: shadow.name + "_dark",
            layers: shadow.layers.map { layer in
                ShadowToken(
                    color: layer.color,
                    radius: layer.radius * 1.2,
                    x: layer.x,
                    y: layer.y * 1.2,
                    opacity: layer.opacity * 1.5
                )
            }
        )
    }
}

// MARK: - Shadow View Modifier

public struct DSShadowModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    let shadow: MultiLayerShadow
    let adaptToDarkMode: Bool
    
    public init(shadow: MultiLayerShadow, adaptToDarkMode: Bool = true) {
        self.shadow = shadow
        self.adaptToDarkMode = adaptToDarkMode
    }
    
    public func body(content: Content) -> some View {
        let activeShadow = adaptToDarkMode && colorScheme == .dark
            ? ShadowTokens.forDarkMode(shadow)
            : shadow
        
        var view = AnyView(content)
        
        for layer in activeShadow.layers {
            view = AnyView(
                view.shadow(
                    color: layer.resolvedColor,
                    radius: layer.radius,
                    x: layer.x,
                    y: layer.y
                )
            )
        }
        
        return view
    }
}

// MARK: - View Extension

extension View {
    /// Apply a multi-layer shadow token
    public func dsShadow(_ shadow: MultiLayerShadow) -> some View {
        self.modifier(DSShadowModifier(shadow: shadow))
    }
    
    /// Apply shadow based on elevation level
    public func dsElevation(_ elevation: Elevation) -> some View {
        self.modifier(DSShadowModifier(shadow: elevation.shadow))
    }
    
    /// Apply card shadow
    public func dsCardShadow() -> some View {
        self.dsShadow(ShadowTokens.card)
    }
    
    /// Apply modal shadow
    public func dsModalShadow() -> some View {
        self.dsShadow(ShadowTokens.modal)
    }
    
    /// Apply focus ring shadow (for inputs)
    public func dsFocusRing(isActive: Bool) -> some View {
        self.dsShadow(isActive ? ShadowTokens.inputFocus : ShadowTokens.none)
    }
}

// MARK: - Animated Shadow

public struct DSAnimatedShadow: ViewModifier {
    let fromShadow: MultiLayerShadow
    let toShadow: MultiLayerShadow
    let isActive: Bool
    let animation: Animation
    
    public init(
        from: MultiLayerShadow,
        to: MultiLayerShadow,
        isActive: Bool,
        animation: Animation = .easeInOut(duration: 0.2)
    ) {
        self.fromShadow = from
        self.toShadow = to
        self.isActive = isActive
        self.animation = animation
    }
    
    public func body(content: Content) -> some View {
        content
            .dsShadow(isActive ? toShadow : fromShadow)
            .animation(animation, value: isActive)
    }
}

extension View {
    /// Apply animated shadow transition
    public func dsAnimatedShadow(
        from: MultiLayerShadow,
        to: MultiLayerShadow,
        isActive: Bool
    ) -> some View {
        self.modifier(DSAnimatedShadow(from: from, to: to, isActive: isActive))
    }
    
    /// Card hover shadow animation
    public func dsCardHoverShadow(isHovered: Bool) -> some View {
        self.dsAnimatedShadow(
            from: ShadowTokens.card,
            to: ShadowTokens.cardHover,
            isActive: isHovered
        )
    }
}

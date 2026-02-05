// Tokens.swift
// DesignSystemPro
//
// Central export file for all design tokens.

import SwiftUI

// MARK: - Design Tokens Public API

/// Primary namespace for all design tokens
public enum DesignTokens {
    public typealias Colors = ColorTokens
    public typealias Typography = TypographyTokens
    public typealias Spacing = SpacingTokens
    public typealias Shadows = ShadowTokens
    public typealias Borders = BorderTokens
    public typealias Animations = AnimationTokens
}

// MARK: - Token Access Shortcuts

extension View {
    /// Access design tokens
    public var ds: DesignTokens.Type { DesignTokens.self }
}

// MARK: - Token Documentation

/*
 DESIGN TOKENS OVERVIEW
 ======================
 
 This design system uses a layered token architecture:
 
 1. PRIMITIVE TOKENS (Base Layer)
    Raw values that define the design language.
    Example: PrimitiveColors.Blue.blue500
    
 2. SEMANTIC TOKENS (Application Layer)
    Meaningful names that map to primitives.
    Example: ColorTokens.Accent.primary
    
 3. COMPONENT TOKENS (Component Layer)
    Specific values for individual components.
    Example: BorderTokens.Component.button
 
 TOKEN CATEGORIES
 ================
 
 ColorTokens
 -----------
 - Background: primary, secondary, tertiary, elevated
 - Foreground: primary, secondary, tertiary, disabled
 - Accent: primary, secondary, tertiary
 - Status: success, warning, error, info
 - Border: primary, secondary, focus, error
 - Interactive: hover, pressed, selected, disabled
 
 TypographyTokens
 ----------------
 - Display: hero, title, large, medium, small
 - Heading: h1, h2, h3, h4
 - Body: large, medium, small, extraSmall
 - UI: label, button, caption, overline, badge
 - Code: large, medium, small
 
 SpacingTokens
 -------------
 - Scale: none(0), xxxs(2), xxs(4), xs(6), sm(8), md(12), lg(16), xl(20), xxl(24), xxxl(32)
 - Component: iconGap, paddingXS/SM/MD/LG/XL
 - Layout: screenEdge, cardPadding, sectionGap, gridGap
 - Form: labelGap, fieldGap, inputPadding
 
 ShadowTokens
 ------------
 - Base: none, xs, sm, md, lg, xl, xxl
 - Semantic: card, cardHover, button, dropdown, modal, toast
 - Focus: inputFocus, inputError, inputSuccess
 - Elevation: level0-5
 
 BorderTokens
 ------------
 - Radius: none, xs, sm, md, lg, xl, xxl, full
 - Width: none, hairline, thin, default, medium, thick
 - Component: button, input, card, modal, badge, avatar
 
 AnimationTokens
 ---------------
 - Micro: buttonPress, toggle, checkbox, hover, focus
 - Component: fade, scale, slide, expand
 - Page: modalEnter/Exit, sheetEnter/Exit, push/pop
 - Feedback: success, error, warning, loading
 - Spring: gentle, default, bouncy, stiff, wobbly
 
 USAGE EXAMPLES
 ==============
 
 // Colors
 ColorTokens.Accent.primary.resolved(for: colorScheme)
 ColorTokens.Background.primary.resolved(for: .light)
 
 // Typography
 Text("Hello").dsTypography(TypographyTokens.Heading.h1)
 Text("Body").dsBodyStyle(.medium)
 
 // Spacing
 .padding(SpacingScale.lg.rawValue)
 .dsPadding(.lg)
 VStack(spacing: SpacingTokens.Content.default)
 
 // Shadows
 .dsShadow(ShadowTokens.card)
 .dsElevation(.level2)
 
 // Borders
 .dsCornerRadius(.lg)
 .dsBorder(BorderStyles.focus)
 
 // Animations
 .animation(AnimationTokens.Micro.buttonPress.swiftUIAnimation)
 .dsSpring(.bouncy)
 .transition(TransitionTokens.modal)
 
 */

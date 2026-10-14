// Tokens.swift
// DesignSystemPro
//
// Umbrella namespace for the token families.

import SwiftUI

/// Groups every token family under one name, e.g. `DesignTokens.Colors.Accent.primary`.
public enum DesignTokens {
    public typealias Colors = ColorTokens
    public typealias Typography = TypographyTokens
    public typealias Spacing = SpacingTokens
    public typealias Shadows = ShadowTokens
    public typealias Borders = BorderTokens
    public typealias Animations = AnimationTokens
}

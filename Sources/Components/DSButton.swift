// DSButton.swift
// DesignSystemPro
//
// Production-grade button component with multiple variants,
// sizes, states, and full accessibility support.

import SwiftUI

// MARK: - Button Variant

public enum DSButtonVariant: String, CaseIterable, Sendable {
    case primary     // Filled with accent color
    case secondary   // Outlined
    case tertiary    // Text only
    case ghost       // Minimal, hover only
    case destructive // Red/danger actions
    case success     // Green/confirm actions
}

// MARK: - Button Size

public enum DSButtonSize: String, CaseIterable, Sendable {
    case xs          // Extra small (24pt height)
    case sm          // Small (32pt height)
    case md          // Medium (40pt height) - Default
    case lg          // Large (48pt height)
    case xl          // Extra large (56pt height)
    
    var height: CGFloat {
        switch self {
        case .xs: return 24
        case .sm: return 32
        case .md: return 40
        case .lg: return 48
        case .xl: return 56
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .xs: return 8
        case .sm: return 12
        case .md: return 16
        case .lg: return 20
        case .xl: return 24
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .xs: return 12
        case .sm: return 14
        case .md: return 16
        case .lg: return 20
        case .xl: return 24
        }
    }
    
    var typography: TypographyToken {
        switch self {
        case .xs: return TypographyTokens.UI.buttonSmall
        case .sm: return TypographyTokens.UI.buttonSmall
        case .md: return TypographyTokens.UI.button
        case .lg: return TypographyTokens.UI.button
        case .xl: return TypographyToken(scale: .bodyMD, weight: .semibold)
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .xs: return BorderTokens.Radius.sm
        case .sm: return BorderTokens.Radius.md
        case .md: return BorderTokens.Component.button
        case .lg: return BorderTokens.Component.button
        case .xl: return BorderTokens.Radius.xl
        }
    }
}

// MARK: - Button State

public enum DSButtonState: Sendable {
    case normal
    case pressed
    case disabled
    case loading
}

// MARK: - Button Configuration

public struct DSButtonConfiguration: Sendable {
    public let variant: DSButtonVariant
    public let size: DSButtonSize
    public let isFullWidth: Bool
    public let isPill: Bool
    
    public init(
        variant: DSButtonVariant = .primary,
        size: DSButtonSize = .md,
        isFullWidth: Bool = false,
        isPill: Bool = false
    ) {
        self.variant = variant
        self.size = size
        self.isFullWidth = isFullWidth
        self.isPill = isPill
    }
}

// MARK: - Button Content

public struct DSButtonContent: View {
    let label: String
    let leadingIcon: Image?
    let trailingIcon: Image?
    let isLoading: Bool
    let size: DSButtonSize
    let foregroundColor: Color
    
    public init(
        label: String,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        isLoading: Bool = false,
        size: DSButtonSize = .md,
        foregroundColor: Color = .white
    ) {
        self.label = label
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.isLoading = isLoading
        self.size = size
        self.foregroundColor = foregroundColor
    }
    
    public var body: some View {
        HStack(spacing: SpacingTokens.Component.iconGap) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
                    .scaleEffect(size == .xs || size == .sm ? 0.7 : 0.85)
            } else {
                if let icon = leadingIcon {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.iconSize, height: size.iconSize)
                }
            }
            
            Text(label)
                .dsTypography(size.typography)
            
            if let icon = trailingIcon, !isLoading {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.iconSize, height: size.iconSize)
            }
        }
        .foregroundColor(foregroundColor)
    }
}

// MARK: - DSButton View

public struct DSButton: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    
    private let label: String
    private let leadingIcon: Image?
    private let trailingIcon: Image?
    private let configuration: DSButtonConfiguration
    private let action: () -> Void
    
    @State private var isPressed = false
    @State private var isLoading = false
    
    public init(
        _ label: String,
        variant: DSButtonVariant = .primary,
        size: DSButtonSize = .md,
        isFullWidth: Bool = false,
        isPill: Bool = false,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.configuration = DSButtonConfiguration(
            variant: variant,
            size: size,
            isFullWidth: isFullWidth,
            isPill: isPill
        )
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            guard isEnabled && !isLoading else { return }
            action()
        }) {
            DSButtonContent(
                label: label,
                leadingIcon: leadingIcon,
                trailingIcon: trailingIcon,
                isLoading: isLoading,
                size: configuration.size,
                foregroundColor: foregroundColor
            )
            .frame(height: configuration.size.height)
            .frame(maxWidth: configuration.isFullWidth ? .infinity : nil)
            .padding(.horizontal, configuration.size.horizontalPadding)
            .background(backgroundColor)
            .overlay(borderOverlay)
            .clipShape(buttonShape)
            .dsShadow(buttonShadow)
        }
        .buttonStyle(DSButtonPressStyle(isPressed: $isPressed))
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.5)
        .accessibilityLabel(label)
        .accessibilityAddTraits(.isButton)
    }
    
    // MARK: - Computed Properties
    
    private var backgroundColor: Color {
        switch configuration.variant {
        case .primary:
            return isPressed
                ? ColorTokens.Accent.primary.resolved(for: colorScheme).opacity(0.8)
                : ColorTokens.Accent.primary.resolved(for: colorScheme)
        case .secondary:
            return isPressed
                ? ColorTokens.Interactive.pressed.resolved(for: colorScheme)
                : .clear
        case .tertiary, .ghost:
            return isPressed
                ? ColorTokens.Interactive.hover.resolved(for: colorScheme)
                : .clear
        case .destructive:
            return isPressed
                ? ColorTokens.Status.error.resolved(for: colorScheme).opacity(0.8)
                : ColorTokens.Status.error.resolved(for: colorScheme)
        case .success:
            return isPressed
                ? ColorTokens.Status.success.resolved(for: colorScheme).opacity(0.8)
                : ColorTokens.Status.success.resolved(for: colorScheme)
        }
    }
    
    private var foregroundColor: Color {
        switch configuration.variant {
        case .primary, .destructive, .success:
            return ColorTokens.Foreground.onAccent.resolved(for: colorScheme)
        case .secondary:
            return ColorTokens.Accent.primary.resolved(for: colorScheme)
        case .tertiary, .ghost:
            return ColorTokens.Foreground.primary.resolved(for: colorScheme)
        }
    }
    
    @ViewBuilder
    private var borderOverlay: some View {
        if configuration.variant == .secondary {
            buttonShape
                .stroke(ColorTokens.Accent.primary.resolved(for: colorScheme), lineWidth: BorderTokens.Width.thin)
        } else {
            EmptyView()
        }
    }
    
    private var buttonShape: some Shape {
        if configuration.isPill {
            return AnyShape(Capsule())
        } else {
            return AnyShape(RoundedRectangle(cornerRadius: configuration.size.cornerRadius, style: .continuous))
        }
    }
    
    private var buttonShadow: MultiLayerShadow {
        guard configuration.variant == .primary else { return ShadowTokens.none }
        return isPressed ? ShadowTokens.buttonPressed : ShadowTokens.button
    }
    
    // MARK: - Modifiers
    
    public func loading(_ isLoading: Bool) -> some View {
        var copy = self
        copy._isLoading = State(initialValue: isLoading)
        return copy
    }
}

// MARK: - Button Press Style

private struct DSButtonPressStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(AnimationTokens.Micro.buttonPress.swiftUIAnimation, value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { _, newValue in
                isPressed = newValue
            }
    }
}

// MARK: - AnyShape Helper

private struct AnyShape: Shape {
    private let pathBuilder: (CGRect) -> Path
    
    init<S: Shape>(_ shape: S) {
        pathBuilder = { rect in
            shape.path(in: rect)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        pathBuilder(rect)
    }
}

// MARK: - Icon Button

public struct DSIconButton: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    
    private let icon: Image
    private let size: DSButtonSize
    private let variant: DSButtonVariant
    private let action: () -> Void
    
    @State private var isPressed = false
    
    public init(
        icon: Image,
        size: DSButtonSize = .md,
        variant: DSButtonVariant = .ghost,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.variant = variant
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.iconSize, height: size.iconSize)
                .frame(width: size.height, height: size.height)
                .foregroundColor(foregroundColor)
                .background(backgroundColor)
                .clipShape(Circle())
        }
        .buttonStyle(DSButtonPressStyle(isPressed: $isPressed))
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.5)
    }
    
    private var foregroundColor: Color {
        switch variant {
        case .primary:
            return ColorTokens.Foreground.onAccent.resolved(for: colorScheme)
        case .destructive:
            return ColorTokens.Foreground.onAccent.resolved(for: colorScheme)
        default:
            return ColorTokens.Foreground.primary.resolved(for: colorScheme)
        }
    }
    
    private var backgroundColor: Color {
        switch variant {
        case .primary:
            return isPressed
                ? ColorTokens.Accent.primary.resolved(for: colorScheme).opacity(0.8)
                : ColorTokens.Accent.primary.resolved(for: colorScheme)
        case .destructive:
            return isPressed
                ? ColorTokens.Status.error.resolved(for: colorScheme).opacity(0.8)
                : ColorTokens.Status.error.resolved(for: colorScheme)
        case .ghost:
            return isPressed
                ? ColorTokens.Interactive.hover.resolved(for: colorScheme)
                : .clear
        default:
            return .clear
        }
    }
}

// MARK: - Button Group

public struct DSButtonGroup<Content: View>: View {
    let spacing: CGFloat
    let content: Content
    
    public init(
        spacing: CGFloat = SpacingTokens.Component.iconGap,
        @ViewBuilder content: () -> Content
    ) {
        self.spacing = spacing
        self.content = content()
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            content
        }
    }
}

// MARK: - Convenience Initializers

extension DSButton {
    /// Primary button
    public static func primary(
        _ label: String,
        size: DSButtonSize = .md,
        icon: Image? = nil,
        action: @escaping () -> Void
    ) -> DSButton {
        DSButton(
            label,
            variant: .primary,
            size: size,
            leadingIcon: icon,
            action: action
        )
    }
    
    /// Secondary button
    public static func secondary(
        _ label: String,
        size: DSButtonSize = .md,
        icon: Image? = nil,
        action: @escaping () -> Void
    ) -> DSButton {
        DSButton(
            label,
            variant: .secondary,
            size: size,
            leadingIcon: icon,
            action: action
        )
    }
    
    /// Destructive button
    public static func destructive(
        _ label: String,
        size: DSButtonSize = .md,
        icon: Image? = nil,
        action: @escaping () -> Void
    ) -> DSButton {
        DSButton(
            label,
            variant: .destructive,
            size: size,
            leadingIcon: icon,
            action: action
        )
    }
}

// DSCard.swift
// DesignSystemPro
//
// Production-grade card component with variants,
// interactive states, and flexible content layouts.

import SwiftUI

// MARK: - Card Variant

public enum DSCardVariant: String, CaseIterable, Sendable {
    case elevated    // Shadow elevation
    case outlined    // Border only
    case filled      // Solid background
    case ghost       // Minimal styling
}

// MARK: - Card Size

public enum DSCardSize: String, CaseIterable, Sendable {
    case sm  // Compact padding
    case md  // Default padding
    case lg  // Spacious padding
    
    var padding: EdgeInsets {
        switch self {
        case .sm: return EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        case .md: return EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        case .lg: return EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24)
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .sm: return BorderTokens.Radius.lg
        case .md: return BorderTokens.Component.card
        case .lg: return BorderTokens.Component.cardLarge
        }
    }
}

// MARK: - DSCard

public struct DSCard<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let variant: DSCardVariant
    private let size: DSCardSize
    private let isInteractive: Bool
    private let action: (() -> Void)?
    private let content: Content
    
    @State private var isHovered = false
    @State private var isPressed = false
    
    public init(
        variant: DSCardVariant = .elevated,
        size: DSCardSize = .md,
        isInteractive: Bool = false,
        action: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.variant = variant
        self.size = size
        self.isInteractive = isInteractive || action != nil
        self.action = action
        self.content = content()
    }
    
    public var body: some View {
        Group {
            if let action = action {
                Button(action: action) {
                    cardContent
                }
                .buttonStyle(CardButtonStyle(isPressed: $isPressed))
            } else {
                cardContent
            }
        }
        .onHover { hovering in
            if isInteractive {
                withAnimation(AnimationTokens.Micro.hover.swiftUIAnimation) {
                    isHovered = hovering
                }
            }
        }
    }
    
    private var cardContent: some View {
        content
            .padding(size.padding)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: size.radius, style: .continuous))
            .overlay(borderOverlay)
            .dsShadow(shadow)
            .scaleEffect(isPressed ? 0.98 : 1)
    }
    
    // MARK: - Computed Properties
    
    private var backgroundColor: Color {
        switch variant {
        case .elevated, .outlined:
            return ColorTokens.Background.elevated.resolved(for: colorScheme)
        case .filled:
            return ColorTokens.Background.secondary.resolved(for: colorScheme)
        case .ghost:
            return isHovered
                ? ColorTokens.Interactive.hover.resolved(for: colorScheme)
                : Color.clear
        }
    }
    
    @ViewBuilder
    private var borderOverlay: some View {
        if variant == .outlined {
            RoundedRectangle(cornerRadius: size.radius, style: .continuous)
                .strokeBorder(ColorTokens.Border.primary.resolved(for: colorScheme), lineWidth: BorderTokens.Width.thin)
        } else {
            EmptyView()
        }
    }
    
    private var shadow: MultiLayerShadow {
        guard variant == .elevated else { return ShadowTokens.none }
        if isPressed {
            return ShadowTokens.xs
        }
        return isHovered ? ShadowTokens.cardHover : ShadowTokens.card
    }
}

// MARK: - Card Button Style

private struct CardButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, newValue in
                withAnimation(AnimationTokens.Micro.buttonPress.swiftUIAnimation) {
                    isPressed = newValue
                }
            }
    }
}

// MARK: - Card Header

public struct DSCardHeader: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let title: String
    private let subtitle: String?
    private let leadingIcon: Image?
    private let trailingContent: AnyView?
    
    public init(
        title: String,
        subtitle: String? = nil,
        leadingIcon: Image? = nil,
        trailingContent: AnyView? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailingContent = trailingContent
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: SpacingScale.md.rawValue) {
            if let icon = leadingIcon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(ColorTokens.Accent.primary.resolved(for: colorScheme))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .dsTypography(TypographyTokens.Heading.h4)
                    .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .dsTypography(TypographyTokens.Body.small)
                        .foregroundColor(ColorTokens.Foreground.secondary.resolved(for: colorScheme))
                }
            }
            
            Spacer()
            
            if let trailing = trailingContent {
                trailing
            }
        }
    }
}

// MARK: - Card Footer

public struct DSCardFooter<Content: View>: View {
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, -16)
                .padding(.bottom, SpacingScale.md.rawValue)
            
            HStack {
                content
            }
        }
    }
}

// MARK: - Media Card

public struct DSMediaCard<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let image: Image
    private let aspectRatio: CGFloat
    private let variant: DSCardVariant
    private let content: Content
    
    public init(
        image: Image,
        aspectRatio: CGFloat = 16/9,
        variant: DSCardVariant = .elevated,
        @ViewBuilder content: () -> Content
    ) {
        self.image = image
        self.aspectRatio = aspectRatio
        self.variant = variant
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            image
                .resizable()
                .aspectRatio(aspectRatio, contentMode: .fill)
                .clipped()
            
            VStack(alignment: .leading, spacing: SpacingScale.sm.rawValue) {
                content
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(InsetTokens.card)
        }
        .background(ColorTokens.Background.elevated.resolved(for: colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: BorderTokens.Component.card, style: .continuous))
        .dsShadow(variant == .elevated ? ShadowTokens.card : ShadowTokens.none)
        .overlay(
            RoundedRectangle(cornerRadius: BorderTokens.Component.card, style: .continuous)
                .strokeBorder(
                    variant == .outlined
                        ? ColorTokens.Border.primary.resolved(for: colorScheme)
                        : Color.clear,
                    lineWidth: BorderTokens.Width.thin
                )
        )
    }
}

// MARK: - Stat Card

public struct DSStatCard: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let title: String
    private let value: String
    private let change: String?
    private let isPositive: Bool
    private let icon: Image?
    
    public init(
        title: String,
        value: String,
        change: String? = nil,
        isPositive: Bool = true,
        icon: Image? = nil
    ) {
        self.title = title
        self.value = value
        self.change = change
        self.isPositive = isPositive
        self.icon = icon
    }
    
    public var body: some View {
        DSCard(variant: .elevated, size: .md) {
            VStack(alignment: .leading, spacing: SpacingScale.sm.rawValue) {
                HStack {
                    Text(title)
                        .dsTypography(TypographyTokens.UI.label)
                        .foregroundColor(ColorTokens.Foreground.secondary.resolved(for: colorScheme))
                    
                    Spacer()
                    
                    if let icon = icon {
                        icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(ColorTokens.Foreground.tertiary.resolved(for: colorScheme))
                    }
                }
                
                Text(value)
                    .dsTypography(TypographyTokens.Display.small)
                    .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
                
                if let change = change {
                    HStack(spacing: 4) {
                        Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, height: 12)
                        
                        Text(change)
                            .dsTypography(TypographyTokens.Body.small)
                    }
                    .foregroundColor(
                        isPositive
                            ? ColorTokens.Status.success.resolved(for: colorScheme)
                            : ColorTokens.Status.error.resolved(for: colorScheme)
                    )
                }
            }
        }
    }
}

// MARK: - List Card

public struct DSListCard<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let title: String
    private let content: Content
    
    public init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }
    
    public var body: some View {
        DSCard(variant: .elevated, size: .md) {
            VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
                Text(title)
                    .dsTypography(TypographyTokens.Heading.h4)
                    .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
                
                content
            }
        }
    }
}

// MARK: - Card List Item

public struct DSCardListItem: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let title: String
    private let subtitle: String?
    private let leadingIcon: Image?
    private let trailing: String?
    private let action: (() -> Void)?
    
    @State private var isHovered = false
    
    public init(
        title: String,
        subtitle: String? = nil,
        leadingIcon: Image? = nil,
        trailing: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.trailing = trailing
        self.action = action
    }
    
    public var body: some View {
        let content = HStack(spacing: SpacingScale.md.rawValue) {
            if let icon = leadingIcon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(ColorTokens.Foreground.secondary.resolved(for: colorScheme))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .dsTypography(TypographyTokens.Body.medium)
                    .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .dsTypography(TypographyTokens.Body.small)
                        .foregroundColor(ColorTokens.Foreground.secondary.resolved(for: colorScheme))
                }
            }
            
            Spacer()
            
            if let trailing = trailing {
                Text(trailing)
                    .dsTypography(TypographyTokens.Body.small)
                    .foregroundColor(ColorTokens.Foreground.tertiary.resolved(for: colorScheme))
            }
            
            if action != nil {
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .foregroundColor(ColorTokens.Foreground.tertiary.resolved(for: colorScheme))
            }
        }
        .padding(.vertical, SpacingScale.md.rawValue)
        .padding(.horizontal, SpacingScale.sm.rawValue)
        .background(
            isHovered
                ? ColorTokens.Interactive.hover.resolved(for: colorScheme)
                : Color.clear
        )
        .cornerRadius(BorderTokens.Radius.md)
        .onHover { hovering in
            withAnimation(AnimationTokens.Micro.hover.swiftUIAnimation) {
                isHovered = hovering
            }
        }
        
        if let action = action {
            Button(action: action) {
                content
            }
            .buttonStyle(.plain)
        } else {
            content
        }
    }
}

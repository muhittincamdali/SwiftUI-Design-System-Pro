// DSBadge.swift
// DesignSystemPro
//
// Production-grade badge component with multiple variants,
// sizes, and dot indicators.

import SwiftUI

// MARK: - Badge Variant

public enum DSBadgeVariant: String, CaseIterable, Sendable {
    case primary     // Accent color
    case secondary   // Neutral/gray
    case success     // Green
    case warning     // Amber/yellow
    case error       // Red
    case info        // Blue
    case outline     // Bordered
}

// MARK: - Badge Size

public enum DSBadgeSize: String, CaseIterable, Sendable {
    case xs  // Extra small
    case sm  // Small
    case md  // Medium (default)
    case lg  // Large
    
    var height: CGFloat {
        switch self {
        case .xs: return 16
        case .sm: return 20
        case .md: return 24
        case .lg: return 28
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .xs: return 4
        case .sm: return 6
        case .md: return 8
        case .lg: return 10
        }
    }
    
    var typography: TypographyToken {
        switch self {
        case .xs: return TypographyToken(scale: .micro, weight: .semibold)
        case .sm: return TypographyTokens.UI.badge
        case .md: return TypographyTokens.UI.labelSmall
        case .lg: return TypographyTokens.UI.label
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .xs: return 10
        case .sm: return 12
        case .md: return 14
        case .lg: return 16
        }
    }
}

// MARK: - DSBadge

public struct DSBadge: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let label: String
    private let variant: DSBadgeVariant
    private let size: DSBadgeSize
    private let leadingIcon: Image?
    private let trailingIcon: Image?
    private let isPill: Bool
    
    public init(
        _ label: String,
        variant: DSBadgeVariant = .primary,
        size: DSBadgeSize = .md,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        isPill: Bool = true
    ) {
        self.label = label
        self.variant = variant
        self.size = size
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.isPill = isPill
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            if let icon = leadingIcon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.iconSize, height: size.iconSize)
            }
            
            Text(label)
                .dsTypography(size.typography)
            
            if let icon = trailingIcon {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.iconSize, height: size.iconSize)
            }
        }
        .foregroundColor(foregroundColor)
        .padding(.horizontal, size.horizontalPadding)
        .frame(height: size.height)
        .background(backgroundColor)
        .clipShape(badgeShape)
        .overlay(borderOverlay)
    }
    
    // MARK: - Computed Properties
    
    private var foregroundColor: Color {
        switch variant {
        case .primary:
            return ColorTokens.Foreground.onAccent.resolved(for: colorScheme)
        case .secondary:
            return ColorTokens.Foreground.primary.resolved(for: colorScheme)
        case .success:
            return colorScheme == .dark ? PrimitiveColors.Green.green900 : .white
        case .warning:
            return PrimitiveColors.Amber.amber900
        case .error:
            return colorScheme == .dark ? PrimitiveColors.Red.red900 : .white
        case .info:
            return colorScheme == .dark ? PrimitiveColors.Blue.blue900 : .white
        case .outline:
            return ColorTokens.Foreground.primary.resolved(for: colorScheme)
        }
    }
    
    private var backgroundColor: Color {
        switch variant {
        case .primary:
            return ColorTokens.Accent.primary.resolved(for: colorScheme)
        case .secondary:
            return ColorTokens.Background.tertiary.resolved(for: colorScheme)
        case .success:
            return ColorTokens.Status.success.resolved(for: colorScheme)
        case .warning:
            return ColorTokens.Status.warning.resolved(for: colorScheme)
        case .error:
            return ColorTokens.Status.error.resolved(for: colorScheme)
        case .info:
            return ColorTokens.Status.info.resolved(for: colorScheme)
        case .outline:
            return .clear
        }
    }
    
    private var badgeShape: some Shape {
        if isPill {
            return AnyShape(Capsule())
        } else {
            return AnyShape(RoundedRectangle(cornerRadius: BorderTokens.Component.badge, style: .continuous))
        }
    }
    
    @ViewBuilder
    private var borderOverlay: some View {
        if variant == .outline {
            badgeShape
                .stroke(ColorTokens.Border.primary.resolved(for: colorScheme), lineWidth: BorderTokens.Width.thin)
        } else {
            EmptyView()
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

// MARK: - Dot Badge

public struct DSDotBadge: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let variant: DSBadgeVariant
    private let size: CGFloat
    private let isPulsing: Bool
    
    public init(
        variant: DSBadgeVariant = .error,
        size: CGFloat = 8,
        isPulsing: Bool = false
    ) {
        self.variant = variant
        self.size = size
        self.isPulsing = isPulsing
    }
    
    public var body: some View {
        Circle()
            .fill(dotColor)
            .frame(width: size, height: size)
            .modifier(PulseModifier(isPulsing: isPulsing, color: dotColor))
    }
    
    private var dotColor: Color {
        switch variant {
        case .primary: return ColorTokens.Accent.primary.resolved(for: colorScheme)
        case .secondary: return ColorTokens.Foreground.tertiary.resolved(for: colorScheme)
        case .success: return ColorTokens.Status.success.resolved(for: colorScheme)
        case .warning: return ColorTokens.Status.warning.resolved(for: colorScheme)
        case .error: return ColorTokens.Status.error.resolved(for: colorScheme)
        case .info: return ColorTokens.Status.info.resolved(for: colorScheme)
        case .outline: return ColorTokens.Border.primary.resolved(for: colorScheme)
        }
    }
}

private struct PulseModifier: ViewModifier {
    let isPulsing: Bool
    let color: Color
    
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        ZStack {
            if isPulsing {
                Circle()
                    .fill(color.opacity(0.4))
                    .scaleEffect(isAnimating ? 2 : 1)
                    .opacity(isAnimating ? 0 : 0.5)
            }
            content
        }
        .onAppear {
            if isPulsing {
                withAnimation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
        }
    }
}

// MARK: - Counter Badge

public struct DSCounterBadge: View {
    private let count: Int
    private let maxCount: Int
    private let variant: DSBadgeVariant
    private let size: DSBadgeSize
    
    public init(
        count: Int,
        maxCount: Int = 99,
        variant: DSBadgeVariant = .error,
        size: DSBadgeSize = .sm
    ) {
        self.count = count
        self.maxCount = maxCount
        self.variant = variant
        self.size = size
    }
    
    public var body: some View {
        if count > 0 {
            DSBadge(
                displayText,
                variant: variant,
                size: size
            )
        }
    }
    
    private var displayText: String {
        count > maxCount ? "\(maxCount)+" : "\(count)"
    }
}

// MARK: - Status Badge

public struct DSStatusBadge: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let status: String
    private let variant: DSBadgeVariant
    private let size: DSBadgeSize
    
    public init(
        _ status: String,
        variant: DSBadgeVariant,
        size: DSBadgeSize = .sm
    ) {
        self.status = status
        self.variant = variant
        self.size = size
    }
    
    public var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
            
            Text(status)
                .dsTypography(size.typography)
                .foregroundColor(foregroundColor)
        }
        .padding(.horizontal, size.horizontalPadding + 2)
        .frame(height: size.height)
        .background(backgroundColor.opacity(0.15))
        .clipShape(Capsule())
    }
    
    private var statusColor: Color {
        switch variant {
        case .success: return ColorTokens.Status.success.resolved(for: colorScheme)
        case .warning: return ColorTokens.Status.warning.resolved(for: colorScheme)
        case .error: return ColorTokens.Status.error.resolved(for: colorScheme)
        case .info, .primary: return ColorTokens.Status.info.resolved(for: colorScheme)
        default: return ColorTokens.Foreground.tertiary.resolved(for: colorScheme)
        }
    }
    
    private var foregroundColor: Color {
        switch variant {
        case .success: return PrimitiveColors.Green.green700
        case .warning: return PrimitiveColors.Amber.amber700
        case .error: return PrimitiveColors.Red.red700
        case .info, .primary: return PrimitiveColors.Blue.blue700
        default: return ColorTokens.Foreground.secondary.resolved(for: colorScheme)
        }
    }
    
    private var backgroundColor: Color {
        switch variant {
        case .success: return ColorTokens.Status.success.resolved(for: colorScheme)
        case .warning: return ColorTokens.Status.warning.resolved(for: colorScheme)
        case .error: return ColorTokens.Status.error.resolved(for: colorScheme)
        case .info, .primary: return ColorTokens.Status.info.resolved(for: colorScheme)
        default: return ColorTokens.Background.tertiary.resolved(for: colorScheme)
        }
    }
}

// MARK: - Tag

public struct DSTag: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let label: String
    private let onRemove: (() -> Void)?
    
    public init(
        _ label: String,
        onRemove: (() -> Void)? = nil
    ) {
        self.label = label
        self.onRemove = onRemove
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            Text(label)
                .dsTypography(TypographyTokens.UI.labelSmall)
                .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
            
            if let onRemove = onRemove {
                Button(action: onRemove) {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
                        .foregroundColor(ColorTokens.Foreground.secondary.resolved(for: colorScheme))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(ColorTokens.Background.secondary.resolved(for: colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: BorderTokens.Component.tag, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: BorderTokens.Component.tag, style: .continuous)
                .stroke(ColorTokens.Border.primary.resolved(for: colorScheme), lineWidth: BorderTokens.Width.hairline)
        )
    }
}

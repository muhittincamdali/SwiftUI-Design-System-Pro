// DSSkeleton.swift
// DesignSystemPro
//
// Production-grade skeleton loading components with
// shimmer animation and various shapes.

import SwiftUI

// MARK: - Skeleton Shape

public enum DSSkeletonShape: Sendable {
    case rectangle
    case circle
    case capsule
    case custom(CGFloat)  // Custom corner radius
    
    func shape(for size: CGSize) -> some Shape {
        switch self {
        case .rectangle:
            return AnyShape(RoundedRectangle(cornerRadius: BorderTokens.Radius.md, style: .continuous))
        case .circle:
            return AnyShape(Circle())
        case .capsule:
            return AnyShape(Capsule())
        case .custom(let radius):
            return AnyShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
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

// MARK: - Skeleton Shimmer Effect

public struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = -1
    
    let duration: Double
    let bounce: Bool
    
    public init(duration: Double = 1.5, bounce: Bool = false) {
        self.duration = duration
        self.bounce = bounce
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            .white.opacity(0.4),
                            .clear
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * 2)
                    .offset(x: phase * geometry.size.width * 2)
                }
                .mask(content)
            )
            .onAppear {
                withAnimation(
                    Animation
                        .linear(duration: duration)
                        .repeatForever(autoreverses: bounce)
                ) {
                    phase = 1
                }
            }
    }
}

extension View {
    /// Apply shimmer effect
    public func dsShimmer(duration: Double = 1.5) -> some View {
        self.modifier(ShimmerEffect(duration: duration))
    }
}

// MARK: - DSSkeleton

public struct DSSkeleton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let width: CGFloat?
    private let height: CGFloat
    private let shape: DSSkeletonShape
    private let shimmer: Bool
    
    public init(
        width: CGFloat? = nil,
        height: CGFloat,
        shape: DSSkeletonShape = .rectangle,
        shimmer: Bool = true
    ) {
        self.width = width
        self.height = height
        self.shape = shape
        self.shimmer = shimmer
    }
    
    public var body: some View {
        let base = shape.shape(for: CGSize(width: width ?? 100, height: height))
            .fill(backgroundColor)
            .frame(width: width, height: height)
        
        if shimmer {
            base.dsShimmer()
        } else {
            base
        }
    }
    
    private var backgroundColor: Color {
        ColorTokens.Background.tertiary.resolved(for: colorScheme)
    }
}

// MARK: - Skeleton Text

public struct DSSkeletonText: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let lines: Int
    private let lineHeight: CGFloat
    private let spacing: CGFloat
    private let lastLineWidth: CGFloat
    
    public init(
        lines: Int = 3,
        lineHeight: CGFloat = 16,
        spacing: CGFloat = 8,
        lastLineWidth: CGFloat = 0.6
    ) {
        self.lines = lines
        self.lineHeight = lineHeight
        self.spacing = spacing
        self.lastLineWidth = lastLineWidth
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(0..<lines, id: \.self) { index in
                GeometryReader { geometry in
                    DSSkeleton(
                        width: index == lines - 1
                            ? geometry.size.width * lastLineWidth
                            : geometry.size.width,
                        height: lineHeight
                    )
                }
                .frame(height: lineHeight)
            }
        }
    }
}

// MARK: - Skeleton Avatar

public struct DSSkeletonAvatar: View {
    private let size: DSAvatarSize
    
    public init(size: DSAvatarSize = .md) {
        self.size = size
    }
    
    public var body: some View {
        DSSkeleton(
            width: size.dimension,
            height: size.dimension,
            shape: .circle
        )
    }
}

// MARK: - Skeleton Card

public struct DSSkeletonCard: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let hasImage: Bool
    private let lines: Int
    
    public init(hasImage: Bool = true, lines: Int = 3) {
        self.hasImage = hasImage
        self.lines = lines
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if hasImage {
                DSSkeleton(height: 160)
            }
            
            VStack(alignment: .leading, spacing: SpacingScale.sm.rawValue) {
                DSSkeleton(height: 20, shape: .custom(4))
                DSSkeletonText(lines: lines, lineHeight: 14)
            }
            .padding(InsetTokens.card)
        }
        .background(ColorTokens.Background.elevated.resolved(for: colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: BorderTokens.Component.card, style: .continuous))
        .dsShadow(ShadowTokens.card)
    }
}

// MARK: - Skeleton List Item

public struct DSSkeletonListItem: View {
    private let hasAvatar: Bool
    private let lines: Int
    private let hasTrailing: Bool
    
    public init(
        hasAvatar: Bool = true,
        lines: Int = 2,
        hasTrailing: Bool = false
    ) {
        self.hasAvatar = hasAvatar
        self.lines = lines
        self.hasTrailing = hasTrailing
    }
    
    public var body: some View {
        HStack(spacing: SpacingScale.md.rawValue) {
            if hasAvatar {
                DSSkeletonAvatar(size: .md)
            }
            
            VStack(alignment: .leading, spacing: SpacingScale.xxs.rawValue) {
                DSSkeleton(width: 120, height: 16)
                if lines > 1 {
                    DSSkeleton(width: 80, height: 12)
                }
            }
            
            Spacer()
            
            if hasTrailing {
                DSSkeleton(width: 60, height: 14)
            }
        }
        .padding(.vertical, SpacingScale.md.rawValue)
    }
}

// MARK: - Skeleton Table

public struct DSSkeletonTable: View {
    private let rows: Int
    private let columns: Int
    
    public init(rows: Int = 5, columns: Int = 4) {
        self.rows = rows
        self.columns = columns
    }
    
    public var body: some View {
        VStack(spacing: SpacingScale.sm.rawValue) {
            // Header
            HStack(spacing: SpacingScale.lg.rawValue) {
                ForEach(0..<columns, id: \.self) { _ in
                    DSSkeleton(height: 16, shape: .custom(4))
                }
            }
            .padding(.bottom, SpacingScale.sm.rawValue)
            
            // Rows
            ForEach(0..<rows, id: \.self) { _ in
                HStack(spacing: SpacingScale.lg.rawValue) {
                    ForEach(0..<columns, id: \.self) { _ in
                        DSSkeleton(height: 14)
                    }
                }
                .padding(.vertical, SpacingScale.xs.rawValue)
            }
        }
    }
}

// MARK: - Skeleton Profile

public struct DSSkeletonProfile: View {
    public init() {}
    
    public var body: some View {
        VStack(spacing: SpacingScale.lg.rawValue) {
            DSSkeletonAvatar(size: .xxl)
            
            VStack(spacing: SpacingScale.sm.rawValue) {
                DSSkeleton(width: 150, height: 24, shape: .custom(4))
                DSSkeleton(width: 100, height: 16)
            }
            
            HStack(spacing: SpacingScale.xxl.rawValue) {
                ForEach(0..<3, id: \.self) { _ in
                    VStack(spacing: SpacingScale.xxs.rawValue) {
                        DSSkeleton(width: 40, height: 20)
                        DSSkeleton(width: 60, height: 14)
                    }
                }
            }
        }
    }
}

// MARK: - Conditional Skeleton

public struct DSConditionalSkeleton<Content: View, Skeleton: View>: View {
    let isLoading: Bool
    let content: () -> Content
    let skeleton: () -> Skeleton
    
    public init(
        isLoading: Bool,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder skeleton: @escaping () -> Skeleton
    ) {
        self.isLoading = isLoading
        self.content = content
        self.skeleton = skeleton
    }
    
    public var body: some View {
        if isLoading {
            skeleton()
        } else {
            content()
        }
    }
}

extension View {
    /// Show skeleton when loading
    public func dsLoadingSkeleton<S: View>(
        isLoading: Bool,
        @ViewBuilder skeleton: @escaping () -> S
    ) -> some View {
        DSConditionalSkeleton(
            isLoading: isLoading,
            content: { self },
            skeleton: skeleton
        )
    }
}

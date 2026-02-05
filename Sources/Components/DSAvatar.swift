// DSAvatar.swift
// DesignSystemPro
//
// Production-grade avatar component with image, initials,
// status indicators, and group support.

import SwiftUI

// MARK: - Avatar Size

public enum DSAvatarSize: String, CaseIterable, Sendable {
    case xs   // 24pt
    case sm   // 32pt
    case md   // 40pt
    case lg   // 48pt
    case xl   // 64pt
    case xxl  // 96pt
    
    var dimension: CGFloat {
        switch self {
        case .xs: return 24
        case .sm: return 32
        case .md: return 40
        case .lg: return 48
        case .xl: return 64
        case .xxl: return 96
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .xs: return 10
        case .sm: return 12
        case .md: return 14
        case .lg: return 18
        case .xl: return 24
        case .xxl: return 36
        }
    }
    
    var statusSize: CGFloat {
        switch self {
        case .xs: return 8
        case .sm: return 10
        case .md: return 12
        case .lg: return 14
        case .xl: return 18
        case .xxl: return 24
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .xs, .sm: return 2
        case .md, .lg: return 2.5
        case .xl, .xxl: return 3
        }
    }
}

// MARK: - Avatar Status

public enum DSAvatarStatus: Sendable {
    case online
    case offline
    case busy
    case away
    case none
    
    var color: Color {
        switch self {
        case .online: return PrimitiveColors.Green.green500
        case .offline: return PrimitiveColors.Gray.gray400
        case .busy: return PrimitiveColors.Red.red500
        case .away: return PrimitiveColors.Amber.amber500
        case .none: return .clear
        }
    }
}

// MARK: - DSAvatar

public struct DSAvatar: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let image: Image?
    private let name: String?
    private let size: DSAvatarSize
    private let status: DSAvatarStatus
    private let backgroundColor: Color?
    
    public init(
        image: Image? = nil,
        name: String? = nil,
        size: DSAvatarSize = .md,
        status: DSAvatarStatus = .none,
        backgroundColor: Color? = nil
    ) {
        self.image = image
        self.name = name
        self.size = size
        self.status = status
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            avatarContent
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
            
            if status != .none {
                statusIndicator
            }
        }
    }
    
    @ViewBuilder
    private var avatarContent: some View {
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else if let name = name {
            initialsView(for: name)
        } else {
            placeholderView
        }
    }
    
    private func initialsView(for name: String) -> some View {
        let initials = name
            .split(separator: " ")
            .prefix(2)
            .compactMap { $0.first }
            .map { String($0).uppercased() }
            .joined()
        
        return ZStack {
            (backgroundColor ?? generateColor(from: name))
            
            Text(initials)
                .font(.system(size: size.fontSize, weight: .semibold))
                .foregroundColor(.white)
        }
    }
    
    private var placeholderView: some View {
        ZStack {
            ColorTokens.Background.secondary.resolved(for: colorScheme)
            
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.dimension * 0.5, height: size.dimension * 0.5)
                .foregroundColor(ColorTokens.Foreground.tertiary.resolved(for: colorScheme))
        }
    }
    
    private var statusIndicator: some View {
        Circle()
            .fill(status.color)
            .frame(width: size.statusSize, height: size.statusSize)
            .overlay(
                Circle()
                    .stroke(ColorTokens.Background.primary.resolved(for: colorScheme), lineWidth: size.borderWidth)
            )
            .offset(x: 2, y: 2)
    }
    
    private func generateColor(from string: String) -> Color {
        let colors: [Color] = [
            PrimitiveColors.Blue.blue500,
            PrimitiveColors.Purple.purple500,
            PrimitiveColors.Teal.teal500,
            PrimitiveColors.Pink.pink500,
            PrimitiveColors.Orange.orange500,
            PrimitiveColors.Green.green500,
            PrimitiveColors.Red.red500,
            PrimitiveColors.Amber.amber500
        ]
        
        let hash = string.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return colors[hash % colors.count]
    }
}

// MARK: - Avatar with Border

public struct DSBorderedAvatar: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let avatar: DSAvatar
    private let borderColor: Color?
    
    public init(
        image: Image? = nil,
        name: String? = nil,
        size: DSAvatarSize = .md,
        status: DSAvatarStatus = .none,
        borderColor: Color? = nil
    ) {
        self.avatar = DSAvatar(
            image: image,
            name: name,
            size: size,
            status: status
        )
        self.borderColor = borderColor
    }
    
    public var body: some View {
        avatar
            .overlay(
                Circle()
                    .stroke(
                        borderColor ?? ColorTokens.Background.primary.resolved(for: colorScheme),
                        lineWidth: 3
                    )
            )
    }
}

// MARK: - Avatar Group

public struct DSAvatarGroup: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private let avatars: [AvatarData]
    private let size: DSAvatarSize
    private let maxVisible: Int
    private let overlap: CGFloat
    
    public init(
        avatars: [AvatarData],
        size: DSAvatarSize = .md,
        maxVisible: Int = 4,
        overlap: CGFloat = 0.3
    ) {
        self.avatars = avatars
        self.size = size
        self.maxVisible = maxVisible
        self.overlap = overlap
    }
    
    public var body: some View {
        HStack(spacing: -(size.dimension * overlap)) {
            ForEach(visibleAvatars.indices, id: \.self) { index in
                DSBorderedAvatar(
                    image: visibleAvatars[index].image,
                    name: visibleAvatars[index].name,
                    size: size
                )
                .zIndex(Double(visibleAvatars.count - index))
            }
            
            if remainingCount > 0 {
                remainingCountView
                    .zIndex(0)
            }
        }
    }
    
    private var visibleAvatars: [AvatarData] {
        Array(avatars.prefix(maxVisible))
    }
    
    private var remainingCount: Int {
        max(0, avatars.count - maxVisible)
    }
    
    private var remainingCountView: some View {
        ZStack {
            Circle()
                .fill(ColorTokens.Background.tertiary.resolved(for: colorScheme))
            
            Text("+\(remainingCount)")
                .font(.system(size: size.fontSize, weight: .semibold))
                .foregroundColor(ColorTokens.Foreground.primary.resolved(for: colorScheme))
        }
        .frame(width: size.dimension, height: size.dimension)
        .overlay(
            Circle()
                .stroke(ColorTokens.Background.primary.resolved(for: colorScheme), lineWidth: 3)
        )
    }
}

// MARK: - Avatar Data

public struct AvatarData: Identifiable, Sendable {
    public let id: String
    public let name: String?
    public let image: Image?
    
    public init(
        id: String = UUID().uuidString,
        name: String? = nil,
        image: Image? = nil
    ) {
        self.id = id
        self.name = name
        self.image = image
    }
}

// MARK: - Avatar with Badge

public struct DSAvatarWithBadge: View {
    private let avatar: DSAvatar
    private let badge: String
    
    public init(
        image: Image? = nil,
        name: String? = nil,
        size: DSAvatarSize = .md,
        badge: String
    ) {
        self.avatar = DSAvatar(image: image, name: name, size: size)
        self.badge = badge
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            avatar
            
            DSBadge(badge, variant: .primary, size: .sm)
                .offset(x: 4, y: -4)
        }
    }
}

import SwiftUI

public struct DSBadge: View {
    public let text: String?
    public let number: Int?
    public let style: DSBadgeStyle
    public let size: DSBadgeSize
    public let showDot: Bool
    
    public init(
        text: String? = nil,
        number: Int? = nil,
        style: DSBadgeStyle = .primary,
        size: DSBadgeSize = .medium,
        showDot: Bool = false
    ) {
        self.text = text
        self.number = number
        self.style = style
        self.size = size
        self.showDot = showDot
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            if showDot {
                Circle()
                    .fill(style.backgroundColor)
                    .frame(width: size.dotSize, height: size.dotSize)
            }
            
            if let text = text {
                Text(text)
                    .font(size.font)
                    .fontWeight(size.fontWeight)
                    .foregroundColor(style.textColor)
            } else if let number = number {
                Text("\(number)")
                    .font(size.font)
                    .fontWeight(size.fontWeight)
                    .foregroundColor(style.textColor)
            }
        }
        .padding(.horizontal, size.horizontalPadding)
        .padding(.vertical, size.verticalPadding)
        .background(style.backgroundColor)
        .cornerRadius(size.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: size.cornerRadius)
                .stroke(style.borderColor, lineWidth: style.borderWidth)
        )
        .scaleEffect(showDot && (text == nil && number == nil) ? 1.0 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: showDot)
    }
}

public enum DSBadgeStyle {
    case primary
    case secondary
    case success
    case warning
    case error
    case info
    case custom(DSBadgeStyleConfiguration)
    
    public var backgroundColor: Color {
        switch self {
        case .primary: return .blue
        case .secondary: return Color(.systemGray4)
        case .success: return .green
        case .warning: return .orange
        case .error: return .red
        case .info: return .cyan
        case .custom(let config): return config.backgroundColor
        }
    }
    
    public var textColor: Color {
        switch self {
        case .primary: return .white
        case .secondary: return .primary
        case .success: return .white
        case .warning: return .white
        case .error: return .white
        case .info: return .white
        case .custom(let config): return config.textColor
        }
    }
    
    public var borderColor: Color {
        switch self {
        case .primary: return .clear
        case .secondary: return Color(.systemGray3)
        case .success: return .clear
        case .warning: return .clear
        case .error: return .clear
        case .info: return .clear
        case .custom(let config): return config.borderColor
        }
    }
    
    public var borderWidth: CGFloat {
        switch self {
        case .primary: return 0
        case .secondary: return 1
        case .success: return 0
        case .warning: return 0
        case .error: return 0
        case .info: return 0
        case .custom(let config): return config.borderWidth
        }
    }
}

public struct DSBadgeStyleConfiguration {
    public let backgroundColor: Color
    public let textColor: Color
    public let borderColor: Color
    public let borderWidth: CGFloat
    
    public init(
        backgroundColor: Color,
        textColor: Color,
        borderColor: Color = .clear,
        borderWidth: CGFloat = 0
    ) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
}

public enum DSBadgeSize {
    case small, medium, large
    
    public var font: Font {
        switch self {
        case .small: return .caption2
        case .medium: return .caption
        case .large: return .footnote
        }
    }
    
    public var fontWeight: Font.Weight {
        switch self {
        case .small: return .medium
        case .medium: return .semibold
        case .large: return .bold
        }
    }
    
    public var horizontalPadding: CGFloat {
        switch self {
        case .small: return 6
        case .medium: return 8
        case .large: return 12
        }
    }
    
    public var verticalPadding: CGFloat {
        switch self {
        case .small: return 2
        case .medium: return 4
        case .large: return 6
        }
    }
    
    public var cornerRadius: CGFloat {
        switch self {
        case .small: return 8
        case .medium: return 10
        case .large: return 12
        }
    }
    
    public var dotSize: CGFloat {
        switch self {
        case .small: return 6
        case .medium: return 8
        case .large: return 10
        }
    }
} 
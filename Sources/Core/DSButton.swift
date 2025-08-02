import SwiftUI

/**
 * DSButton - Design System Button Component
 * 
 * A customizable button component that follows the design system guidelines.
 * Supports multiple styles, sizes, and accessibility features.
 * 
 * - Parameters:
 *   - title: Button text
 *   - style: Button style (primary, secondary, tertiary)
 *   - size: Button size (small, medium, large)
 *   - action: Button tap action
 * 
 * - Returns: SwiftUI View
 * 
 * - Example:
 * ```swift
 * DSButton(
 *     title: "Get Started",
 *     style: .primary,
 *     action: { print("Button tapped") }
 * )
 * ```
 */
public struct DSButton: View {
    public let title: String
    public let style: DSButtonStyle
    public let size: DSButtonSize
    public let action: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    
    public init(
        title: String,
        style: DSButtonStyle = .primary,
        size: DSButtonSize = .medium,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(size.font)
                .fontWeight(size.fontWeight)
                .foregroundColor(style.textColor(for: colorScheme))
                .frame(height: size.height)
                .frame(maxWidth: .infinity)
                .background(style.backgroundColor(for: colorScheme))
                .cornerRadius(size.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: size.cornerRadius)
                        .stroke(style.borderColor(for: colorScheme), lineWidth: style.borderWidth)
                )
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1.0 : 0.6)
        .accessibilityLabel(title)
        .accessibilityHint("Double tap to activate")
    }
}

// MARK: - Button Styles
public enum DSButtonStyle {
    case primary
    case secondary
    case tertiary
    case destructive
    
    func backgroundColor(for colorScheme: ColorScheme) -> Color {
        switch self {
        case .primary:
            return colorScheme == .dark ? .blue : .blue
        case .secondary:
            return colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        case .tertiary:
            return .clear
        case .destructive:
            return colorScheme == .dark ? .red : .red
        }
    }
    
    func textColor(for colorScheme: ColorScheme) -> Color {
        switch self {
        case .primary:
            return .white
        case .secondary:
            return colorScheme == .dark ? .white : .black
        case .tertiary:
            return colorScheme == .dark ? .blue : .blue
        case .destructive:
            return .white
        }
    }
    
    func borderColor(for colorScheme: ColorScheme) -> Color {
        switch self {
        case .primary, .destructive:
            return .clear
        case .secondary:
            return colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray3)
        case .tertiary:
            return colorScheme == .dark ? .blue : .blue
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .primary, .destructive:
            return 0
        case .secondary, .tertiary:
            return 1
        }
    }
}

// MARK: - Button Sizes
public enum DSButtonSize {
    case small
    case medium
    case large
    
    var height: CGFloat {
        switch self {
        case .small: return 32
        case .medium: return 44
        case .large: return 56
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .small: return 6
        case .medium: return 8
        case .large: return 12
        }
    }
    
    var font: Font {
        switch self {
        case .small: return .caption
        case .medium: return .body
        case .large: return .title3
        }
    }
    
    var fontWeight: Font.Weight {
        switch self {
        case .small: return .medium
        case .medium: return .semibold
        case .large: return .bold
        }
    }
}

// MARK: - Previews
struct DSButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            DSButton(title: "Primary Button", style: .primary) {
                print("Primary tapped")
            }
            
            DSButton(title: "Secondary Button", style: .secondary) {
                print("Secondary tapped")
            }
            
            DSButton(title: "Tertiary Button", style: .tertiary) {
                print("Tertiary tapped")
            }
            
            DSButton(title: "Destructive Button", style: .destructive) {
                print("Destructive tapped")
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
} 
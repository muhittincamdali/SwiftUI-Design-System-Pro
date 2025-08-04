import SwiftUI

/// A comprehensive tab bar component with customizable styling and functionality
public struct DSTabBar: View {
    
    // MARK: - Properties
    
    /// The currently selected tab index
    @Binding public var selectedIndex: Int
    
    /// Array of tab items
    public let items: [DSTabItem]
    
    /// Tab bar style configuration
    public let style: DSTabBarStyle
    
    /// Whether the tab bar is visible
    public let isVisible: Bool
    
    /// Animation configuration
    public let animation: Animation
    
    // MARK: - Initializers
    
    /// Creates a tab bar with the specified configuration
    /// - Parameters:
    ///   - selectedIndex: Binding to the selected tab index
    ///   - items: Array of tab items
    ///   - style: Tab bar styling
    ///   - isVisible: Whether the tab bar is visible
    ///   - animation: Animation for state changes
    public init(
        selectedIndex: Binding<Int>,
        items: [DSTabItem],
        style: DSTabBarStyle = .default,
        isVisible: Bool = true,
        animation: Animation = .easeInOut(duration: 0.3)
    ) {
        self._selectedIndex = selectedIndex
        self.items = items
        self.style = style
        self.isVisible = isVisible
        self.animation = animation
    }
    
    // MARK: - Body
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                DSTabItemView(
                    item: item,
                    isSelected: selectedIndex == index,
                    style: style.itemStyle
                ) {
                    withAnimation(animation) {
                        selectedIndex = index
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, style.horizontalPadding)
        .padding(.vertical, style.verticalPadding)
        .background(style.backgroundColor)
        .overlay(style.borderColor, alignment: .top)
        .opacity(isVisible ? 1.0 : 0.0)
        .animation(animation, value: selectedIndex)
        .animation(animation, value: isVisible)
    }
}

// MARK: - Tab Item View

/// Individual tab item view
private struct DSTabItemView: View {
    
    // MARK: - Properties
    
    /// The tab item configuration
    public let item: DSTabItem
    
    /// Whether this item is currently selected
    public let isSelected: Bool
    
    /// The styling for this item
    public let style: DSTabItemStyle
    
    /// Action to perform when tapped
    public let action: () -> Void
    
    // MARK: - Body
    
    public var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                // Icon
                Image(systemName: isSelected ? item.selectedIcon : item.icon)
                    .font(style.iconFont)
                    .foregroundColor(isSelected ? style.selectedIconColor : style.iconColor)
                    .scaleEffect(isSelected ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
                
                // Title
                Text(item.title)
                    .font(style.titleFont)
                    .foregroundColor(isSelected ? style.selectedTitleColor : style.titleColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                // Badge
                if let badge = item.badge {
                    DSTabBadge(
                        text: badge,
                        style: style.badgeStyle
                    )
                }
            }
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .fill(isSelected ? style.selectedBackgroundColor : Color.clear)
                    .animation(.easeInOut(duration: 0.2), value: isSelected)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(item.accessibilityLabel)
        .accessibilityHint(item.accessibilityHint)
    }
}

// MARK: - Tab Badge

/// Badge component for tab items
private struct DSTabBadge: View {
    
    // MARK: - Properties
    
    /// The badge text
    public let text: String
    
    /// Badge styling
    public let style: DSTabBadgeStyle
    
    // MARK: - Body
    
    public var body: some View {
        Text(text)
            .font(style.font)
            .foregroundColor(style.textColor)
            .padding(.horizontal, style.horizontalPadding)
            .padding(.vertical, style.verticalPadding)
            .background(
                Capsule()
                    .fill(style.backgroundColor)
            )
            .scaleEffect(text.isEmpty ? 0 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: text)
    }
}

// MARK: - Supporting Types

/// Configuration for individual tab items
public struct DSTabItem {
    /// The title displayed for the tab
    public let title: String
    
    /// The SF Symbol icon name for unselected state
    public let icon: String
    
    /// The SF Symbol icon name for selected state
    public let selectedIcon: String
    
    /// Optional badge text
    public let badge: String?
    
    /// Accessibility label
    public let accessibilityLabel: String
    
    /// Accessibility hint
    public let accessibilityHint: String
    
    /// Creates a tab item
    /// - Parameters:
    ///   - title: Tab title
    ///   - icon: Unselected icon name
    ///   - selectedIcon: Selected icon name
    ///   - badge: Optional badge text
    ///   - accessibilityLabel: Accessibility label
    ///   - accessibilityHint: Accessibility hint
    public init(
        title: String,
        icon: String,
        selectedIcon: String? = nil,
        badge: String? = nil,
        accessibilityLabel: String,
        accessibilityHint: String = ""
    ) {
        self.title = title
        self.icon = icon
        self.selectedIcon = selectedIcon ?? icon
        self.badge = badge
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
    }
}

/// Styling configuration for the tab bar
public struct DSTabBarStyle {
    /// Background color
    public let backgroundColor: Color
    
    /// Border color for the top edge
    public let borderColor: Color
    
    /// Horizontal padding
    public let horizontalPadding: CGFloat
    
    /// Vertical padding
    public let verticalPadding: CGFloat
    
    /// Item styling
    public let itemStyle: DSTabItemStyle
    
    /// Creates a tab bar style
    /// - Parameters:
    ///   - backgroundColor: Background color
    ///   - borderColor: Border color
    ///   - horizontalPadding: Horizontal padding
    ///   - verticalPadding: Vertical padding
    ///   - itemStyle: Item styling
    public init(
        backgroundColor: Color,
        borderColor: Color,
        horizontalPadding: CGFloat,
        verticalPadding: CGFloat,
        itemStyle: DSTabItemStyle
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.itemStyle = itemStyle
    }
    
    /// Default tab bar style
    public static let `default` = DSTabBarStyle(
        backgroundColor: Color(.systemBackground),
        borderColor: Color(.separator),
        horizontalPadding: 16,
        verticalPadding: 8,
        itemStyle: .default
    )
    
    /// Custom tab bar style
    public static func custom(
        backgroundColor: Color,
        borderColor: Color,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 8,
        itemStyle: DSTabItemStyle
    ) -> DSTabBarStyle {
        DSTabBarStyle(
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            horizontalPadding: horizontalPadding,
            verticalPadding: verticalPadding,
            itemStyle: itemStyle
        )
    }
}

/// Styling configuration for tab items
public struct DSTabItemStyle {
    /// Icon font
    public let iconFont: Font
    
    /// Icon color for unselected state
    public let iconColor: Color
    
    /// Icon color for selected state
    public let selectedIconColor: Color
    
    /// Title font
    public let titleFont: Font
    
    /// Title color for unselected state
    public let titleColor: Color
    
    /// Title color for selected state
    public let selectedTitleColor: Color
    
    /// Background color for selected state
    public let selectedBackgroundColor: Color
    
    /// Corner radius
    public let cornerRadius: CGFloat
    
    /// Badge styling
    public let badgeStyle: DSTabBadgeStyle
    
    /// Creates a tab item style
    /// - Parameters:
    ///   - iconFont: Icon font
    ///   - iconColor: Unselected icon color
    ///   - selectedIconColor: Selected icon color
    ///   - titleFont: Title font
    ///   - titleColor: Unselected title color
    ///   - selectedTitleColor: Selected title color
    ///   - selectedBackgroundColor: Selected background color
    ///   - cornerRadius: Corner radius
    ///   - badgeStyle: Badge styling
    public init(
        iconFont: Font,
        iconColor: Color,
        selectedIconColor: Color,
        titleFont: Font,
        titleColor: Color,
        selectedTitleColor: Color,
        selectedBackgroundColor: Color,
        cornerRadius: CGFloat,
        badgeStyle: DSTabBadgeStyle
    ) {
        self.iconFont = iconFont
        self.iconColor = iconColor
        self.selectedIconColor = selectedIconColor
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.selectedTitleColor = selectedTitleColor
        self.selectedBackgroundColor = selectedBackgroundColor
        self.cornerRadius = cornerRadius
        self.badgeStyle = badgeStyle
    }
    
    /// Default tab item style
    public static let `default` = DSTabItemStyle(
        iconFont: .system(size: 24),
        iconColor: .secondary,
        selectedIconColor: .blue,
        titleFont: .caption,
        titleColor: .secondary,
        selectedTitleColor: .blue,
        selectedBackgroundColor: Color.blue.opacity(0.1),
        cornerRadius: 8,
        badgeStyle: .default
    )
}

/// Styling configuration for tab badges
public struct DSTabBadgeStyle {
    /// Badge font
    public let font: Font
    
    /// Badge text color
    public let textColor: Color
    
    /// Badge background color
    public let backgroundColor: Color
    
    /// Horizontal padding
    public let horizontalPadding: CGFloat
    
    /// Vertical padding
    public let verticalPadding: CGFloat
    
    /// Creates a badge style
    /// - Parameters:
    ///   - font: Badge font
    ///   - textColor: Text color
    ///   - backgroundColor: Background color
    ///   - horizontalPadding: Horizontal padding
    ///   - verticalPadding: Vertical padding
    public init(
        font: Font,
        textColor: Color,
        backgroundColor: Color,
        horizontalPadding: CGFloat,
        verticalPadding: CGFloat
    ) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }
    
    /// Default badge style
    public static let `default` = DSTabBadgeStyle(
        font: .caption2.bold(),
        textColor: .white,
        backgroundColor: .red,
        horizontalPadding: 6,
        verticalPadding: 2
    )
}

// MARK: - Preview

struct DSTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            DSTabBar(
                selectedIndex: .constant(0),
                items: [
                    DSTabItem(
                        title: "Home",
                        icon: "house",
                        selectedIcon: "house.fill",
                        accessibilityLabel: "Home tab"
                    ),
                    DSTabItem(
                        title: "Search",
                        icon: "magnifyingglass",
                        selectedIcon: "magnifyingglass",
                        accessibilityLabel: "Search tab"
                    ),
                    DSTabItem(
                        title: "Profile",
                        icon: "person",
                        selectedIcon: "person.fill",
                        badge: "3",
                        accessibilityLabel: "Profile tab"
                    )
                ]
            )
        }
        .previewLayout(.sizeThatFits)
    }
} 
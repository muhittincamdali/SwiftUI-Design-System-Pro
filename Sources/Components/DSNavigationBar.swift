import SwiftUI

/// A comprehensive navigation bar component with customizable styling and functionality
public struct DSNavigationBar: View {
    
    // MARK: - Properties
    
    /// The title displayed in the navigation bar
    public let title: String
    
    /// Optional subtitle displayed below the title
    public let subtitle: String?
    
    /// Leading button configuration
    public let leadingButton: DSNavigationButton?
    
    /// Trailing buttons configuration
    public let trailingButtons: [DSNavigationButton]
    
    /// Background style for the navigation bar
    public let backgroundStyle: DSNavigationBarBackgroundStyle
    
    /// Title style configuration
    public let titleStyle: DSNavigationBarTitleStyle
    
    /// Whether the navigation bar is transparent
    public let isTransparent: Bool
    
    /// Animation configuration
    public let animation: Animation
    
    // MARK: - Initializers
    
    /// Creates a navigation bar with the specified configuration
    /// - Parameters:
    ///   - title: The main title text
    ///   - subtitle: Optional subtitle text
    ///   - leadingButton: Optional leading button
    ///   - trailingButtons: Array of trailing buttons
    ///   - backgroundStyle: Background styling
    ///   - titleStyle: Title styling
    ///   - isTransparent: Whether the bar is transparent
    ///   - animation: Animation for state changes
    public init(
        title: String,
        subtitle: String? = nil,
        leadingButton: DSNavigationButton? = nil,
        trailingButtons: [DSNavigationButton] = [],
        backgroundStyle: DSNavigationBarBackgroundStyle = .default,
        titleStyle: DSNavigationBarTitleStyle = .default,
        isTransparent: Bool = false,
        animation: Animation = .easeInOut(duration: 0.3)
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingButton = leadingButton
        self.trailingButtons = trailingButtons
        self.backgroundStyle = backgroundStyle
        self.titleStyle = titleStyle
        self.isTransparent = isTransparent
        self.animation = animation
    }
    
    // MARK: - Body
    
    public var body: some View {
        HStack(spacing: 16) {
            // Leading button
            leadingButtonView
            
            Spacer()
            
            // Title section
            titleSection
            
            Spacer()
            
            // Trailing buttons
            trailingButtonsView
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundView)
        .animation(animation, value: title)
        .animation(animation, value: subtitle)
        .animation(animation, value: trailingButtons.count)
    }
    
    // MARK: - Private Views
    
    @ViewBuilder
    private var leadingButtonView: some View {
        if let leadingButton = leadingButton {
            DSButton(
                icon: leadingButton.icon,
                style: .icon,
                size: .medium,
                action: leadingButton.action
            )
            .accessibilityLabel(leadingButton.accessibilityLabel)
        } else {
            Color.clear
                .frame(width: 44, height: 44)
        }
    }
    
    @ViewBuilder
    private var titleSection: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(titleStyle.font)
                .foregroundColor(titleStyle.textColor)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(titleStyle.subtitleColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var trailingButtonsView: some View {
        HStack(spacing: 8) {
            ForEach(Array(trailingButtons.enumerated()), id: \.offset) { index, button in
                DSButton(
                    icon: button.icon,
                    style: .icon,
                    size: .medium,
                    action: button.action
                )
                .accessibilityLabel(button.accessibilityLabel)
            }
        }
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        if isTransparent {
            Color.clear
        } else {
            backgroundStyle.color
                .opacity(backgroundStyle.opacity)
        }
    }
}

// MARK: - Supporting Types

/// Configuration for navigation bar buttons
public struct DSNavigationButton {
    /// The SF Symbol icon name
    public let icon: String
    
    /// The action to perform when tapped
    public let action: () -> Void
    
    /// Accessibility label for the button
    public let accessibilityLabel: String
    
    /// Creates a navigation button
    /// - Parameters:
    ///   - icon: SF Symbol icon name
    ///   - action: Action to perform on tap
    ///   - accessibilityLabel: Accessibility label
    public init(
        icon: String,
        action: @escaping () -> Void,
        accessibilityLabel: String
    ) {
        self.icon = icon
        self.action = action
        self.accessibilityLabel = accessibilityLabel
    }
}

/// Background styling for navigation bars
public struct DSNavigationBarBackgroundStyle {
    /// Background color
    public let color: Color
    
    /// Background opacity
    public let opacity: Double
    
    /// Creates a background style
    /// - Parameters:
    ///   - color: Background color
    ///   - opacity: Background opacity
    public init(color: Color, opacity: Double = 1.0) {
        self.color = color
        self.opacity = opacity
    }
    
    /// Default background style
    public static let `default` = DSNavigationBarBackgroundStyle(
        color: Color(.systemBackground),
        opacity: 1.0
    )
    
    /// Blurred background style
    public static let blurred = DSNavigationBarBackgroundStyle(
        color: Color(.systemBackground),
        opacity: 0.8
    )
    
    /// Custom background style
    public static func custom(color: Color, opacity: Double = 1.0) -> DSNavigationBarBackgroundStyle {
        DSNavigationBarBackgroundStyle(color: color, opacity: opacity)
    }
}

/// Title styling for navigation bars
public struct DSNavigationBarTitleStyle {
    /// Title font
    public let font: Font
    
    /// Title text color
    public let textColor: Color
    
    /// Subtitle text color
    public let subtitleColor: Color
    
    /// Creates a title style
    /// - Parameters:
    ///   - font: Title font
    ///   - textColor: Title text color
    ///   - subtitleColor: Subtitle text color
    public init(font: Font, textColor: Color, subtitleColor: Color) {
        self.font = font
        self.textColor = textColor
        self.subtitleColor = subtitleColor
    }
    
    /// Default title style
    public static let `default` = DSNavigationBarTitleStyle(
        font: .title2.bold(),
        textColor: .primary,
        subtitleColor: .secondary
    )
    
    /// Large title style
    public static let large = DSNavigationBarTitleStyle(
        font: .largeTitle.bold(),
        textColor: .primary,
        subtitleColor: .secondary
    )
    
    /// Custom title style
    public static func custom(font: Font, textColor: Color, subtitleColor: Color) -> DSNavigationBarTitleStyle {
        DSNavigationBarTitleStyle(font: font, textColor: textColor, subtitleColor: subtitleColor)
    }
}

// MARK: - Preview

struct DSNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            DSNavigationBar(
                title: "Home",
                subtitle: "Welcome back",
                leadingButton: DSNavigationButton(
                    icon: "line.3.horizontal",
                    action: { print("Menu tapped") },
                    accessibilityLabel: "Menu"
                ),
                trailingButtons: [
                    DSNavigationButton(
                        icon: "bell",
                        action: { print("Notifications") },
                        accessibilityLabel: "Notifications"
                    ),
                    DSNavigationButton(
                        icon: "person.circle",
                        action: { print("Profile") },
                        accessibilityLabel: "Profile"
                    )
                ]
            )
            
            DSNavigationBar(
                title: "Settings",
                backgroundStyle: .blurred,
                titleStyle: .large
            )
            
            DSNavigationBar(
                title: "Profile",
                isTransparent: true
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
} 
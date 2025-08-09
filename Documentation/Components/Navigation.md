# Navigation Components

<!-- TOC START -->
## Table of Contents
- [Navigation Components](#navigation-components)
- [Overview](#overview)
- [Navigation Bar](#navigation-bar)
  - [Basic Usage](#basic-usage)
  - [Advanced Configuration](#advanced-configuration)
  - [Navigation Button](#navigation-button)
    - [Properties](#properties)
  - [Background Styles](#background-styles)
    - [Default Style](#default-style)
    - [Blurred Style](#blurred-style)
    - [Custom Style](#custom-style)
  - [Title Styles](#title-styles)
    - [Default Style](#default-style)
    - [Large Style](#large-style)
    - [Custom Style](#custom-style)
- [Tab Bar](#tab-bar)
  - [Basic Usage](#basic-usage)
  - [Tab Items](#tab-items)
    - [Properties](#properties)
  - [Tab Bar Styles](#tab-bar-styles)
    - [Default Style](#default-style)
    - [Custom Style](#custom-style)
  - [Tab Item Styles](#tab-item-styles)
    - [Default Style](#default-style)
    - [Custom Style](#custom-style)
  - [Badge Styles](#badge-styles)
    - [Default Badge](#default-badge)
    - [Custom Badge](#custom-badge)
- [Search Components](#search-components)
  - [Search Field](#search-field)
- [Best Practices](#best-practices)
  - [Accessibility](#accessibility)
  - [Performance](#performance)
  - [Design Guidelines](#design-guidelines)
- [Examples](#examples)
  - [Complete Navigation Setup](#complete-navigation-setup)
  - [Custom Navigation Bar](#custom-navigation-bar)
  - [Custom Tab Bar](#custom-tab-bar)
- [Troubleshooting](#troubleshooting)
  - [Common Issues](#common-issues)
  - [Debugging Tips](#debugging-tips)
- [Related Components](#related-components)
<!-- TOC END -->


The Design System Pro provides comprehensive navigation components that follow iOS design guidelines and offer extensive customization options.

## Overview

Navigation components are essential for creating intuitive user experiences in iOS applications. Our navigation system includes:

- **Navigation Bars**: Customizable navigation bars with leading and trailing buttons
- **Tab Bars**: Flexible tab bar with badges and custom styling
- **Search Components**: Advanced search functionality with suggestions
- **Breadcrumbs**: Hierarchical navigation indicators

## Navigation Bar

The `DSNavigationBar` component provides a fully customizable navigation bar with support for leading buttons, trailing buttons, titles, and subtitles.

### Basic Usage

```swift
DSNavigationBar(
    title: "Home",
    subtitle: "Welcome back"
)
```

### Advanced Configuration

```swift
DSNavigationBar(
    title: "Profile",
    subtitle: "Edit your information",
    leadingButton: DSNavigationButton(
        icon: "arrow.left",
        action: { /* Back action */ },
        accessibilityLabel: "Back"
    ),
    trailingButtons: [
        DSNavigationButton(
            icon: "bell",
            action: { /* Notifications */ },
            accessibilityLabel: "Notifications"
        ),
        DSNavigationButton(
            icon: "person.circle",
            action: { /* Profile */ },
            accessibilityLabel: "Profile"
        )
    ],
    backgroundStyle: .blurred,
    titleStyle: .large
)
```

### Navigation Button

The `DSNavigationButton` struct represents a button in the navigation bar.

```swift
DSNavigationButton(
    icon: "heart.fill",
    action: { /* Action */ },
    accessibilityLabel: "Like"
)
```

#### Properties

- `icon`: SF Symbol icon name
- `action`: Closure to execute when tapped
- `accessibilityLabel`: Accessibility label for VoiceOver

### Background Styles

#### Default Style
```swift
DSNavigationBarBackgroundStyle.default
```

#### Blurred Style
```swift
DSNavigationBarBackgroundStyle.blurred
```

#### Custom Style
```swift
DSNavigationBarBackgroundStyle.custom(
    color: .blue,
    opacity: 0.8
)
```

### Title Styles

#### Default Style
```swift
DSNavigationBarTitleStyle.default
```

#### Large Style
```swift
DSNavigationBarTitleStyle.large
```

#### Custom Style
```swift
DSNavigationBarTitleStyle.custom(
    font: .largeTitle.bold(),
    textColor: .blue,
    subtitleColor: .blue.opacity(0.7)
)
```

## Tab Bar

The `DSTabBar` component provides a customizable tab bar with support for badges, custom styling, and smooth animations.

### Basic Usage

```swift
@State private var selectedIndex = 0

DSTabBar(
    selectedIndex: $selectedIndex,
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
        )
    ]
)
```

### Tab Items

The `DSTabItem` struct represents a tab in the tab bar.

```swift
DSTabItem(
    title: "Profile",
    icon: "person",
    selectedIcon: "person.fill",
    badge: "3",
    accessibilityLabel: "Profile tab"
)
```

#### Properties

- `title`: Tab title text
- `icon`: SF Symbol icon for unselected state
- `selectedIcon`: SF Symbol icon for selected state
- `badge`: Optional badge text
- `accessibilityLabel`: Accessibility label
- `accessibilityHint`: Optional accessibility hint

### Tab Bar Styles

#### Default Style
```swift
DSTabBarStyle.default
```

#### Custom Style
```swift
DSTabBarStyle.custom(
    backgroundColor: Color(.systemBackground),
    borderColor: Color(.separator),
    horizontalPadding: 16,
    verticalPadding: 8,
    itemStyle: customItemStyle
)
```

### Tab Item Styles

#### Default Style
```swift
DSTabItemStyle.default
```

#### Custom Style
```swift
DSTabItemStyle(
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
```

### Badge Styles

#### Default Badge
```swift
DSTabBadgeStyle.default
```

#### Custom Badge
```swift
DSTabBadgeStyle(
    font: .caption2.bold(),
    textColor: .white,
    backgroundColor: .red,
    horizontalPadding: 6,
    verticalPadding: 2
)
```

## Search Components

### Search Field

The `DSSearchField` component provides advanced search functionality with suggestions.

```swift
@State private var searchText = ""

DSSearchField(
    placeholder: "Search components...",
    text: $searchText,
    suggestions: ["Button", "Card", "Navigation"]
)
```

## Best Practices

### Accessibility

1. **Always provide accessibility labels** for navigation buttons
2. **Use semantic icons** that clearly represent their function
3. **Test with VoiceOver** to ensure proper navigation
4. **Provide clear feedback** for user interactions

### Performance

1. **Limit the number of trailing buttons** to 3-4 maximum
2. **Use lazy loading** for complex navigation hierarchies
3. **Optimize animations** for smooth transitions
4. **Cache navigation states** when appropriate

### Design Guidelines

1. **Follow iOS Human Interface Guidelines**
2. **Maintain consistent spacing** and sizing
3. **Use appropriate color contrast** for accessibility
4. **Provide visual feedback** for user interactions

## Examples

### Complete Navigation Setup

```swift
struct ContentView: View {
    @State private var selectedTabIndex = 0
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom Navigation Bar
                DSNavigationBar(
                    title: "Design System Pro",
                    subtitle: "Navigation Components",
                    leadingButton: DSNavigationButton(
                        icon: "line.3.horizontal",
                        action: { /* Menu action */ },
                        accessibilityLabel: "Menu"
                    ),
                    trailingButtons: [
                        DSNavigationButton(
                            icon: "magnifyingglass",
                            action: { /* Search action */ },
                            accessibilityLabel: "Search"
                        ),
                        DSNavigationButton(
                            icon: "bell",
                            action: { /* Notifications */ },
                            accessibilityLabel: "Notifications"
                        )
                    ],
                    backgroundStyle: .blurred,
                    titleStyle: .large
                )
                
                // Main Content
                ScrollView {
                    VStack(spacing: 20) {
                        // Your content here
                    }
                    .padding()
                }
                
                // Tab Bar
                DSTabBar(
                    selectedIndex: $selectedTabIndex,
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
        }
    }
}
```

### Custom Navigation Bar

```swift
DSNavigationBar(
    title: "Custom Style",
    subtitle: "With custom colors",
    leadingButton: DSNavigationButton(
        icon: "arrow.left",
        action: { /* Back action */ },
        accessibilityLabel: "Back"
    ),
    trailingButtons: [
        DSNavigationButton(
            icon: "ellipsis",
            action: { /* More options */ },
            accessibilityLabel: "More options"
        )
    ],
    backgroundStyle: .custom(color: .blue, opacity: 0.1),
    titleStyle: .custom(
        font: .title.bold(),
        textColor: .blue,
        subtitleColor: .blue.opacity(0.7)
    )
)
```

### Custom Tab Bar

```swift
DSTabBar(
    selectedIndex: $selectedIndex,
    items: tabItems,
    style: .custom(
        backgroundColor: Color(.systemGray6),
        borderColor: Color(.separator),
        horizontalPadding: 20,
        verticalPadding: 12,
        itemStyle: DSTabItemStyle(
            iconFont: .system(size: 28),
            iconColor: .secondary,
            selectedIconColor: .green,
            titleFont: .caption2,
            titleColor: .secondary,
            selectedTitleColor: .green,
            selectedBackgroundColor: Color.green.opacity(0.15),
            cornerRadius: 12,
            badgeStyle: DSTabBadgeStyle(
                font: .caption2.bold(),
                textColor: .white,
                backgroundColor: .red,
                horizontalPadding: 4,
                verticalPadding: 2
            )
        )
    )
)
```

## Troubleshooting

### Common Issues

1. **Navigation bar not updating**: Ensure you're using `@State` or `@Binding` for dynamic content
2. **Tab bar not responding**: Check that the `selectedIndex` binding is properly connected
3. **Accessibility issues**: Verify all buttons have proper accessibility labels
4. **Performance problems**: Consider using `@StateObject` for complex navigation state

### Debugging Tips

1. **Use Xcode's View Debugger** to inspect navigation hierarchies
2. **Test on different device sizes** to ensure proper layout
3. **Verify accessibility** with VoiceOver enabled
4. **Check console logs** for any warnings or errors

## Related Components

- [Buttons](Button.md) - For navigation actions
- [Cards](Card.md) - For content presentation
- [Forms](Form.md) - For data input
- [Themes](Theme.md) - For consistent styling 
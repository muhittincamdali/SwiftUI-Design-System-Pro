# 🚀 Getting Started

<!-- TOC START -->
## Table of Contents
- [🚀 Getting Started](#-getting-started)
- [📋 Requirements](#-requirements)
  - [Development Environment](#development-environment)
  - [Device Support](#device-support)
- [⚡ Quick Setup](#-quick-setup)
  - [1. 🍴 Clone the Repository](#1-clone-the-repository)
- [Clone the repository](#clone-the-repository)
- [Navigate to project directory](#navigate-to-project-directory)
  - [2. 📦 Install Dependencies](#2-install-dependencies)
- [Open in Xcode](#open-in-xcode)
  - [3. 🎯 Basic Implementation](#3-basic-implementation)
- [🎨 Component Usage](#-component-usage)
  - [Buttons](#buttons)
  - [Cards](#cards)
  - [Form Components](#form-components)
- [🌙 Dark/Light Mode](#-darklight-mode)
- [♿ Accessibility](#-accessibility)
- [⚡ Performance](#-performance)
- [🧪 Testing](#-testing)
  - [Unit Tests](#unit-tests)
  - [UI Tests](#ui-tests)
- [📚 Next Steps](#-next-steps)
- [🤝 Contributing](#-contributing)
- [📞 Support](#-support)
<!-- TOC END -->


Welcome to the SwiftUI Design System Pro! This guide will help you get started with our comprehensive design system in just 5 minutes.

## 📋 Requirements

### Development Environment
- **macOS 12.0+** (Monterey or later)
- **Xcode 14.0+** (Latest stable version recommended)
- **iOS 15.0+** (Minimum deployment target)
- **Swift 5.7+** (Latest Swift version)

### Device Support
- **iPhone**: iOS 15.0+
- **iPad**: iPadOS 15.0+
- **macOS**: macOS 12.0+ (Catalyst support)
- **watchOS**: watchOS 8.0+ (Optional)

## ⚡ Quick Setup

### 1. 🍴 Clone the Repository
```bash
# Clone the repository
git clone https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git

# Navigate to project directory
cd SwiftUI-Design-System-Pro
```

### 2. 📦 Install Dependencies
```bash
# Open in Xcode
open SwiftUI-Design-System-Pro.xcodeproj
```

### 3. 🎯 Basic Implementation
```swift
import SwiftUI
import DesignSystemPro

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Primary Button
            DSButton(
                title: "Get Started",
                style: .primary,
                action: { print("Button tapped") }
            )
            
            // Card Component
            DSCard(
                title: "Welcome",
                subtitle: "Start building amazing apps",
                image: "star.fill"
            )
            
            // Text Field
            DSTextField(
                placeholder: "Enter your name",
                text: $name
            )
        }
        .padding()
    }
}
```

## 🎨 Component Usage

### Buttons
```swift
// Primary Button
DSButton(
    title: "Primary Action",
    style: .primary,
    size: .large,
    action: { /* Action */ }
)

// Secondary Button
DSButton(
    title: "Secondary Action",
    style: .secondary,
    size: .medium,
    action: { /* Action */ }
)

// Destructive Button
DSButton(
    title: "Delete",
    style: .destructive,
    action: { /* Action */ }
)
```

### Cards
```swift
// Basic Card
DSCard(
    title: "Card Title",
    subtitle: "Card subtitle with description",
    image: "star.fill"
)

// Product Card
DSProductCard(
    title: "iPhone 15 Pro",
    price: "$999",
    image: "iphone",
    rating: 4.5,
    action: { /* Action */ }
)

// Profile Card
DSProfileCard(
    name: "John Doe",
    role: "iOS Developer",
    avatar: "person.circle.fill",
    action: { /* Action */ }
)
```

### Form Components
```swift
// Text Field
DSTextField(
    placeholder: "Enter email",
    text: $email,
    validation: .email
)

// Search Field
DSSearchField(
    placeholder: "Search products",
    text: $searchText,
    suggestions: suggestions
)
```

## 🌙 Dark/Light Mode

The design system automatically supports dark and light modes:

```swift
// Theme Manager
class DSThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false
    
    var currentTheme: DSTheme {
        isDarkMode ? .dark : .light
    }
}

// Usage
@Environment(\.colorScheme) var colorScheme

DSButton(
    title: "Theme Aware",
    style: .primary
)
.background(colorScheme == .dark ? Color.darkBackground : Color.lightBackground)
```

## ♿ Accessibility

All components include built-in accessibility features:

```swift
// VoiceOver Support
DSButton(
    title: "Submit",
    accessibilityLabel: "Submit form",
    accessibilityHint: "Double tap to submit the form"
)

// Dynamic Type
DSText(
    "Welcome",
    style: .heading,
    size: .large
)
.font(.system(size: 24, weight: .bold, design: .default))
.dynamicTypeSize(.large...(.accessibility3))
```

## ⚡ Performance

The design system is optimized for performance:

```swift
// Lazy Loading
LazyVStack {
    ForEach(items) { item in
        DSCard(item: item)
    }
}

// Image Optimization
DSImage(
    "hero-image",
    cachePolicy: .memoryAndDisk
)

// Animation Performance
withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
    // Smooth animations
}
```

## 🧪 Testing

### Unit Tests
```swift
class DSButtonTests: XCTestCase {
    func testPrimaryButtonRendering() {
        // Given
        let button = DSButton(
            title: "Test",
            style: .primary,
            action: {}
        )
        
        // When
        let view = button.body
        
        // Then
        XCTAssertNotNil(view)
    }
}
```

### UI Tests
```swift
class DSButtonUITests: XCTestCase {
    func testButtonTapAction() {
        let app = XCUIApplication()
        app.launch()
        
        let button = app.buttons["Primary Button"]
        button.tap()
        
        // Verify action
    }
}
```

## 📚 Next Steps

1. **Explore Components**: Check out all available components in the [Components Guide](../Components/README.md)
2. **Customize Themes**: Learn about theming in the [Themes Guide](../Themes/README.md)
3. **Accessibility**: Read the [Accessibility Guide](../Accessibility/README.md)
4. **Performance**: Optimize your app with the [Performance Guide](../Performance/README.md)
5. **Testing**: Set up comprehensive testing with the [Testing Guide](../Testing/README.md)

## 🤝 Contributing

Want to contribute to the design system? Check out our [Contributing Guidelines](../../CONTRIBUTING.md) for details.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/issues)
- **Discussions**: [GitHub Discussions](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/discussions)
- **Documentation**: [Full Documentation](../README.md)

---

**🎨 Start building beautiful apps with SwiftUI Design System Pro!** 
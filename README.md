# SwiftUI Design System Pro

<p align="center">
  <img src="Assets/banner.png" alt="SwiftUI Design System Pro" width="800">
</p>

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-5.9+-F05138?style=flat&logo=swift&logoColor=white" alt="Swift"></a>
  <a href="https://developer.apple.com/ios/"><img src="https://img.shields.io/badge/iOS-15.0+-000000?style=flat&logo=apple&logoColor=white" alt="iOS"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License"></a>
  <a href="https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/actions"><img src="https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
</p>

<p align="center">
  <b>A complete design system for SwiftUI with reusable components, design tokens, and theming.</b>
</p>

---

## Preview

<p align="center">
  <img src="Assets/components-preview.png" alt="Components" width="700">
</p>

## Features

- **Design Tokens** — Colors, typography, spacing, shadows
- **50+ Components** — Buttons, cards, inputs, navigation, and more
- **Theming** — Light/dark mode with custom theme support
- **Accessibility** — VoiceOver, Dynamic Type, reduced motion
- **Responsive** — Adaptive layouts for all screen sizes

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git", from: "1.0.0")
]
```

## Quick Start

```swift
import SwiftUIDesignSystemPro

struct ContentView: View {
    @StateObject private var theme = Theme.shared
    
    var body: some View {
        VStack(spacing: Spacing.md) {
            DSText("Welcome", style: .title)
            
            DSButton("Get Started", style: .primary) {
                // Action
            }
        }
        .padding(Spacing.lg)
        .environmentObject(theme)
    }
}
```

## Design Tokens

### Colors

```swift
// Semantic colors
Color.ds.primary        // Brand primary
Color.ds.secondary      // Brand secondary
Color.ds.background     // Background color
Color.ds.surface        // Card/surface color
Color.ds.text           // Primary text
Color.ds.textSecondary  // Secondary text
Color.ds.success        // Success state
Color.ds.warning        // Warning state
Color.ds.error          // Error state
```

### Typography

```swift
DSText("Heading", style: .h1)      // 34pt Bold
DSText("Heading", style: .h2)      // 28pt Bold
DSText("Heading", style: .h3)      // 22pt Semibold
DSText("Body", style: .body)       // 17pt Regular
DSText("Caption", style: .caption) // 12pt Regular
```

### Spacing

```swift
Spacing.xs   // 4pt
Spacing.sm   // 8pt
Spacing.md   // 16pt
Spacing.lg   // 24pt
Spacing.xl   // 32pt
Spacing.xxl  // 48pt
```

## Components

### Buttons

```swift
// Primary button
DSButton("Submit", style: .primary) { }

// Secondary button
DSButton("Cancel", style: .secondary) { }

// Outline button
DSButton("Learn More", style: .outline) { }

// Text button
DSButton("Skip", style: .text) { }

// Loading state
DSButton("Saving...", style: .primary, isLoading: true) { }

// Disabled state
DSButton("Submit", style: .primary, isDisabled: true) { }
```

### Cards

```swift
DSCard {
    VStack(alignment: .leading, spacing: Spacing.sm) {
        DSText("Card Title", style: .h3)
        DSText("Card description goes here.", style: .body)
    }
}

// Elevated card
DSCard(elevation: .high) {
    // Content
}
```

### Text Fields

```swift
@State private var email = ""
@State private var password = ""

DSTextField("Email", text: $email, icon: "envelope")
    .keyboardType(.emailAddress)

DSSecureField("Password", text: $password, icon: "lock")
```

### Navigation

```swift
// Tab bar
DSTabBar(selection: $selectedTab) {
    DSTabItem("Home", icon: "house", tag: 0)
    DSTabItem("Search", icon: "magnifyingglass", tag: 1)
    DSTabItem("Profile", icon: "person", tag: 2)
}

// Navigation bar
DSNavigationBar(title: "Settings") {
    DSBarButton(icon: "gear") { }
}
```

### Lists

```swift
DSList {
    ForEach(items) { item in
        DSListRow(
            title: item.title,
            subtitle: item.subtitle,
            icon: item.icon
        )
    }
}
```

## Theming

### Custom Theme

```swift
struct CustomTheme: ThemeProtocol {
    var colors: ThemeColors {
        ThemeColors(
            primary: Color("BrandPrimary"),
            secondary: Color("BrandSecondary"),
            background: Color("Background"),
            surface: Color("Surface"),
            text: Color("Text")
        )
    }
    
    var typography: ThemeTypography {
        ThemeTypography(
            fontFamily: "SF Pro Display"
        )
    }
}

// Apply theme
Theme.shared.apply(CustomTheme())
```

### Dark Mode

```swift
// Automatic dark mode support
DSCard {
    DSText("Adapts to system appearance", style: .body)
}
.preferredColorScheme(.dark) // Force dark mode
```

## Project Structure

```
SwiftUI-Design-System-Pro/
├── Sources/
│   ├── Core/           # Foundation utilities
│   ├── Theme/          # Design tokens & theming
│   ├── Components/     # UI components
│   │   ├── Buttons/
│   │   ├── Cards/
│   │   ├── Inputs/
│   │   ├── Navigation/
│   │   └── Feedback/
│   └── Utils/          # Helpers & extensions
├── Examples/           # Sample app
├── Tests/              # Unit tests
└── Documentation/      # Guides
```

## Requirements

- iOS 15.0+
- macOS 12.0+
- Xcode 15.0+
- Swift 5.9+

## Documentation

- [Getting Started](Documentation/GettingStarted.md)
- [Design Tokens](Documentation/DesignTokens.md)
- [Components](Documentation/Components.md)
- [Theming Guide](Documentation/Theming.md)
- [Accessibility](Documentation/Accessibility.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License. See [LICENSE](LICENSE).

## Author

**Muhittin Camdali** — [@muhittincamdali](https://github.com/muhittincamdali)

---

<p align="center">
  <sub>Design systems that developers love ❤️</sub>
</p>

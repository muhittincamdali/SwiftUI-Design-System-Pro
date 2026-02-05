# DesignSystemPro

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2015+%20|%20macOS%2012+%20|%20visionOS-blue.svg)](https://developer.apple.com)
[![SPM](https://img.shields.io/badge/SPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](LICENSE)

**The most comprehensive SwiftUI design system for building world-class iOS applications.** Production-ready design tokens, enterprise components, and a powerful theme engine.

```
╔══════════════════════════════════════════════════════════════════════════╗
║                         DESIGNSYSTEMPRO 2.0                              ║
║                                                                          ║
║   🎨 Design Tokens   •   🧩 50+ Components   •   🎭 Theme Engine         ║
║   ♿ Accessible      •   🏢 Enterprise-Ready  •   📱 Multi-Platform      ║
╚══════════════════════════════════════════════════════════════════════════╝
```

## ✨ Features

### 🎨 Complete Design Token System

| Token Type | Description | Examples |
|------------|-------------|----------|
| **Colors** | Semantic color palette with light/dark support | Primary, Secondary, Status, Interactive |
| **Typography** | Type scale with 16 sizes | Display, Heading, Body, UI, Code |
| **Spacing** | 8pt grid system | 15 spacing values from 0-96pt |
| **Shadows** | Multi-layer shadow system | 6 elevation levels |
| **Borders** | Radius and width tokens | Component-specific radii |
| **Animations** | Timing and easing tokens | Micro, Page, Feedback animations |

### 🧩 Production Components

```
┌─────────────────────────────────────────────────────────────────────────┐
│  BUTTONS        │  INPUTS          │  DISPLAY        │  FEEDBACK       │
├─────────────────┼──────────────────┼─────────────────┼─────────────────┤
│  DSButton       │  DSTextField     │  DSCard         │  DSToast        │
│  DSIconButton   │  DSTextArea      │  DSBadge        │  DSAlert        │
│  DSButtonGroup  │  DSSearchField   │  DSAvatar       │  DSModal        │
│                 │  DSOTPField      │  DSSkeleton     │  DSSnackbar     │
├─────────────────┼──────────────────┼─────────────────┼─────────────────┤
│  SELECTION      │  NAVIGATION      │  DATA           │  LAYOUT         │
├─────────────────┼──────────────────┼─────────────────┼─────────────────┤
│  DSToggle       │  DSNavigationBar │  DSChart        │  DSCard         │
│  DSCheckbox     │  DSTabBar        │  DSProgressBar  │  DSListCard     │
│  DSRadio        │  DSSearchField   │  DSStatCard     │  DSMediaCard    │
│  DSSwitch       │                  │                 │                 │
└─────────────────┴──────────────────┴─────────────────┴─────────────────┘
```

### 🎭 Theme Engine

- **Light/Dark Mode** - Automatic adaptation
- **Custom Themes** - Brand customization
- **White-Label** - Enterprise support
- **Preset Themes** - Ocean, Forest, Sunset, Lavender
- **Runtime Switching** - Instant theme changes

## 📦 Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/SwiftUI-Design-System-Pro", from: "2.0.0")
]
```

### Modular Imports

```swift
// Full system
import DesignSystemPro

// Tokens only (custom implementations)
import DesignSystemProCore

// Components only
import DesignSystemProComponents

// Theme engine only
import DesignSystemProTheme
```

## 🚀 Quick Start

### 1. Setup Your App

```swift
import SwiftUI
import DesignSystemPro

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            DSApp {
                ContentView()
            }
        }
    }
}
```

### 2. Use Components

```swift
struct ContentView: View {
    @State private var email = ""
    @State private var isEnabled = true
    
    var body: some View {
        VStack(spacing: SpacingScale.lg.rawValue) {
            // Text Field
            DSTextField(
                "Email",
                text: $email,
                placeholder: "Enter your email",
                leadingIcon: Image(systemName: "envelope")
            )
            
            // Toggle
            DSToggle(isOn: $isEnabled, label: "Enable notifications")
            
            // Buttons
            DSButton.primary("Submit") {
                print("Submitted!")
            }
            
            DSButton("Cancel", variant: .secondary) {
                print("Cancelled")
            }
        }
        .dsScreenEdgePadding()
    }
}
```

### 3. Use Design Tokens

```swift
// Typography
Text("Welcome")
    .dsTypography(TypographyTokens.Display.large)

Text("Subtitle")
    .dsHeadingStyle(.h2)

// Colors
.foregroundColor(ColorTokens.Foreground.primary.light)
.background(ColorTokens.Background.secondary.light)

// Spacing
.padding(SpacingScale.lg.rawValue)
.dsPadding(.xl)

// Shadows
.dsShadow(ShadowTokens.card)
.dsElevation(.level2)

// Borders
.dsCornerRadius(.lg)
.dsStrokeBorder()
```

## 🎨 Design Tokens

### Color System

```swift
// Semantic Colors
ColorTokens.Background.primary      // Main background
ColorTokens.Foreground.primary      // Primary text
ColorTokens.Accent.primary          // Brand color
ColorTokens.Status.success          // Success state
ColorTokens.Border.focus            // Focus ring

// With Color Scheme
let color = ColorTokens.Accent.primary.resolved(for: colorScheme)

// Accessibility
let highContrastColor = ColorTokens.Accent.primary.resolved(
    for: colorScheme, 
    highContrast: true
)
```

### Typography Scale

```swift
// Displays (Hero titles)
TypographyTokens.Display.hero      // 72pt bold
TypographyTokens.Display.title     // 60pt bold
TypographyTokens.Display.large     // 48pt semibold

// Headings
TypographyTokens.Heading.h1        // 24pt bold
TypographyTokens.Heading.h2        // 20pt semibold
TypographyTokens.Heading.h3        // 18pt semibold

// Body
TypographyTokens.Body.large        // 18pt regular
TypographyTokens.Body.medium       // 16pt regular (base)
TypographyTokens.Body.small        // 14pt regular

// UI Elements
TypographyTokens.UI.button         // 14pt semibold
TypographyTokens.UI.caption        // 12pt regular
TypographyTokens.UI.badge          // 9pt semibold
```

### Spacing (8pt Grid)

```swift
SpacingScale.none      // 0pt
SpacingScale.xxs       // 4pt
SpacingScale.xs        // 6pt
SpacingScale.sm        // 8pt   ← Base unit
SpacingScale.md        // 12pt
SpacingScale.lg        // 16pt  ← Most common
SpacingScale.xl        // 20pt
SpacingScale.xxl       // 24pt
SpacingScale.xxxl      // 32pt
SpacingScale.huge      // 40pt
SpacingScale.massive   // 48pt
```

## 🎭 Theming

### Use Built-in Themes

```swift
// Set theme
ThemeManager.shared.setTheme(DarkTheme())

// Use preset themes
ThemeManager.shared.setTheme(PresetThemes.ocean)
ThemeManager.shared.setTheme(PresetThemes.forest)

// Follow system
ThemeManager.shared.followSystem = true
```

### Create Custom Theme

```swift
let brandTheme = CustomTheme(
    id: "myBrand",
    name: "My Brand",
    colorScheme: .light,
    colors: ThemeColors(
        accent: Color.purple,
        accentSecondary: Color.pink
    ),
    borders: ThemeBorders(
        radiusMedium: 12
    )
)

ThemeManager.shared.setTheme(brandTheme)
```

### White-Label Configuration

```swift
let brand = BrandConfiguration(
    primaryColor: Color(hex: "#FF5722"),
    secondaryColor: Color(hex: "#3F51B5"),
    fontFamily: "CustomFont"
)

let config = WhiteLabelConfiguration(
    brand: brand,
    appName: "MyApp"
)

// Use generated themes
ThemeManager.shared.setTheme(config.lightTheme)
```

## 📱 Component Examples

### Cards

```swift
// Basic Card
DSCard {
    VStack(alignment: .leading) {
        Text("Card Title").dsHeadingStyle(.h3)
        Text("Card content goes here").dsBodyStyle(.medium)
    }
}

// Interactive Card
DSCard(isInteractive: true) {
    // Content
} action: {
    print("Card tapped")
}

// Stat Card
DSStatCard(
    title: "Revenue",
    value: "$12,450",
    change: "+12.5%",
    isPositive: true,
    icon: Image(systemName: "chart.line.uptrend.xyaxis")
)

// Media Card
DSMediaCard(image: Image("header")) {
    Text("Article Title").dsHeadingStyle(.h4)
    Text("Preview text...").dsBodyStyle(.small)
}
```

### Badges & Avatars

```swift
// Badges
DSBadge("New", variant: .success)
DSBadge("3", variant: .error)
DSStatusBadge("Active", variant: .success)
DSCounterBadge(count: 99, maxCount: 99)

// Avatars
DSAvatar(name: "John Doe", size: .lg, status: .online)
DSAvatarGroup(
    avatars: [
        AvatarData(name: "Alice"),
        AvatarData(name: "Bob"),
        AvatarData(name: "Charlie")
    ],
    maxVisible: 3
)
```

### Toasts

```swift
// Show toasts
DSToastManager.shared.success("Saved successfully!")
DSToastManager.shared.error("Failed to save")
DSToastManager.shared.warning("Check your input")
DSToastManager.shared.info("New update available")

// With action
DSToastManager.shared.show(
    DSToastData(
        title: "Item deleted",
        message: "This action can be undone",
        variant: .warning,
        action: ToastAction(label: "Undo") {
            // Undo action
        }
    )
)
```

### Skeleton Loading

```swift
// Basic skeleton
DSSkeleton(width: 200, height: 20)

// Text skeleton
DSSkeletonText(lines: 3)

// Card skeleton
DSSkeletonCard(hasImage: true)

// Conditional loading
content
    .dsLoadingSkeleton(isLoading: isLoading) {
        DSSkeletonCard()
    }
```

## ♿ Accessibility

DesignSystemPro is built with accessibility in mind:

- **VoiceOver** - Full support with proper labels
- **Dynamic Type** - Scales with system font size
- **Reduce Motion** - Respects accessibility settings
- **High Contrast** - Enhanced contrast support
- **WCAG Compliance** - Color contrast utilities included

```swift
// Check accessibility preferences
if DSAccessibility.prefersReducedMotion {
    // Use simplified animations
}

// Color contrast check
let isAccessible = ColorContrastUtility.meetsWCAG_AA(
    foregroundColor,
    backgroundColor
)
```

## 📊 Requirements

| Platform | Minimum Version |
|----------|----------------|
| iOS | 15.0+ |
| macOS | 12.0+ |
| watchOS | 8.0+ |
| tvOS | 15.0+ |
| visionOS | 1.0+ |

- **Swift**: 5.9+
- **Xcode**: 15.0+

## 🏗️ Architecture

```
SwiftUI-Design-System-Pro/
├── Sources/
│   ├── Core/
│   │   ├── Tokens/
│   │   │   ├── ColorTokens.swift
│   │   │   ├── TypographyTokens.swift
│   │   │   ├── SpacingTokens.swift
│   │   │   ├── ShadowTokens.swift
│   │   │   ├── BorderTokens.swift
│   │   │   └── AnimationTokens.swift
│   │   └── Utilities/
│   ├── Components/
│   │   ├── DSButton.swift
│   │   ├── DSTextField.swift
│   │   ├── DSCard.swift
│   │   ├── DSBadge.swift
│   │   ├── DSAvatar.swift
│   │   ├── DSToast.swift
│   │   ├── DSToggle.swift
│   │   └── DSSkeleton.swift
│   ├── Theme/
│   │   └── ThemeEngine.swift
│   └── DesignSystemPro/
│       └── DesignSystemPro.swift
├── Tests/
└── Examples/
```

## 🤝 Contributing

Contributions are welcome! Please read our contributing guidelines before submitting PRs.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Built with ❤️ for the SwiftUI community
</p>

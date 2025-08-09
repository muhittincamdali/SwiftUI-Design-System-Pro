# 🚀 Getting Started Guide

<!-- TOC START -->
## Table of Contents
- [🚀 Getting Started Guide](#-getting-started-guide)
- [📋 Table of Contents](#-table-of-contents)
- [🎯 Prerequisites](#-prerequisites)
  - [System Requirements](#system-requirements)
  - [Development Environment](#development-environment)
- [📦 Installation](#-installation)
  - [Swift Package Manager (Recommended)](#swift-package-manager-recommended)
  - [Manual Installation](#manual-installation)
- [Clone the repository](#clone-the-repository)
- [Navigate to project directory](#navigate-to-project-directory)
- [Install dependencies](#install-dependencies)
- [Open in Xcode](#open-in-xcode)
  - [CocoaPods (Alternative)](#cocoapods-alternative)
- [Podfile](#podfile)
- [⚙️ Configuration](#-configuration)
  - [Basic Setup](#basic-setup)
  - [Advanced Configuration](#advanced-configuration)
- [🎨 First Steps](#-first-steps)
  - [1. Import the Framework](#1-import-the-framework)
  - [2. Use Design Tokens](#2-use-design-tokens)
  - [3. Use Components](#3-use-components)
- [📱 Basic Examples](#-basic-examples)
  - [Simple Layout](#simple-layout)
  - [Form Example](#form-example)
  - [List Example](#list-example)
- [🔧 Customization](#-customization)
  - [Custom Theme](#custom-theme)
  - [Custom Components](#custom-components)
  - [Custom Animations](#custom-animations)
- [🚀 Next Steps](#-next-steps)
  - [1. Explore Components](#1-explore-components)
  - [2. Learn Design Tokens](#2-learn-design-tokens)
  - [3. Master Accessibility](#3-master-accessibility)
  - [4. Advanced Features](#4-advanced-features)
  - [5. Examples and Templates](#5-examples-and-templates)
- [🎯 Best Practices](#-best-practices)
  - [1. Always Use Design Tokens](#1-always-use-design-tokens)
  - [2. Maintain Consistency](#2-maintain-consistency)
  - [3. Respect Accessibility](#3-respect-accessibility)
  - [4. Optimize Performance](#4-optimize-performance)
- [🆘 Troubleshooting](#-troubleshooting)
  - [Common Issues](#common-issues)
  - [Getting Help](#getting-help)
<!-- TOC END -->


**SwiftUI Design System Pro** - Complete Getting Started Guide

## 📋 Table of Contents

- [🎯 Prerequisites](#-prerequisites)
- [📦 Installation](#-installation)
- [⚙️ Configuration](#️-configuration)
- [🎨 First Steps](#-first-steps)
- [📱 Basic Examples](#-basic-examples)
- [🔧 Customization](#-customization)
- [🚀 Next Steps](#-next-steps)

---

## 🎯 Prerequisites

### System Requirements

- **iOS 15.0+** with iOS 15.0+ SDK
- **Swift 5.9+** programming language
- **Xcode 15.0+** development environment
- **Git** version control system
- **Swift Package Manager** for dependency management

### Development Environment

1. **Install Xcode 15.0+** from the Mac App Store
2. **Update to latest Swift version** (5.9+)
3. **Install Git** if not already installed
4. **Configure Swift Package Manager** in Xcode

---

## 📦 Installation

### Swift Package Manager (Recommended)

1. **Open Xcode** and create a new project or open existing project
2. **Add Package Dependency**:
   - Go to `File` → `Add Package Dependencies`
   - Enter URL: `https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git`
   - Click `Add Package`

3. **Select Target**:
   - Choose your app target
   - Select `DesignSystemPro` package
   - Click `Add Package`

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git

# Navigate to project directory
cd SwiftUI-Design-System-Pro

# Install dependencies
swift package resolve

# Open in Xcode
open Package.swift
```

### CocoaPods (Alternative)

```ruby
# Podfile
pod 'SwiftUI-Design-System-Pro', :git => 'https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git'
```

---

## ⚙️ Configuration

### Basic Setup

```swift
import SwiftUI
import DesignSystemPro

// Configure design system
struct AppDesignSystem {
    static func configure() {
        // Set up design tokens
        DesignTokenManager.shared.configure()
        
        // Set up component library
        ComponentLibrary.shared.configure()
        
        // Set up accessibility
        AccessibilityManager.shared.configure()
    }
}

// Use in your app
@main
struct MyApp: App {
    init() {
        AppDesignSystem.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### Advanced Configuration

```swift
// Custom design token configuration
struct CustomDesignTokens {
    static let colors = CustomColors.self
    static let typography = CustomTypography.self
    static let spacing = CustomSpacing.self
}

// Custom colors
struct CustomColors {
    static let primary = Color("CustomPrimary")
    static let secondary = Color("CustomSecondary")
    static let background = Color("CustomBackground")
}

// Custom typography
struct CustomTypography {
    static let headlineMedium = Font.custom("CustomFont", size: 24)
    static let bodyMedium = Font.custom("CustomFont", size: 16)
}

// Custom spacing
struct CustomSpacing {
    static let md: CGFloat = 20
    static let lg: CGFloat = 32
}

// Apply custom configuration
DesignTokenManager.shared.configure(with: CustomDesignTokens.self)
```

---

## 🎨 First Steps

### 1. Import the Framework

```swift
import SwiftUI
import DesignSystemPro
```

### 2. Use Design Tokens

```swift
struct FirstView: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            Text("Welcome to Design System Pro")
                .font(AppTypography.headlineMedium)
                .foregroundColor(AppColors.primary)
            
            Text("This is your first step")
                .font(AppTypography.bodyMedium)
                .foregroundColor(AppColors.textSecondary)
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 3. Use Components

```swift
struct ComponentExample: View {
    var body: some View {
        VStack(spacing: AppSpacing.md) {
            PrimaryButton(title: "Get Started") {
                print("Button tapped")
            }
            
            Card {
                Text("This is a card component")
                    .font(AppTypography.bodyMedium)
            }
        }
        .padding(AppSpacing.lg)
    }
}
```

---

## 📱 Basic Examples

### Simple Layout

```swift
struct SimpleLayoutExample: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppSpacing.lg) {
                    // Header
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Simple Layout")
                            .font(AppTypography.displayMedium)
                            .foregroundColor(AppColors.primary)
                        
                        Text("Demonstrating basic layout with design system")
                            .font(AppTypography.bodyMedium)
                            .foregroundColor(AppColors.textSecondary)
                    }
                    
                    // Content
                    VStack(spacing: AppSpacing.md) {
                        ForEach(0..<3) { index in
                            Card {
                                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                                    Text("Item \(index + 1)")
                                        .font(AppTypography.titleMedium)
                                    
                                    Text("Description for item \(index + 1)")
                                        .font(AppTypography.bodyMedium)
                                        .foregroundColor(AppColors.textSecondary)
                                }
                            }
                        }
                    }
                }
                .padding(AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationBarHidden(true)
        }
    }
}
```

### Form Example

```swift
struct FormExample: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Header
            VStack(spacing: AppSpacing.md) {
                Text("Sign In")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Enter your credentials")
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            // Form
            VStack(spacing: AppSpacing.md) {
                TextField("Email", text: $email)
                    .textFieldStyle(DesignSystemTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .textFieldStyle(DesignSystemTextFieldStyle())
                
                PrimaryButton(title: "Sign In") {
                    // Handle sign in
                }
                
                SecondaryButton(title: "Forgot Password?") {
                    // Handle forgot password
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### List Example

```swift
struct ListExample: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                HStack(spacing: AppSpacing.md) {
                    Circle()
                        .fill(AppColors.primary)
                        .frame(width: 32, height: 32)
                    
                    VStack(alignment: .leading, spacing: AppSpacing.xs) {
                        Text(item)
                            .font(AppTypography.bodyMedium)
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("Description for \(item)")
                            .font(AppTypography.bodySmall)
                            .foregroundColor(AppColors.textSecondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(AppColors.textTertiary)
                }
                .padding(AppSpacing.sm)
            }
            .navigationTitle("List Example")
            .background(AppColors.background)
        }
    }
}
```

---

## 🔧 Customization

### Custom Theme

```swift
// Create custom theme
struct CustomTheme: DesignTheme {
    var colors: ColorPalette {
        CustomColorPalette()
    }
    
    var typography: TypographyScale {
        CustomTypographyScale()
    }
    
    var spacing: SpacingScale {
        CustomSpacingScale()
    }
}

// Custom color palette
struct CustomColorPalette: ColorPalette {
    var primary: Color { Color("CustomPrimary") }
    var secondary: Color { Color("CustomSecondary") }
    var background: Color { Color("CustomBackground") }
    var textPrimary: Color { Color("CustomTextPrimary") }
    var textSecondary: Color { Color("CustomTextSecondary") }
}

// Apply custom theme
DesignTokenManager.shared.setTheme(CustomTheme())
```

### Custom Components

```swift
// Custom button style
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.labelLarge)
            .foregroundColor(AppColors.primary)
            .padding(AppSpacing.md)
            .background(AppColors.surface)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Use custom style
Button("Custom Button") {
    // Action
}
.buttonStyle(CustomButtonStyle())
```

### Custom Animations

```swift
// Custom animation
struct CustomAnimation {
    static let smooth = Animation.easeInOut(duration: 0.3)
    static let bouncy = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let quick = Animation.easeInOut(duration: 0.15)
}

// Use custom animation
withAnimation(CustomAnimation.smooth) {
    // Animated changes
}
```

---

## 🚀 Next Steps

### 1. Explore Components

- [Components API](ComponentsAPI.md) - Complete component library
- [Button API](ButtonAPI.md) - Button implementations
- [Card API](CardAPI.md) - Card implementations
- [Form API](FormAPI.md) - Form components

### 2. Learn Design Tokens

- [Design Tokens Guide](DesignTokensGuide.md) - Design token usage
- [Typography Guide](TypographyGuide.md) - Typography system
- [Color Guide](ColorGuide.md) - Color system

### 3. Master Accessibility

- [Accessibility Guide](AccessibilityGuide.md) - Accessibility features
- [VoiceOver Support](VoiceOverGuide.md) - VoiceOver implementation
- [Dynamic Type](DynamicTypeGuide.md) - Text scaling

### 4. Advanced Features

- [Responsive Design](ResponsiveDesignGuide.md) - Responsive layouts
- [Performance Guide](PerformanceGuide.md) - Performance optimization
- [Customization Guide](CustomizationGuide.md) - Advanced customization

### 5. Examples and Templates

- [Basic Examples](Examples/BasicExamples/) - Simple implementations
- [Advanced Examples](Examples/AdvancedExamples/) - Complex scenarios
- [Layout Examples](Examples/LayoutExamples/) - Layout patterns

---

## 🎯 Best Practices

### 1. Always Use Design Tokens

```swift
// ✅ Good
Text("Hello")
    .font(AppTypography.bodyMedium)
    .foregroundColor(AppColors.textPrimary)

// ❌ Bad
Text("Hello")
    .font(.system(size: 16))
    .foregroundColor(.black)
```

### 2. Maintain Consistency

```swift
// ✅ Good - Consistent spacing
VStack(spacing: AppSpacing.md) {
    // Content
}

// ❌ Bad - Inconsistent spacing
VStack(spacing: 12) {
    // Content
}
```

### 3. Respect Accessibility

```swift
// ✅ Good - Accessibility support
Text("Button")
    .font(AppTypography.labelLarge)
    .accessibilityLabel("Primary action button")

// ❌ Bad - No accessibility
Text("Button")
    .font(.system(size: 14))
```

### 4. Optimize Performance

```swift
// ✅ Good - Efficient rendering
LazyVStack {
    ForEach(items) { item in
        ItemView(item: item)
    }
}

// ❌ Bad - Inefficient rendering
VStack {
    ForEach(items) { item in
        ItemView(item: item)
    }
}
```

---

## 🆘 Troubleshooting

### Common Issues

1. **Import Error**: Make sure you've added the package dependency correctly
2. **Build Error**: Check that you're using iOS 15.0+ and Swift 5.9+
3. **Runtime Error**: Verify that design system is configured in your app's init

### Getting Help

- [GitHub Issues](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/issues)
- [Documentation](Documentation/)
- [Examples](Examples/)
- [Community](https://github.com/muhittincamdali/SwiftUI-Design-System-Pro/discussions)

---

Bu başlangıç rehberi, SwiftUI Design System Pro'yu kullanmaya başlamak için gereken tüm bilgileri içermektedir. Adım adım takip ederek hızlıca geliştirmeye başlayabilirsiniz.

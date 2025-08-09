# 📝 Typography Guide

<!-- TOC START -->
## Table of Contents
- [📝 Typography Guide](#-typography-guide)
- [📋 Table of Contents](#-table-of-contents)
- [🎯 Overview](#-overview)
  - [Key Typography Areas](#key-typography-areas)
- [📝 Typography System](#-typography-system)
  - [1. Typography Scale](#1-typography-scale)
  - [2. Font Families](#2-font-families)
  - [3. Dynamic Type Support](#3-dynamic-type-support)
- [🎨 Typography Components](#-typography-components)
  - [1. Typography Text](#1-typography-text)
  - [2. Responsive Typography](#2-responsive-typography)
  - [3. Typography Stack](#3-typography-stack)
- [⚙️ Configuration](#-configuration)
  - [1. Typography Configuration](#1-typography-configuration)
  - [2. Custom Typography Style](#2-custom-typography-style)
  - [3. Typography Manager](#3-typography-manager)
- [🎯 Usage Examples](#-usage-examples)
  - [1. Typography Hierarchy](#1-typography-hierarchy)
  - [2. Responsive Typography](#2-responsive-typography)
  - [3. Typography in Components](#3-typography-in-components)
  - [4. Custom Typography](#4-custom-typography)
  - [5. Typography Accessibility](#5-typography-accessibility)
<!-- TOC END -->


**SwiftUI Design System Pro** - Complete Typography Guide

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [📝 Typography System](#-typography-system)
- [🎨 Typography Components](#-typography-components)
- [⚙️ Configuration](#️-configuration)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Typography Guide provides comprehensive instructions for using the typography system in SwiftUI Design System Pro. This guide covers all aspects of typography, from basic font usage to advanced responsive typography.

### Key Typography Areas

- **Font System**: Complete typography scale with font families
- **Dynamic Type**: Automatic text scaling with user preferences
- **Responsive Typography**: Typography that adapts to screen size
- **Accessibility**: Typography that maintains accessibility
- **Custom Fonts**: Custom font integration and management

---

## 📝 Typography System

### 1. Typography Scale

The typography system provides a comprehensive scale of font styles.

```swift
// Display styles
AppTypography.displayLarge     // Large display text
AppTypography.displayMedium    // Medium display text
AppTypography.displaySmall     // Small display text

// Headline styles
AppTypography.headlineLarge    // Large headline
AppTypography.headlineMedium   // Medium headline
AppTypography.headlineSmall    // Small headline

// Title styles
AppTypography.titleLarge       // Large title
AppTypography.titleMedium      // Medium title
AppTypography.titleSmall       // Small title

// Body styles
AppTypography.bodyLarge        // Large body text
AppTypography.bodyMedium       // Medium body text
AppTypography.bodySmall        // Small body text

// Label styles
AppTypography.labelLarge       // Large label
AppTypography.labelMedium      // Medium label
AppTypography.labelSmall       // Small label
```

### 2. Font Families

The typography system supports multiple font families.

```swift
// System fonts
AppTypography.systemDisplayLarge
AppTypography.systemHeadlineMedium
AppTypography.systemBodyMedium

// Custom fonts
AppTypography.customDisplayLarge
AppTypography.customHeadlineMedium
AppTypography.customBodyMedium

// Monospace fonts
AppTypography.monoDisplayLarge
AppTypography.monoHeadlineMedium
AppTypography.monoBodyMedium
```

### 3. Dynamic Type Support

All typography automatically scales with user preferences.

```swift
// Automatic dynamic type scaling
Text("Dynamic Type Example")
    .font(AppTypography.bodyMedium)
    .foregroundColor(AppColors.textPrimary)
// Automatically scales with user's text size preference
```

---

## 🎨 Typography Components

### 1. Typography Text

The typography text component provides consistent text styling.

```swift
TypographyText(
    text: String,
    style: TypographyStyle,
    color: Color = AppColors.textPrimary,
    alignment: TextAlignment = .leading
)
```

**TypographyStyle Options:**
- `.displayLarge`
- `.displayMedium`
- `.displaySmall`
- `.headlineLarge`
- `.headlineMedium`
- `.headlineSmall`
- `.titleLarge`
- `.titleMedium`
- `.titleSmall`
- `.bodyLarge`
- `.bodyMedium`
- `.bodySmall`
- `.labelLarge`
- `.labelMedium`
- `.labelSmall`

**Usage:**
```swift
TypographyText(
    text: "Welcome to Design System Pro",
    style: .displayLarge,
    color: AppColors.primary,
    alignment: .center
)
```

### 2. Responsive Typography

The responsive typography component adapts to screen size.

```swift
ResponsiveTypographyText(
    text: String,
    smallStyle: TypographyStyle,
    mediumStyle: TypographyStyle,
    largeStyle: TypographyStyle,
    extraLargeStyle: TypographyStyle,
    color: Color = AppColors.textPrimary
)
```

**Usage:**
```swift
ResponsiveTypographyText(
    text: "Responsive Typography",
    smallStyle: .headlineMedium,
    mediumStyle: .headlineLarge,
    largeStyle: .displaySmall,
    extraLargeStyle: .displayMedium,
    color: AppColors.textPrimary
)
```

### 3. Typography Stack

The typography stack component provides consistent text layouts.

```swift
TypographyStack(
    title: String,
    subtitle: String? = nil,
    body: String? = nil,
    titleStyle: TypographyStyle = .headlineMedium,
    subtitleStyle: TypographyStyle = .bodyMedium,
    bodyStyle: TypographyStyle = .bodySmall,
    spacing: CGFloat = AppSpacing.sm
)
```

**Usage:**
```swift
TypographyStack(
    title: "Typography Example",
    subtitle: "This is a subtitle",
    body: "This is the body text with more details about the typography system.",
    titleStyle: .headlineLarge,
    subtitleStyle: .titleMedium,
    bodyStyle: .bodyMedium,
    spacing: AppSpacing.md
)
```

---

## ⚙️ Configuration

### 1. Typography Configuration

```swift
struct TypographyConfiguration {
    let defaultFontFamily: String
    let displayFontFamily: String?
    let bodyFontFamily: String?
    let monoFontFamily: String?
    let dynamicTypeEnabled: Bool
    let responsiveEnabled: Bool
}

// Default configuration
let defaultTypographyConfig = TypographyConfiguration(
    defaultFontFamily: "SF Pro",
    displayFontFamily: "SF Pro Display",
    bodyFontFamily: "SF Pro Text",
    monoFontFamily: "SF Mono",
    dynamicTypeEnabled: true,
    responsiveEnabled: true
)
```

### 2. Custom Typography Style

```swift
struct CustomTypographyStyle: TypographyStyle {
    let fontFamily: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let lineHeight: CGFloat
    let letterSpacing: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .font(.custom(fontFamily, size: fontSize))
            .fontWeight(fontWeight)
            .lineSpacing(lineHeight - fontSize)
            .tracking(letterSpacing)
    }
}
```

### 3. Typography Manager

```swift
class TypographyManager: ObservableObject {
    @Published var currentFontFamily: String = "SF Pro"
    @Published var dynamicTypeEnabled: Bool = true
    @Published var responsiveEnabled: Bool = true
    
    func setFontFamily(_ family: String) {
        currentFontFamily = family
        // Apply font family to all components
    }
    
    func toggleDynamicType() {
        dynamicTypeEnabled.toggle()
        // Apply dynamic type setting
    }
    
    func toggleResponsive() {
        responsiveEnabled.toggle()
        // Apply responsive setting
    }
}
```

---

## 🎯 Usage Examples

### 1. Typography Hierarchy

```swift
struct TypographyHierarchy: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.lg) {
            // Display styles
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                TypographyText(
                    text: "Display Large",
                    style: .displayLarge,
                    color: AppColors.primary
                )
                
                TypographyText(
                    text: "Display Medium",
                    style: .displayMedium,
                    color: AppColors.textPrimary
                )
                
                TypographyText(
                    text: "Display Small",
                    style: .displaySmall,
                    color: AppColors.textPrimary
                )
            }
            
            // Headline styles
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                TypographyText(
                    text: "Headline Large",
                    style: .headlineLarge,
                    color: AppColors.textPrimary
                )
                
                TypographyText(
                    text: "Headline Medium",
                    style: .headlineMedium,
                    color: AppColors.textPrimary
                )
                
                TypographyText(
                    text: "Headline Small",
                    style: .headlineSmall,
                    color: AppColors.textPrimary
                )
            }
            
            // Title styles
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                TypographyText(
                    text: "Title Large",
                    style: .titleLarge,
                    color: AppColors.textPrimary
                )
                
                TypographyText(
                    text: "Title Medium",
                    style: .titleMedium,
                    color: AppColors.textPrimary
                )
                
                TypographyText(
                    text: "Title Small",
                    style: .titleSmall,
                    color: AppColors.textPrimary
                )
            }
            
            // Body styles
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                TypographyText(
                    text: "Body Large - This is a longer text example to demonstrate body text styling and line wrapping capabilities.",
                    style: .bodyLarge,
                    color: AppColors.textPrimary
                )
                
                TypographyText(
                    text: "Body Medium - This is a longer text example to demonstrate body text styling and line wrapping capabilities.",
                    style: .bodyMedium,
                    color: AppColors.textPrimary
                )
                
                TypographyText(
                    text: "Body Small - This is a longer text example to demonstrate body text styling and line wrapping capabilities.",
                    style: .bodySmall,
                    color: AppColors.textSecondary
                )
            }
            
            // Label styles
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                TypographyText(
                    text: "Label Large",
                    style: .labelLarge,
                    color: AppColors.textSecondary
                )
                
                TypographyText(
                    text: "Label Medium",
                    style: .labelMedium,
                    color: AppColors.textSecondary
                )
                
                TypographyText(
                    text: "Label Small",
                    style: .labelSmall,
                    color: AppColors.textTertiary
                )
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 2. Responsive Typography

```swift
struct ResponsiveTypography: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Responsive heading
            ResponsiveTypographyText(
                text: "Responsive Typography",
                smallStyle: .headlineMedium,
                mediumStyle: .headlineLarge,
                largeStyle: .displaySmall,
                extraLargeStyle: .displayMedium,
                color: AppColors.primary
            )
            
            // Responsive body text
            ResponsiveTypographyText(
                text: "This text automatically adapts to different screen sizes. On small screens, it uses a smaller font size, while on larger screens, it uses a larger font size for better readability.",
                smallStyle: .bodySmall,
                mediumStyle: .bodyMedium,
                largeStyle: .bodyLarge,
                extraLargeStyle: .bodyLarge,
                color: AppColors.textPrimary
            )
            
            // Responsive stack
            TypographyStack(
                title: "Responsive Stack",
                subtitle: "Adaptive typography layout",
                body: "This typography stack automatically adjusts spacing and font sizes based on the screen size and user preferences.",
                titleStyle: .headlineLarge,
                subtitleStyle: .titleMedium,
                bodyStyle: .bodyMedium,
                spacing: ResponsiveSpacing(
                    small: AppSpacing.sm,
                    medium: AppSpacing.md,
                    large: AppSpacing.lg
                )
            )
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 3. Typography in Components

```swift
struct TypographyComponents: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Card with typography
            Card {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    TypographyText(
                        text: "Card Title",
                        style: .headlineMedium,
                        color: AppColors.textPrimary
                    )
                    
                    TypographyText(
                        text: "This is a card component with proper typography hierarchy. The title uses headline styling, while the body text uses body styling for optimal readability.",
                        style: .bodyMedium,
                        color: AppColors.textSecondary
                    )
                    
                    TypographyText(
                        text: "Card Footer",
                        style: .labelMedium,
                        color: AppColors.textTertiary
                    )
                }
            }
            
            // Button with typography
            PrimaryButton(
                title: "Typography Button",
                titleStyle: .labelLarge
            ) {
                print("Button tapped")
            }
            
            // Form with typography
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                TypographyText(
                    text: "Form Label",
                    style: .labelMedium,
                    color: AppColors.textPrimary
                )
                
                DesignSystemTextField(
                    text: .constant(""),
                    placeholder: "Enter text",
                    placeholderStyle: .bodyMedium
                )
                
                TypographyText(
                    text: "Form Helper Text",
                    style: .labelSmall,
                    color: AppColors.textSecondary
                )
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 4. Custom Typography

```swift
struct CustomTypography: View {
    @StateObject private var typographyManager = TypographyManager()
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Custom font family
            TypographyText(
                text: "Custom Font Family",
                style: .custom(
                    CustomTypographyStyle(
                        fontFamily: "Helvetica Neue",
                        fontSize: 24,
                        fontWeight: .bold,
                        lineHeight: 32,
                        letterSpacing: 0.5
                    )
                ),
                color: AppColors.primary
            )
            
            // Dynamic type example
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                TypographyText(
                    text: "Dynamic Type Example",
                    style: .headlineMedium,
                    color: AppColors.textPrimary
                )
                
                TypographyText(
                    text: "This text automatically scales with the user's preferred text size. Try changing the text size in your device settings to see the effect.",
                    style: .bodyMedium,
                    color: AppColors.textSecondary
                )
            }
            
            // Typography controls
            VStack(spacing: AppSpacing.md) {
                HStack {
                    Text("Font Family:")
                        .font(AppTypography.labelMedium)
                    
                    Picker("Font Family", selection: $typographyManager.currentFontFamily) {
                        Text("SF Pro").tag("SF Pro")
                        Text("Helvetica").tag("Helvetica")
                        Text("Arial").tag("Arial")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    Text("Dynamic Type:")
                        .font(AppTypography.labelMedium)
                    
                    Toggle("", isOn: $typographyManager.dynamicTypeEnabled)
                        .labelsHidden()
                }
                
                HStack {
                    Text("Responsive:")
                        .font(AppTypography.labelMedium)
                    
                    Toggle("", isOn: $typographyManager.responsiveEnabled)
                        .labelsHidden()
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 5. Typography Accessibility

```swift
struct TypographyAccessibility: View {
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Accessibility-aware typography
            TypographyText(
                text: "Accessibility Typography",
                style: accessibilityAwareStyle,
                color: AppColors.textPrimary
            )
            
            // High contrast typography
            TypographyText(
                text: "High Contrast Text",
                style: .headlineMedium,
                color: highContrastColor
            )
            
            // Reduce motion typography
            TypographyText(
                text: "Motion-Aware Text",
                style: .bodyLarge,
                color: AppColors.textPrimary
            )
            .scaleEffect(motionAwareScale)
            .animation(motionAwareAnimation, value: motionAwareScale)
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
    
    private var accessibilityAwareStyle: TypographyStyle {
        switch sizeCategory {
        case .accessibilityExtraExtraExtraLarge:
            return .displayLarge
        case .accessibilityExtraExtraLarge:
            return .displayMedium
        case .accessibilityExtraLarge:
            return .displaySmall
        case .accessibilityLarge:
            return .headlineLarge
        case .accessibilityMedium:
            return .headlineMedium
        default:
            return .headlineSmall
        }
    }
    
    private var highContrastColor: Color {
        @Environment(\.legibilityWeight) var legibilityWeight
        return legibilityWeight == .bold ? AppColors.textPrimaryBold : AppColors.textPrimary
    }
    
    private var motionAwareScale: CGFloat {
        @Environment(\.accessibilityReduceMotion) var reduceMotion
        return reduceMotion ? 1.0 : 1.1
    }
    
    private var motionAwareAnimation: Animation {
        @Environment(\.accessibilityReduceMotion) var reduceMotion
        return reduceMotion ? .none : .easeInOut(duration: 0.3)
    }
}
```

---

Bu tipografi rehberi, SwiftUI Design System Pro'nun tipografi sistemini kullanmak için gereken tüm teknikleri kapsamlı bir şekilde açıklamaktadır. Her tipografi özelliğinin nasıl kullanılacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

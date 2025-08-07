# 🎨 Color Guide

**SwiftUI Design System Pro** - Complete Color Guide

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🎨 Color System](#-color-system)
- [🌈 Color Components](#-color-components)
- [⚙️ Configuration](#️-configuration)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Color Guide provides comprehensive instructions for using the color system in SwiftUI Design System Pro. This guide covers all aspects of color usage, from basic color tokens to advanced color management.

### Key Color Areas

- **Color Palette**: Complete color palette with semantic naming
- **Dark Mode**: Automatic dark mode support
- **Accessibility**: Color-blind friendly design
- **Custom Colors**: Custom color integration and management
- **Color Tokens**: Consistent color usage across components

---

## 🎨 Color System

### 1. Primary Colors

The primary color system provides brand colors and their variants.

```swift
// Primary brand colors
AppColors.primary          // Main brand color
AppColors.primaryLight     // Light variant
AppColors.primaryDark      // Dark variant
AppColors.primaryVariant   // Alternative variant

// Secondary colors
AppColors.secondary        // Secondary brand color
AppColors.secondaryLight   // Light variant
AppColors.secondaryDark    // Dark variant
```

### 2. Semantic Colors

Semantic colors provide meaning through color.

```swift
// Success colors
AppColors.success          // Success state
AppColors.successLight     // Light success
AppColors.successDark      // Dark success

// Warning colors
AppColors.warning          // Warning state
AppColors.warningLight     // Light warning
AppColors.warningDark      // Dark warning

// Error colors
AppColors.error            // Error state
AppColors.errorLight       // Light error
AppColors.errorDark        // Dark error

// Info colors
AppColors.info             // Information state
AppColors.infoLight        // Light info
AppColors.infoDark         // Dark info
```

### 3. Text Colors

Text colors provide hierarchy and readability.

```swift
// Text color hierarchy
AppColors.textPrimary      // Primary text color
AppColors.textSecondary    // Secondary text color
AppColors.textTertiary     // Tertiary text color
AppColors.textDisabled     // Disabled text color
AppColors.textInverse      // Inverse text color
```

### 4. Background Colors

Background colors provide structure and depth.

```swift
// Background colors
AppColors.background       // Main background
AppColors.backgroundSecondary // Secondary background
AppColors.backgroundTertiary  // Tertiary background
AppColors.surface         // Surface color
AppColors.surfaceVariant  // Surface variant
```

### 5. Border Colors

Border colors provide definition and separation.

```swift
// Border colors
AppColors.border           // Default border
AppColors.borderLight      // Light border
AppColors.borderDark       // Dark border
AppColors.borderFocus      // Focus border
```

---

## 🌈 Color Components

### 1. Color Token

The color token component provides consistent color usage.

```swift
ColorToken(
    color: Color,
    name: String,
    description: String? = nil
)
```

**Usage:**
```swift
ColorToken(
    color: AppColors.primary,
    name: "Primary",
    description: "Main brand color"
)
```

### 2. Color Palette

The color palette component displays a collection of colors.

```swift
ColorPalette(
    colors: [ColorToken],
    title: String? = nil,
    layout: ColorPaletteLayout = .grid
)
```

**ColorPaletteLayout Options:**
- `.grid`: Grid layout for color swatches
- `.list`: List layout with color names
- `.spectrum`: Spectrum layout for color variations

**Usage:**
```swift
ColorPalette(
    colors: [
        ColorToken(color: AppColors.primary, name: "Primary"),
        ColorToken(color: AppColors.secondary, name: "Secondary"),
        ColorToken(color: AppColors.success, name: "Success")
    ],
    title: "Brand Colors",
    layout: .grid
)
```

### 3. Color Swatch

The color swatch component displays a single color with information.

```swift
ColorSwatch(
    color: Color,
    name: String,
    hexValue: String? = nil,
    description: String? = nil
)
```

**Usage:**
```swift
ColorSwatch(
    color: AppColors.primary,
    name: "Primary Blue",
    hexValue: "#007AFF",
    description: "Main brand color used for primary actions"
)
```

---

## ⚙️ Configuration

### 1. Color Configuration

```swift
struct ColorConfiguration {
    let primaryColor: Color
    let secondaryColor: Color
    let darkModeEnabled: Bool
    let accessibilityEnabled: Bool
    let customColors: [String: Color]
}

// Default configuration
let defaultColorConfig = ColorConfiguration(
    primaryColor: AppColors.primary,
    secondaryColor: AppColors.secondary,
    darkModeEnabled: true,
    accessibilityEnabled: true,
    customColors: [:]
)
```

### 2. Custom Color Style

```swift
struct CustomColorStyle: ColorStyle {
    let baseColor: Color
    let lightVariant: Color
    let darkVariant: Color
    let contrastColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .foregroundColor(baseColor)
            .background(contrastColor)
    }
}
```

### 3. Color Manager

```swift
class ColorManager: ObservableObject {
    @Published var currentTheme: ColorTheme = .light
    @Published var customColors: [String: Color] = [:]
    @Published var accessibilityMode: AccessibilityMode = .standard
    
    enum ColorTheme {
        case light
        case dark
        case custom(ColorPalette)
    }
    
    enum AccessibilityMode {
        case standard
        case highContrast
        case colorBlind
    }
    
    func setTheme(_ theme: ColorTheme) {
        currentTheme = theme
        // Apply theme to all components
    }
    
    func addCustomColor(_ color: Color, name: String) {
        customColors[name] = color
    }
    
    func setAccessibilityMode(_ mode: AccessibilityMode) {
        accessibilityMode = mode
        // Apply accessibility mode
    }
}
```

---

## 🎯 Usage Examples

### 1. Color Hierarchy

```swift
struct ColorHierarchy: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Primary colors
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Primary Colors")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                HStack(spacing: AppSpacing.md) {
                    ColorSwatch(
                        color: AppColors.primary,
                        name: "Primary",
                        hexValue: "#007AFF"
                    )
                    
                    ColorSwatch(
                        color: AppColors.primaryLight,
                        name: "Primary Light",
                        hexValue: "#4DA3FF"
                    )
                    
                    ColorSwatch(
                        color: AppColors.primaryDark,
                        name: "Primary Dark",
                        hexValue: "#0056CC"
                    )
                }
            }
            
            // Semantic colors
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Semantic Colors")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                HStack(spacing: AppSpacing.md) {
                    ColorSwatch(
                        color: AppColors.success,
                        name: "Success",
                        hexValue: "#34C759"
                    )
                    
                    ColorSwatch(
                        color: AppColors.warning,
                        name: "Warning",
                        hexValue: "#FF9500"
                    )
                    
                    ColorSwatch(
                        color: AppColors.error,
                        name: "Error",
                        hexValue: "#FF3B30"
                    )
                    
                    ColorSwatch(
                        color: AppColors.info,
                        name: "Info",
                        hexValue: "#007AFF"
                    )
                }
            }
            
            // Text colors
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Text Colors")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text("Primary Text")
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("Secondary Text")
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text("Tertiary Text")
                        .foregroundColor(AppColors.textTertiary)
                    
                    Text("Disabled Text")
                        .foregroundColor(AppColors.textDisabled)
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 2. Dark Mode Colors

```swift
struct DarkModeColors: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Color scheme indicator
            HStack {
                Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                    .foregroundColor(AppColors.primary)
                
                Text("Current Theme: \(colorScheme == .dark ? "Dark" : "Light")")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
            }
            
            // Background colors
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Background Colors")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(spacing: AppSpacing.sm) {
                    Rectangle()
                        .fill(AppColors.background)
                        .frame(height: 60)
                        .overlay(
                            Text("Main Background")
                                .foregroundColor(AppColors.textPrimary)
                        )
                        .cornerRadius(8)
                    
                    Rectangle()
                        .fill(AppColors.backgroundSecondary)
                        .frame(height: 60)
                        .overlay(
                            Text("Secondary Background")
                                .foregroundColor(AppColors.textPrimary)
                        )
                        .cornerRadius(8)
                    
                    Rectangle()
                        .fill(AppColors.surface)
                        .frame(height: 60)
                        .overlay(
                            Text("Surface")
                                .foregroundColor(AppColors.textPrimary)
                        )
                        .cornerRadius(8)
                }
            }
            
            // Text colors in context
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Text Colors in Context")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text("Primary Text - This is the main text color used for headings and important content.")
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("Secondary Text - This is used for supporting text and descriptions.")
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text("Tertiary Text - This is used for less important information.")
                        .foregroundColor(AppColors.textTertiary)
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 3. Color Palette

```swift
struct ColorPalette: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Brand colors
            ColorPalette(
                colors: [
                    ColorToken(color: AppColors.primary, name: "Primary"),
                    ColorToken(color: AppColors.secondary, name: "Secondary"),
                    ColorToken(color: AppColors.primaryLight, name: "Primary Light"),
                    ColorToken(color: AppColors.primaryDark, name: "Primary Dark")
                ],
                title: "Brand Colors",
                layout: .grid
            )
            
            // Semantic colors
            ColorPalette(
                colors: [
                    ColorToken(color: AppColors.success, name: "Success"),
                    ColorToken(color: AppColors.warning, name: "Warning"),
                    ColorToken(color: AppColors.error, name: "Error"),
                    ColorToken(color: AppColors.info, name: "Info")
                ],
                title: "Semantic Colors",
                layout: .grid
            )
            
            // Text colors
            ColorPalette(
                colors: [
                    ColorToken(color: AppColors.textPrimary, name: "Primary Text"),
                    ColorToken(color: AppColors.textSecondary, name: "Secondary Text"),
                    ColorToken(color: AppColors.textTertiary, name: "Tertiary Text"),
                    ColorToken(color: AppColors.textDisabled, name: "Disabled Text")
                ],
                title: "Text Colors",
                layout: .list
            )
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 4. Custom Colors

```swift
struct CustomColors: View {
    @StateObject private var colorManager = ColorManager()
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Custom color controls
            VStack(spacing: AppSpacing.md) {
                Text("Custom Colors")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                HStack {
                    Button("Add Custom Color") {
                        addCustomColor()
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    
                    Button("Clear All") {
                        colorManager.customColors.removeAll()
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
            }
            
            // Custom color swatches
            if !colorManager.customColors.isEmpty {
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    Text("Custom Color Swatches")
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: AppSpacing.md) {
                        ForEach(Array(colorManager.customColors.keys), id: \.self) { name in
                            if let color = colorManager.customColors[name] {
                                ColorSwatch(
                                    color: color,
                                    name: name,
                                    hexValue: colorToHex(color)
                                )
                            }
                        }
                    }
                }
            }
            
            // Theme controls
            VStack(spacing: AppSpacing.md) {
                Text("Theme Controls")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                HStack {
                    Button("Light Theme") {
                        colorManager.setTheme(.light)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button("Dark Theme") {
                        colorManager.setTheme(.dark)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
                
                HStack {
                    Button("High Contrast") {
                        colorManager.setAccessibilityMode(.highContrast)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button("Color Blind") {
                        colorManager.setAccessibilityMode(.colorBlind)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
    
    private func addCustomColor() {
        let randomColor = Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
        let colorName = "Custom \(colorManager.customColors.count + 1)"
        colorManager.addCustomColor(randomColor, name: colorName)
    }
    
    private func colorToHex(_ color: Color) -> String {
        // Convert Color to hex string (simplified)
        return "#FFFFFF"
    }
}
```

### 5. Color Accessibility

```swift
struct ColorAccessibility: View {
    @Environment(\.legibilityWeight) var legibilityWeight
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // High contrast colors
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("High Contrast Colors")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(highContrastTextColor)
                
                VStack(spacing: AppSpacing.sm) {
                    Text("This text uses high contrast colors when enabled")
                        .foregroundColor(highContrastTextColor)
                        .background(highContrastBackgroundColor)
                        .padding(AppSpacing.md)
                        .cornerRadius(8)
                    
                    Text("Regular text for comparison")
                        .foregroundColor(AppColors.textPrimary)
                        .background(AppColors.background)
                        .padding(AppSpacing.md)
                        .cornerRadius(8)
                }
            }
            
            // Color blind friendly colors
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Color Blind Friendly")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                HStack(spacing: AppSpacing.md) {
                    VStack {
                        Circle()
                            .fill(AppColors.success)
                            .frame(width: 40, height: 40)
                        Text("Success")
                            .font(AppTypography.labelSmall)
                    }
                    
                    VStack {
                        Circle()
                            .fill(AppColors.warning)
                            .frame(width: 40, height: 40)
                        Text("Warning")
                            .font(AppTypography.labelSmall)
                    }
                    
                    VStack {
                        Circle()
                            .fill(AppColors.error)
                            .frame(width: 40, height: 40)
                        Text("Error")
                            .font(AppTypography.labelSmall)
                    }
                }
            }
            
            // Motion-aware colors
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Motion-Aware Colors")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                Circle()
                    .fill(AppColors.primary)
                    .frame(width: 100, height: 100)
                    .scaleEffect(motionAwareScale)
                    .animation(motionAwareAnimation, value: motionAwareScale)
                    .onTapGesture {
                        withAnimation(motionAwareAnimation) {
                            motionAwareScale = motionAwareScale == 1.0 ? 1.5 : 1.0
                        }
                    }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
    
    private var highContrastTextColor: Color {
        legibilityWeight == .bold ? AppColors.textPrimaryBold : AppColors.textPrimary
    }
    
    private var highContrastBackgroundColor: Color {
        legibilityWeight == .bold ? AppColors.backgroundBold : AppColors.background
    }
    
    @State private var motionAwareScale: CGFloat = 1.0
    
    private var motionAwareAnimation: Animation {
        reduceMotion ? .none : .easeInOut(duration: 0.3)
    }
}
```

---

Bu renk rehberi, SwiftUI Design System Pro'nun renk sistemini kullanmak için gereken tüm teknikleri kapsamlı bir şekilde açıklamaktadır. Her renk özelliğinin nasıl kullanılacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

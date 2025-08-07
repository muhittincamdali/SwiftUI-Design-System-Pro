# 🎨 Design Tokens API

**SwiftUI Design System Pro** - Complete Design Tokens API Documentation

## 📋 Table of Contents

- [🎨 Color System](#-color-system)
- [📝 Typography System](#-typography-system)
- [📏 Spacing System](#-spacing-system)
- [🌙 Dark Mode Support](#-dark-mode-support)
- [♿ Accessibility](#-accessibility)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎨 Color System

### Primary Colors

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

### Semantic Colors

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

### Text Colors

```swift
// Text color hierarchy
AppColors.textPrimary      // Primary text color
AppColors.textSecondary    // Secondary text color
AppColors.textTertiary     // Tertiary text color
AppColors.textDisabled     // Disabled text color
AppColors.textInverse      // Inverse text color
```

### Background Colors

```swift
// Background colors
AppColors.background       // Main background
AppColors.backgroundSecondary // Secondary background
AppColors.backgroundTertiary  // Tertiary background
AppColors.surface         // Surface color
AppColors.surfaceVariant  // Surface variant
```

### Border Colors

```swift
// Border colors
AppColors.border           // Default border
AppColors.borderLight      // Light border
AppColors.borderDark       // Dark border
AppColors.borderFocus      // Focus border
```

---

## 📝 Typography System

### Display Typography

```swift
// Display styles
AppTypography.displayLarge     // Large display text
AppTypography.displayMedium    // Medium display text
AppTypography.displaySmall     // Small display text
```

### Headline Typography

```swift
// Headline styles
AppTypography.headlineLarge    // Large headline
AppTypography.headlineMedium   // Medium headline
AppTypography.headlineSmall    // Small headline
```

### Title Typography

```swift
// Title styles
AppTypography.titleLarge       // Large title
AppTypography.titleMedium      // Medium title
AppTypography.titleSmall       // Small title
```

### Body Typography

```swift
// Body text styles
AppTypography.bodyLarge        // Large body text
AppTypography.bodyMedium       // Medium body text
AppTypography.bodySmall        // Small body text
```

### Label Typography

```swift
// Label styles
AppTypography.labelLarge       // Large label
AppTypography.labelMedium      // Medium label
AppTypography.labelSmall       // Small label
```

---

## 📏 Spacing System

### Spacing Scale

```swift
// Spacing tokens
AppSpacing.xs          // Extra small: 4pt
AppSpacing.sm          // Small: 8pt
AppSpacing.md          // Medium: 16pt
AppSpacing.lg          // Large: 24pt
AppSpacing.xl          // Extra large: 32pt
AppSpacing.xxl         // 2x Extra large: 48pt
AppSpacing.xxxl        // 3x Extra large: 64pt
```

### Layout Spacing

```swift
// Layout spacing
AppSpacing.section     // Section spacing: 32pt
AppSpacing.container   // Container spacing: 16pt
AppSpacing.content     // Content spacing: 8pt
AppSpacing.element     // Element spacing: 4pt
```

---

## 🌙 Dark Mode Support

### Automatic Dark Mode

```swift
// Colors automatically adapt to dark mode
Text("Hello World")
    .foregroundColor(AppColors.textPrimary)  // Auto-adapts
    .background(AppColors.background)        // Auto-adapts
```

### Manual Dark Mode Control

```swift
// Manual dark mode control
@Environment(\.colorScheme) var colorScheme

var backgroundColor: Color {
    colorScheme == .dark ? AppColors.backgroundDark : AppColors.background
}
```

---

## ♿ Accessibility

### Dynamic Type Support

```swift
// Automatic dynamic type scaling
Text("Accessible Text")
    .font(AppTypography.bodyMedium)  // Scales automatically
```

### High Contrast Support

```swift
// High contrast mode support
@Environment(\.legibilityWeight) var legibilityWeight

var textColor: Color {
    legibilityWeight == .bold ? AppColors.textPrimaryBold : AppColors.textPrimary
}
```

### Reduce Motion Support

```swift
// Respect user motion preferences
@Environment(\.accessibilityReduceMotion) var reduceMotion

var animation: Animation {
    reduceMotion ? .none : .easeInOut(duration: 0.3)
}
```

---

## 🎯 Usage Examples

### Basic Color Usage

```swift
struct ColorExample: View {
    var body: some View {
        VStack(spacing: AppSpacing.md) {
            Text("Primary Color")
                .foregroundColor(AppColors.primary)
                .font(AppTypography.headlineMedium)
            
            Text("Secondary Text")
                .foregroundColor(AppColors.textSecondary)
                .font(AppTypography.bodyMedium)
            
            Rectangle()
                .fill(AppColors.background)
                .frame(height: 100)
                .overlay(
                    Text("Background")
                        .foregroundColor(AppColors.textPrimary)
                )
        }
        .padding(AppSpacing.lg)
    }
}
```

### Typography Usage

```swift
struct TypographyExample: View {
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            Text("Display Large")
                .font(AppTypography.displayLarge)
                .foregroundColor(AppColors.textPrimary)
            
            Text("Headline Medium")
                .font(AppTypography.headlineMedium)
                .foregroundColor(AppColors.textPrimary)
            
            Text("Body Medium")
                .font(AppTypography.bodyMedium)
                .foregroundColor(AppColors.textSecondary)
            
            Text("Label Small")
                .font(AppTypography.labelSmall)
                .foregroundColor(AppColors.textTertiary)
        }
        .padding(AppSpacing.lg)
    }
}
```

### Spacing Usage

```swift
struct SpacingExample: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            HStack(spacing: AppSpacing.md) {
                Circle()
                    .fill(AppColors.primary)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text("Title")
                        .font(AppTypography.titleMedium)
                    Text("Subtitle")
                        .font(AppTypography.bodySmall)
                        .foregroundColor(AppColors.textSecondary)
                }
                
                Spacer()
            }
            .padding(AppSpacing.md)
            .background(AppColors.surface)
            .cornerRadius(8)
        }
        .padding(AppSpacing.lg)
    }
}
```

### Complete Component Example

```swift
struct DesignTokenComponent: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Header
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                Text("Design Token Component")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Demonstrating design token usage")
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            // Content
            VStack(spacing: AppSpacing.md) {
                ForEach(0..<3) { index in
                    HStack(spacing: AppSpacing.md) {
                        Circle()
                            .fill(AppColors.primary)
                            .frame(width: 32, height: 32)
                        
                        Text("Item \(index + 1)")
                            .font(AppTypography.bodyMedium)
                            .foregroundColor(AppColors.textPrimary)
                        
                        Spacer()
                        
                        Text("Action")
                            .font(AppTypography.labelMedium)
                            .foregroundColor(AppColors.primary)
                    }
                    .padding(AppSpacing.md)
                    .background(AppColors.surface)
                    .cornerRadius(8)
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

---

## 🔧 Advanced Usage

### Custom Color Creation

```swift
extension AppColors {
    static let customColor = Color("CustomColor")
    static let customColorLight = Color("CustomColorLight")
    static let customColorDark = Color("CustomColorDark")
}
```

### Custom Typography Creation

```swift
extension AppTypography {
    static let customFont = Font.custom("CustomFont", size: 18)
    static let customFontBold = Font.custom("CustomFont-Bold", size: 18)
}
```

### Custom Spacing Creation

```swift
extension AppSpacing {
    static let customSpacing: CGFloat = 20
    static let customLargeSpacing: CGFloat = 40
}
```

---

## 📚 Best Practices

### 1. Always Use Design Tokens

```swift
// ✅ Good - Using design tokens
Text("Hello")
    .font(AppTypography.bodyMedium)
    .foregroundColor(AppColors.textPrimary)

// ❌ Bad - Hard-coded values
Text("Hello")
    .font(.system(size: 16))
    .foregroundColor(.black)
```

### 2. Respect Dark Mode

```swift
// ✅ Good - Automatic dark mode support
.background(AppColors.background)

// ❌ Bad - Hard-coded colors
.background(Color.white)
```

### 3. Use Semantic Colors

```swift
// ✅ Good - Semantic meaning
.foregroundColor(AppColors.success)

// ❌ Bad - Generic colors
.foregroundColor(Color.green)
```

### 4. Maintain Consistency

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

---

## 🚀 Performance Tips

### 1. Cache Design Tokens

```swift
// Cache frequently used tokens
private let primaryColor = AppColors.primary
private let bodyFont = AppTypography.bodyMedium
```

### 2. Use Lazy Loading

```swift
// Lazy load complex typography
LazyVStack {
    ForEach(items) { item in
        Text(item.title)
            .font(AppTypography.headlineMedium)
    }
}
```

### 3. Optimize Color Usage

```swift
// Use color assets for better performance
Color("PrimaryColor") // Uses asset catalog
```

---

Bu API dokümantasyonu, SwiftUI Design System Pro'nun tüm design token'larını kapsamlı bir şekilde açıklamaktadır. Her token'ın nasıl kullanılacağı, best practice'ler ve performans ipuçları dahil edilmiştir.

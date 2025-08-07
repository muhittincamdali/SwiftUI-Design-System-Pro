# 🎨 Design Tokens Guide

**SwiftUI Design System Pro** - Complete Design Tokens Guide

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🎨 Design Token System](#-design-token-system)
- [🌈 Token Categories](#-token-categories)
- [⚙️ Configuration](#️-configuration)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Design Tokens Guide provides comprehensive instructions for using the design token system in SwiftUI Design System Pro. This guide covers all aspects of design tokens, from basic usage to advanced customization.

### Key Design Token Areas

- **Color Tokens**: Semantic color system
- **Typography Tokens**: Font and text styling
- **Spacing Tokens**: Layout and spacing system
- **Shadow Tokens**: Elevation and depth
- **Border Tokens**: Border radius and stroke system
- **Animation Tokens**: Timing and easing curves

---

## 🎨 Design Token System

### 1. Token Structure

Design tokens are organized into logical categories for easy management and usage.

```swift
// Token categories
AppColors.primary          // Color tokens
AppTypography.headlineMedium // Typography tokens
AppSpacing.lg              // Spacing tokens
AppShadows.medium          // Shadow tokens
AppBorders.rounded         // Border tokens
AppAnimations.smooth       // Animation tokens
```

### 2. Token Naming Convention

Tokens follow a consistent naming convention for clarity and maintainability.

```swift
// Color tokens: [Category][Variant][State]
AppColors.primary          // Primary brand color
AppColors.primaryLight     // Light variant
AppColors.primaryDark      // Dark variant
AppColors.textPrimary      // Primary text color
AppColors.textSecondary    // Secondary text color

// Typography tokens: [Category][Size]
AppTypography.displayLarge // Large display text
AppTypography.headlineMedium // Medium headline
AppTypography.bodyMedium   // Medium body text
AppTypography.labelSmall   // Small label text

// Spacing tokens: [Size]
AppSpacing.xs              // Extra small spacing
AppSpacing.sm              // Small spacing
AppSpacing.md              // Medium spacing
AppSpacing.lg              // Large spacing
AppSpacing.xl              // Extra large spacing
```

### 3. Token Hierarchy

Tokens are organized in a hierarchical structure for easy navigation and usage.

```swift
// Color hierarchy
AppColors.primary          // Brand colors
AppColors.secondary        // Secondary brand colors
AppColors.success          // Semantic colors
AppColors.warning          // Warning colors
AppColors.error            // Error colors
AppColors.textPrimary      // Text colors
AppColors.textSecondary    // Secondary text colors
AppColors.background       // Background colors
AppColors.surface          // Surface colors
AppColors.border           // Border colors

// Typography hierarchy
AppTypography.displayLarge // Display styles
AppTypography.headlineLarge // Headline styles
AppTypography.titleLarge   // Title styles
AppTypography.bodyLarge    // Body styles
AppTypography.labelLarge   // Label styles
```

---

## 🌈 Token Categories

### 1. Color Tokens

Color tokens provide a semantic color system for consistent theming.

```swift
// Brand colors
AppColors.primary          // Main brand color
AppColors.primaryLight     // Light variant
AppColors.primaryDark      // Dark variant
AppColors.secondary        // Secondary brand color
AppColors.secondaryLight   // Light variant
AppColors.secondaryDark    // Dark variant

// Semantic colors
AppColors.success          // Success state
AppColors.successLight     // Light success
AppColors.successDark      // Dark success
AppColors.warning          // Warning state
AppColors.warningLight     // Light warning
AppColors.warningDark      // Dark warning
AppColors.error            // Error state
AppColors.errorLight       // Light error
AppColors.errorDark        // Dark error
AppColors.info             // Information state
AppColors.infoLight        // Light info
AppColors.infoDark         // Dark info

// Text colors
AppColors.textPrimary      // Primary text color
AppColors.textSecondary    // Secondary text color
AppColors.textTertiary     // Tertiary text color
AppColors.textDisabled     // Disabled text color
AppColors.textInverse      // Inverse text color

// Background colors
AppColors.background       // Main background
AppColors.backgroundSecondary // Secondary background
AppColors.backgroundTertiary  // Tertiary background
AppColors.surface          // Surface color
AppColors.surfaceVariant   // Surface variant

// Border colors
AppColors.border           // Default border
AppColors.borderLight      // Light border
AppColors.borderDark       // Dark border
AppColors.borderFocus      // Focus border
```

### 2. Typography Tokens

Typography tokens provide consistent text styling across the application.

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

### 3. Spacing Tokens

Spacing tokens provide consistent spacing throughout the application.

```swift
// Base spacing
AppSpacing.xs          // Extra small: 4pt
AppSpacing.sm          // Small: 8pt
AppSpacing.md          // Medium: 16pt
AppSpacing.lg          // Large: 24pt
AppSpacing.xl          // Extra large: 32pt
AppSpacing.xxl         // 2x Extra large: 48pt
AppSpacing.xxxl        // 3x Extra large: 64pt

// Layout spacing
AppSpacing.section     // Section spacing: 32pt
AppSpacing.container   // Container spacing: 16pt
AppSpacing.content     // Content spacing: 8pt
AppSpacing.element     // Element spacing: 4pt

// Component spacing
AppSpacing.buttonPadding // Button padding: 12pt
AppSpacing.cardPadding   // Card padding: 16pt
AppSpacing.formSpacing   // Form spacing: 16pt
AppSpacing.listSpacing   // List spacing: 8pt
```

### 4. Shadow Tokens

Shadow tokens provide consistent elevation and depth.

```swift
// Shadow levels
AppShadows.small        // Small shadow
AppShadows.medium       // Medium shadow
AppShadows.large        // Large shadow
AppShadows.extraLarge   // Extra large shadow

// Shadow variants
AppShadows.card         // Card shadow
AppShadows.button       // Button shadow
AppShadows.modal        // Modal shadow
AppShadows.tooltip      // Tooltip shadow
```

### 5. Border Tokens

Border tokens provide consistent border styling.

```swift
// Border radius
AppBorders.small        // Small radius: 4pt
AppBorders.medium       // Medium radius: 8pt
AppBorders.large        // Large radius: 12pt
AppBorders.extraLarge   // Extra large radius: 16pt

// Border width
AppBorders.thin         // Thin border: 1pt
AppBorders.medium       // Medium border: 2pt
AppBorders.thick        // Thick border: 3pt

// Border styles
AppBorders.solid        // Solid border
AppBorders.dashed       // Dashed border
AppBorders.dotted       // Dotted border
```

### 6. Animation Tokens

Animation tokens provide consistent timing and easing.

```swift
// Animation duration
AppAnimations.fast      // Fast: 0.15s
AppAnimations.medium    // Medium: 0.3s
AppAnimations.slow      // Slow: 0.5s

// Animation easing
AppAnimations.easeIn    // Ease in curve
AppAnimations.easeOut   // Ease out curve
AppAnimations.easeInOut // Ease in-out curve
AppAnimations.linear    // Linear curve

// Animation combinations
AppAnimations.smooth    // Smooth animation
AppAnimations.bouncy    // Bouncy animation
AppAnimations.elastic   // Elastic animation
```

---

## ⚙️ Configuration

### 1. Token Configuration

```swift
struct TokenConfiguration {
    let colorSystem: ColorSystem
    let typographySystem: TypographySystem
    let spacingSystem: SpacingSystem
    let shadowSystem: ShadowSystem
    let borderSystem: BorderSystem
    let animationSystem: AnimationSystem
}

// Default configuration
let defaultTokenConfig = TokenConfiguration(
    colorSystem: DefaultColorSystem(),
    typographySystem: DefaultTypographySystem(),
    spacingSystem: DefaultSpacingSystem(),
    shadowSystem: DefaultShadowSystem(),
    borderSystem: DefaultBorderSystem(),
    animationSystem: DefaultAnimationSystem()
)
```

### 2. Custom Token System

```swift
struct CustomColorSystem: ColorSystem {
    var primary: Color { Color("CustomPrimary") }
    var secondary: Color { Color("CustomSecondary") }
    var success: Color { Color("CustomSuccess") }
    var warning: Color { Color("CustomWarning") }
    var error: Color { Color("CustomError") }
    var textPrimary: Color { Color("CustomTextPrimary") }
    var textSecondary: Color { Color("CustomTextSecondary") }
    var background: Color { Color("CustomBackground") }
    var surface: Color { Color("CustomSurface") }
    var border: Color { Color("CustomBorder") }
}

struct CustomTypographySystem: TypographySystem {
    var displayLarge: Font { Font.custom("CustomFont-Bold", size: 57) }
    var headlineLarge: Font { Font.custom("CustomFont-Bold", size: 32) }
    var titleLarge: Font { Font.custom("CustomFont-Medium", size: 22) }
    var bodyLarge: Font { Font.custom("CustomFont-Regular", size: 16) }
    var labelLarge: Font { Font.custom("CustomFont-Medium", size: 14) }
}

struct CustomSpacingSystem: SpacingSystem {
    var xs: CGFloat { 4 }
    var sm: CGFloat { 8 }
    var md: CGFloat { 16 }
    var lg: CGFloat { 24 }
    var xl: CGFloat { 32 }
    var xxl: CGFloat { 48 }
    var xxxl: CGFloat { 64 }
}
```

### 3. Token Manager

```swift
class TokenManager: ObservableObject {
    @Published var currentTheme: TokenTheme = .light
    @Published var customTokens: [String: Any] = [:]
    
    enum TokenTheme {
        case light
        case dark
        case custom(TokenConfiguration)
    }
    
    func setTheme(_ theme: TokenTheme) {
        currentTheme = theme
        // Apply theme to all tokens
    }
    
    func setCustomToken(_ value: Any, for key: String) {
        customTokens[key] = value
    }
    
    func getCustomToken(for key: String) -> Any? {
        return customTokens[key]
    }
}
```

---

## 🎯 Usage Examples

### 1. Token Usage Examples

```swift
struct TokenUsageExamples: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Color tokens
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Color Tokens")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(spacing: AppSpacing.sm) {
                    Text("Primary Color")
                        .foregroundColor(AppColors.primary)
                        .background(AppColors.background)
                        .padding(AppSpacing.md)
                        .cornerRadius(AppBorders.medium)
                    
                    Text("Success Color")
                        .foregroundColor(AppColors.success)
                        .background(AppColors.background)
                        .padding(AppSpacing.md)
                        .cornerRadius(AppBorders.medium)
                    
                    Text("Error Color")
                        .foregroundColor(AppColors.error)
                        .background(AppColors.background)
                        .padding(AppSpacing.md)
                        .cornerRadius(AppBorders.medium)
                }
            }
            
            // Typography tokens
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Typography Tokens")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
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
            }
            
            // Spacing tokens
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Spacing Tokens")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(spacing: AppSpacing.md) {
                    HStack(spacing: AppSpacing.xs) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(AppColors.primary)
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    HStack(spacing: AppSpacing.sm) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(AppColors.secondary)
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    HStack(spacing: AppSpacing.md) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(AppColors.success)
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    HStack(spacing: AppSpacing.lg) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(AppColors.warning)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
            
            // Shadow tokens
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Shadow Tokens")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(spacing: AppSpacing.md) {
                    Rectangle()
                        .fill(AppColors.surface)
                        .frame(height: 60)
                        .shadow(radius: AppShadows.small)
                        .overlay(
                            Text("Small Shadow")
                                .foregroundColor(AppColors.textPrimary)
                        )
                        .cornerRadius(AppBorders.medium)
                    
                    Rectangle()
                        .fill(AppColors.surface)
                        .frame(height: 60)
                        .shadow(radius: AppShadows.medium)
                        .overlay(
                            Text("Medium Shadow")
                                .foregroundColor(AppColors.textPrimary)
                        )
                        .cornerRadius(AppBorders.medium)
                    
                    Rectangle()
                        .fill(AppColors.surface)
                        .frame(height: 60)
                        .shadow(radius: AppShadows.large)
                        .overlay(
                            Text("Large Shadow")
                                .foregroundColor(AppColors.textPrimary)
                        )
                        .cornerRadius(AppBorders.medium)
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 2. Component with Tokens

```swift
struct ComponentWithTokens: View {
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Card component with tokens
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Card Title")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("This card demonstrates the use of design tokens for consistent styling.")
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
                
                HStack(spacing: AppSpacing.md) {
                    SecondaryButton(title: "Cancel") {
                        print("Cancel tapped")
                    }
                    
                    PrimaryButton(title: "Confirm") {
                        print("Confirm tapped")
                    }
                }
            }
            .padding(AppSpacing.lg)
            .background(AppColors.surface)
            .cornerRadius(AppBorders.large)
            .shadow(radius: AppShadows.medium)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(AppAnimations.smooth, value: isPressed)
            .onTapGesture {
                withAnimation(AppAnimations.fast) {
                    isPressed = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(AppAnimations.fast) {
                        isPressed = false
                    }
                }
            }
            
            // Form component with tokens
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text("Form Example")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(spacing: AppSpacing.sm) {
                    Text("Email")
                        .font(AppTypography.labelMedium)
                        .foregroundColor(AppColors.textPrimary)
                    
                    TextField("Enter your email", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(AppSpacing.sm)
                        .background(AppColors.background)
                        .cornerRadius(AppBorders.medium)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppBorders.medium)
                                .stroke(AppColors.border, lineWidth: AppBorders.thin)
                        )
                }
                
                PrimaryButton(title: "Submit") {
                    print("Submit tapped")
                }
            }
            .padding(AppSpacing.lg)
            .background(AppColors.surface)
            .cornerRadius(AppBorders.large)
            .shadow(radius: AppShadows.small)
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

### 3. Responsive Tokens

```swift
struct ResponsiveTokens: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(spacing: responsiveSpacing) {
            // Responsive typography
            Text("Responsive Design")
                .font(responsiveFont)
                .foregroundColor(AppColors.textPrimary)
            
            // Responsive spacing
            VStack(spacing: responsiveSpacing) {
                ForEach(0..<3) { index in
                    Rectangle()
                        .fill(AppColors.primary)
                        .frame(height: responsiveHeight)
                        .cornerRadius(AppBorders.medium)
                        .shadow(radius: AppShadows.medium)
                        .overlay(
                            Text("Item \(index + 1)")
                                .font(AppTypography.bodyMedium)
                                .foregroundColor(AppColors.textInverse)
                        )
                }
            }
        }
        .padding(responsivePadding)
        .background(AppColors.background)
    }
    
    private var responsiveFont: Font {
        switch horizontalSizeClass {
        case .compact:
            return AppTypography.headlineMedium
        case .regular:
            return AppTypography.headlineLarge
        default:
            return AppTypography.displaySmall
        }
    }
    
    private var responsiveSpacing: CGFloat {
        switch horizontalSizeClass {
        case .compact:
            return AppSpacing.sm
        case .regular:
            return AppSpacing.md
        default:
            return AppSpacing.lg
        }
    }
    
    private var responsiveHeight: CGFloat {
        switch horizontalSizeClass {
        case .compact:
            return 60
        case .regular:
            return 80
        default:
            return 100
        }
    }
    
    private var responsivePadding: EdgeInsets {
        switch horizontalSizeClass {
        case .compact:
            return EdgeInsets(all: AppSpacing.md)
        case .regular:
            return EdgeInsets(all: AppSpacing.lg)
        default:
            return EdgeInsets(all: AppSpacing.xl)
        }
    }
}
```

### 4. Custom Token Theme

```swift
struct CustomTokenTheme: View {
    @StateObject private var tokenManager = TokenManager()
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Theme controls
            VStack(spacing: AppSpacing.md) {
                Text("Custom Token Theme")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                HStack(spacing: AppSpacing.md) {
                    Button("Light Theme") {
                        tokenManager.setTheme(.light)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    
                    Button("Dark Theme") {
                        tokenManager.setTheme(.dark)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button("Custom Theme") {
                        let customConfig = TokenConfiguration(
                            colorSystem: CustomColorSystem(),
                            typographySystem: CustomTypographySystem(),
                            spacingSystem: CustomSpacingSystem(),
                            shadowSystem: DefaultShadowSystem(),
                            borderSystem: DefaultBorderSystem(),
                            animationSystem: DefaultAnimationSystem()
                        )
                        tokenManager.setTheme(.custom(customConfig))
                    }
                    .buttonStyle(TertiaryButtonStyle())
                }
            }
            
            // Token preview
            VStack(spacing: AppSpacing.md) {
                Text("Token Preview")
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                VStack(spacing: AppSpacing.sm) {
                    Text("Primary Color Example")
                        .foregroundColor(AppColors.primary)
                        .background(AppColors.background)
                        .padding(AppSpacing.md)
                        .cornerRadius(AppBorders.medium)
                    
                    Text("Typography Example")
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("Spacing Example")
                        .font(AppTypography.bodyMedium)
                        .foregroundColor(AppColors.textSecondary)
                        .padding(AppSpacing.md)
                        .background(AppColors.surface)
                        .cornerRadius(AppBorders.medium)
                        .shadow(radius: AppShadows.small)
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

---

Bu design token rehberi, SwiftUI Design System Pro'nun design token sistemini kullanmak için gereken tüm teknikleri kapsamlı bir şekilde açıklamaktadır. Her token kategorisinin nasıl kullanılacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

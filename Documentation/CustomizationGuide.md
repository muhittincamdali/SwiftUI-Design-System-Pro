# 🎨 Customization Guide

<!-- TOC START -->
## Table of Contents
- [🎨 Customization Guide](#-customization-guide)
- [📋 Table of Contents](#-table-of-contents)
- [🎯 Overview](#-overview)
  - [Key Customization Areas](#key-customization-areas)
- [🎨 Theme Customization](#-theme-customization)
  - [1. Color System Customization](#1-color-system-customization)
  - [2. Typography Customization](#2-typography-customization)
  - [3. Spacing Customization](#3-spacing-customization)
- [🔧 Component Customization](#-component-customization)
  - [1. Button Customization](#1-button-customization)
  - [2. Card Customization](#2-card-customization)
  - [3. Form Customization](#3-form-customization)
- [📱 Layout Customization](#-layout-customization)
  - [1. Grid System Customization](#1-grid-system-customization)
  - [2. Responsive Layout Customization](#2-responsive-layout-customization)
- [⚙️ Advanced Customization](#-advanced-customization)
  - [1. Custom Components](#1-custom-components)
  - [2. Theme System](#2-theme-system)
  - [3. Animation Customization](#3-animation-customization)
- [🎯 Usage Examples](#-usage-examples)
  - [Complete Custom Theme Example](#complete-custom-theme-example)
<!-- TOC END -->


**SwiftUI Design System Pro** - Complete Customization Guide

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🎨 Theme Customization](#-theme-customization)
- [🔧 Component Customization](#-component-customization)
- [📱 Layout Customization](#-layout-customization)
- [⚙️ Advanced Customization](#️-advanced-customization)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Customization Guide provides comprehensive instructions for customizing the SwiftUI Design System Pro to match your brand identity and design requirements. This guide covers everything from basic theme changes to advanced component customization.

### Key Customization Areas

- **Theme Customization**: Colors, typography, spacing, and design tokens
- **Component Customization**: Individual component styling and behavior
- **Layout Customization**: Responsive layouts and grid systems
- **Advanced Customization**: Custom components and extensions

---

## 🎨 Theme Customization

### 1. Color System Customization

**Custom Color Palette**

```swift
// Define custom colors
struct CustomColors {
    // Primary colors
    static let primary = Color("CustomPrimary")
    static let primaryLight = Color("CustomPrimaryLight")
    static let primaryDark = Color("CustomPrimaryDark")
    
    // Secondary colors
    static let secondary = Color("CustomSecondary")
    static let secondaryLight = Color("CustomSecondaryLight")
    static let secondaryDark = Color("CustomSecondaryDark")
    
    // Semantic colors
    static let success = Color("CustomSuccess")
    static let warning = Color("CustomWarning")
    static let error = Color("CustomError")
    static let info = Color("CustomInfo")
    
    // Text colors
    static let textPrimary = Color("CustomTextPrimary")
    static let textSecondary = Color("CustomTextSecondary")
    static let textTertiary = Color("CustomTextTertiary")
    
    // Background colors
    static let background = Color("CustomBackground")
    static let backgroundSecondary = Color("CustomBackgroundSecondary")
    static let surface = Color("CustomSurface")
    static let surfaceVariant = Color("CustomSurfaceVariant")
    
    // Border colors
    static let border = Color("CustomBorder")
    static let borderLight = Color("CustomBorderLight")
    static let borderDark = Color("CustomBorderDark")
}

// Apply custom colors
DesignTokenManager.shared.setColors(CustomColors.self)
```

**Dynamic Color System**

```swift
// Dynamic color system with light/dark mode support
struct DynamicColors {
    static let primary = Color("PrimaryColor") // Defined in asset catalog
    static let secondary = Color("SecondaryColor")
    static let background = Color("BackgroundColor")
    static let surface = Color("SurfaceColor")
    
    // Semantic colors with variants
    static let success = Color("SuccessColor")
    static let successLight = Color("SuccessLightColor")
    static let successDark = Color("SuccessDarkColor")
    
    static let warning = Color("WarningColor")
    static let warningLight = Color("WarningLightColor")
    static let warningDark = Color("WarningDarkColor")
    
    static let error = Color("ErrorColor")
    static let errorLight = Color("ErrorLightColor")
    static let errorDark = Color("ErrorDarkColor")
}
```

### 2. Typography Customization

**Custom Typography Scale**

```swift
// Define custom typography
struct CustomTypography {
    // Display styles
    static let displayLarge = Font.custom("CustomFont-Bold", size: 57)
    static let displayMedium = Font.custom("CustomFont-Bold", size: 45)
    static let displaySmall = Font.custom("CustomFont-Bold", size: 36)
    
    // Headline styles
    static let headlineLarge = Font.custom("CustomFont-Bold", size: 32)
    static let headlineMedium = Font.custom("CustomFont-Bold", size: 28)
    static let headlineSmall = Font.custom("CustomFont-Bold", size: 24)
    
    // Title styles
    static let titleLarge = Font.custom("CustomFont-Medium", size: 22)
    static let titleMedium = Font.custom("CustomFont-Medium", size: 16)
    static let titleSmall = Font.custom("CustomFont-Medium", size: 14)
    
    // Body styles
    static let bodyLarge = Font.custom("CustomFont-Regular", size: 16)
    static let bodyMedium = Font.custom("CustomFont-Regular", size: 14)
    static let bodySmall = Font.custom("CustomFont-Regular", size: 12)
    
    // Label styles
    static let labelLarge = Font.custom("CustomFont-Medium", size: 14)
    static let labelMedium = Font.custom("CustomFont-Medium", size: 12)
    static let labelSmall = Font.custom("CustomFont-Medium", size: 11)
}

// Apply custom typography
DesignTokenManager.shared.setTypography(CustomTypography.self)
```

**Responsive Typography**

```swift
// Responsive typography that scales with screen size
struct ResponsiveTypography {
    static func displayLarge(for breakpoint: ResponsiveBreakpoint) -> Font {
        switch breakpoint {
        case .small:
            return Font.custom("CustomFont-Bold", size: 32)
        case .medium:
            return Font.custom("CustomFont-Bold", size: 45)
        case .large:
            return Font.custom("CustomFont-Bold", size: 57)
        case .extraLarge, .mac:
            return Font.custom("CustomFont-Bold", size: 72)
        }
    }
    
    static func bodyMedium(for breakpoint: ResponsiveBreakpoint) -> Font {
        switch breakpoint {
        case .small:
            return Font.custom("CustomFont-Regular", size: 12)
        case .medium:
            return Font.custom("CustomFont-Regular", size: 14)
        case .large:
            return Font.custom("CustomFont-Regular", size: 16)
        case .extraLarge, .mac:
            return Font.custom("CustomFont-Regular", size: 18)
        }
    }
}
```

### 3. Spacing Customization

**Custom Spacing Scale**

```swift
// Define custom spacing
struct CustomSpacing {
    // Base spacing units
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64
    
    // Layout spacing
    static let section: CGFloat = 32
    static let container: CGFloat = 16
    static let content: CGFloat = 8
    static let element: CGFloat = 4
    
    // Component spacing
    static let buttonPadding: CGFloat = 12
    static let cardPadding: CGFloat = 16
    static let formSpacing: CGFloat = 16
    static let listSpacing: CGFloat = 8
}

// Apply custom spacing
DesignTokenManager.shared.setSpacing(CustomSpacing.self)
```

**Responsive Spacing**

```swift
// Responsive spacing that adapts to screen size
struct ResponsiveSpacing {
    static func section(for breakpoint: ResponsiveBreakpoint) -> CGFloat {
        switch breakpoint {
        case .small:
            return 16
        case .medium:
            return 24
        case .large:
            return 32
        case .extraLarge, .mac:
            return 48
        }
    }
    
    static func container(for breakpoint: ResponsiveBreakpoint) -> CGFloat {
        switch breakpoint {
        case .small:
            return 8
        case .medium:
            return 12
        case .large:
            return 16
        case .extraLarge, .mac:
            return 24
        }
    }
}
```

---

## 🔧 Component Customization

### 1. Button Customization

**Custom Button Styles**

```swift
// Custom button style
struct CustomButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color?
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.labelLarge)
            .foregroundColor(foregroundColor)
            .padding(AppSpacing.buttonPadding)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor ?? Color.clear, lineWidth: 1)
            )
            .cornerRadius(cornerRadius)
            .shadow(
                color: Color.black.opacity(0.1),
                radius: shadowRadius,
                x: 0,
                y: 2
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Custom primary button
struct CustomPrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(CustomButtonStyle(
                backgroundColor: CustomColors.primary,
                foregroundColor: CustomColors.textInverse,
                borderColor: nil,
                cornerRadius: 12,
                shadowRadius: 4
            ))
    }
}
```

**Button Variants**

```swift
// Button variants
enum ButtonVariant {
    case primary
    case secondary
    case tertiary
    case outline
    case ghost
}

struct VariantButton: View {
    let title: String
    let variant: ButtonVariant
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(buttonStyleForVariant(variant))
    }
    
    private func buttonStyleForVariant(_ variant: ButtonVariant) -> CustomButtonStyle {
        switch variant {
        case .primary:
            return CustomButtonStyle(
                backgroundColor: CustomColors.primary,
                foregroundColor: CustomColors.textInverse,
                borderColor: nil,
                cornerRadius: 8,
                shadowRadius: 4
            )
        case .secondary:
            return CustomButtonStyle(
                backgroundColor: CustomColors.surface,
                foregroundColor: CustomColors.primary,
                borderColor: CustomColors.primary,
                cornerRadius: 8,
                shadowRadius: 2
            )
        case .tertiary:
            return CustomButtonStyle(
                backgroundColor: Color.clear,
                foregroundColor: CustomColors.primary,
                borderColor: nil,
                cornerRadius: 8,
                shadowRadius: 0
            )
        case .outline:
            return CustomButtonStyle(
                backgroundColor: Color.clear,
                foregroundColor: CustomColors.textPrimary,
                borderColor: CustomColors.border,
                cornerRadius: 8,
                shadowRadius: 0
            )
        case .ghost:
            return CustomButtonStyle(
                backgroundColor: Color.clear,
                foregroundColor: CustomColors.textSecondary,
                borderColor: nil,
                cornerRadius: 8,
                shadowRadius: 0
            )
        }
    }
}
```

### 2. Card Customization

**Custom Card Styles**

```swift
// Custom card style
struct CustomCardStyle: CardStyle {
    let backgroundColor: Color
    let borderColor: Color?
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let shadowOpacity: Double
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor ?? Color.clear, lineWidth: borderWidth)
            )
            .cornerRadius(cornerRadius)
            .shadow(
                color: Color.black.opacity(shadowOpacity),
                radius: shadowRadius,
                x: 0,
                y: 2
            )
    }
}

// Custom card variants
enum CardVariant {
    case default
    case elevated
    case outlined
    case filled
}

struct CustomCard: View {
    let variant: CardVariant
    let content: AnyView
    
    var body: some View {
        content
            .cardStyle(cardStyleForVariant(variant))
    }
    
    private func cardStyleForVariant(_ variant: CardVariant) -> CustomCardStyle {
        switch variant {
        case .default:
            return CustomCardStyle(
                backgroundColor: CustomColors.surface,
                borderColor: nil,
                borderWidth: 0,
                cornerRadius: 8,
                shadowRadius: 2,
                shadowOpacity: 0.1
            )
        case .elevated:
            return CustomCardStyle(
                backgroundColor: CustomColors.surface,
                borderColor: nil,
                borderWidth: 0,
                cornerRadius: 12,
                shadowRadius: 8,
                shadowOpacity: 0.15
            )
        case .outlined:
            return CustomCardStyle(
                backgroundColor: Color.clear,
                borderColor: CustomColors.border,
                borderWidth: 1,
                cornerRadius: 8,
                shadowRadius: 0,
                shadowOpacity: 0
            )
        case .filled:
            return CustomCardStyle(
                backgroundColor: CustomColors.backgroundSecondary,
                borderColor: nil,
                borderWidth: 0,
                cornerRadius: 8,
                shadowRadius: 0,
                shadowOpacity: 0
            )
        }
    }
}
```

### 3. Form Customization

**Custom Form Styles**

```swift
// Custom text field style
struct CustomTextFieldStyle: TextFieldStyle {
    let borderColor: Color
    let focusColor: Color
    let backgroundColor: Color
    let cornerRadius: CGFloat
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(AppSpacing.md)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
            .cornerRadius(cornerRadius)
            .onTapGesture {
                // Handle focus
            }
    }
}

// Custom form components
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String?
    
    var body: some View {
        HStack(spacing: AppSpacing.sm) {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(CustomColors.textSecondary)
                    .frame(width: 20, height: 20)
            }
            
            TextField(placeholder, text: $text)
                .textFieldStyle(CustomTextFieldStyle(
                    borderColor: CustomColors.border,
                    focusColor: CustomColors.primary,
                    backgroundColor: CustomColors.surface,
                    cornerRadius: 8
                ))
        }
    }
}
```

---

## 📱 Layout Customization

### 1. Grid System Customization

**Custom Grid Configuration**

```swift
// Custom grid configuration
struct CustomGridConfig {
    let columns: Int
    let spacing: CGFloat
    let padding: EdgeInsets
    
    static let small = CustomGridConfig(
        columns: 1,
        spacing: AppSpacing.sm,
        padding: EdgeInsets(all: AppSpacing.md)
    )
    
    static let medium = CustomGridConfig(
        columns: 2,
        spacing: AppSpacing.md,
        padding: EdgeInsets(all: AppSpacing.lg)
    )
    
    static let large = CustomGridConfig(
        columns: 3,
        spacing: AppSpacing.lg,
        padding: EdgeInsets(all: AppSpacing.xl)
    )
    
    static let extraLarge = CustomGridConfig(
        columns: 4,
        spacing: AppSpacing.xl,
        padding: EdgeInsets(all: AppSpacing.xxl)
    )
}

// Custom grid component
struct CustomGrid<Content: View>: View {
    let config: CustomGridConfig
    let content: Content
    
    init(config: CustomGridConfig, @ViewBuilder content: () -> Content) {
        self.config = config
        self.content = content()
    }
    
    var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible()), count: config.columns),
            spacing: config.spacing
        ) {
            content
        }
        .padding(config.padding)
    }
}
```

### 2. Responsive Layout Customization

**Custom Responsive Layout**

```swift
// Custom responsive layout
struct CustomResponsiveLayout: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                // iPhone portrait layout
                CompactLayout()
            } else if verticalSizeClass == .compact {
                // iPhone landscape layout
                LandscapeLayout()
            } else {
                // iPad layout
                TabletLayout()
            }
        }
    }
}

struct CompactLayout: View {
    var body: some View {
        VStack(spacing: AppSpacing.md) {
            // Compact layout content
            Text("Compact Layout")
                .font(CustomTypography.headlineMedium)
        }
        .padding(AppSpacing.lg)
    }
}

struct LandscapeLayout: View {
    var body: some View {
        HStack(spacing: AppSpacing.lg) {
            // Landscape layout content
            Text("Landscape Layout")
                .font(CustomTypography.headlineMedium)
        }
        .padding(AppSpacing.xl)
    }
}

struct TabletLayout: View {
    var body: some View {
        VStack(spacing: AppSpacing.xl) {
            // Tablet layout content
            Text("Tablet Layout")
                .font(CustomTypography.displaySmall)
        }
        .padding(AppSpacing.xxl)
    }
}
```

---

## ⚙️ Advanced Customization

### 1. Custom Components

**Custom Component Library**

```swift
// Custom component library
struct CustomComponentLibrary {
    static func configure() {
        // Register custom components
        ComponentRegistry.shared.register(
            CustomPrimaryButton.self,
            for: "CustomPrimaryButton"
        )
        
        ComponentRegistry.shared.register(
            CustomCard.self,
            for: "CustomCard"
        )
        
        ComponentRegistry.shared.register(
            CustomTextField.self,
            for: "CustomTextField"
        )
    }
}

// Custom component registry
class ComponentRegistry {
    static let shared = ComponentRegistry()
    private var components: [String: Any.Type] = [:]
    
    func register<T>(_ component: T.Type, for name: String) {
        components[name] = component
    }
    
    func getComponent(for name: String) -> Any.Type? {
        return components[name]
    }
}
```

### 2. Theme System

**Custom Theme System**

```swift
// Custom theme protocol
protocol CustomTheme {
    var colors: ColorPalette { get }
    var typography: TypographyScale { get }
    var spacing: SpacingScale { get }
    var shadows: ShadowSystem { get }
    var borders: BorderSystem { get }
}

// Custom theme implementation
struct BrandTheme: CustomTheme {
    var colors: ColorPalette {
        BrandColors()
    }
    
    var typography: TypographyScale {
        BrandTypography()
    }
    
    var spacing: SpacingScale {
        BrandSpacing()
    }
    
    var shadows: ShadowSystem {
        BrandShadows()
    }
    
    var borders: BorderSystem {
        BrandBorders()
    }
}

// Theme manager
class CustomThemeManager: ObservableObject {
    @Published var currentTheme: CustomTheme
    
    init(theme: CustomTheme) {
        self.currentTheme = theme
    }
    
    func applyTheme(_ theme: CustomTheme) {
        currentTheme = theme
        // Apply theme to all components
    }
}
```

### 3. Animation Customization

**Custom Animation System**

```swift
// Custom animation system
struct CustomAnimationSystem {
    static let smooth = Animation.easeInOut(duration: 0.3)
    static let quick = Animation.easeInOut(duration: 0.15)
    static let slow = Animation.easeInOut(duration: 0.5)
    static let bouncy = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let elastic = Animation.spring(response: 0.3, dampingFraction: 0.5)
    
    // Custom animation curves
    static func custom(duration: Double, curve: Animation.TimingCurve) -> Animation {
        return Animation.timingCurve(curve.0, curve.1, curve.2, curve.3, duration: duration)
    }
}

// Custom animated components
struct AnimatedCard: View {
    @State private var isPressed = false
    @State private var isHovered = false
    
    var body: some View {
        CustomCard(variant: .elevated) {
            AnyView(
                Text("Animated Card")
                    .font(CustomTypography.headlineMedium)
            )
        }
        .scaleEffect(isPressed ? 0.95 : isHovered ? 1.02 : 1.0)
        .animation(CustomAnimationSystem.smooth, value: isPressed)
        .animation(CustomAnimationSystem.smooth, value: isHovered)
        .onTapGesture {
            withAnimation(CustomAnimationSystem.quick) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(CustomAnimationSystem.quick) {
                    isPressed = false
                }
            }
        }
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
```

---

## 🎯 Usage Examples

### Complete Custom Theme Example

```swift
struct CompleteCustomTheme: View {
    @StateObject private var themeManager = CustomThemeManager(theme: BrandTheme())
    
    var body: some View {
        NavigationView {
            VStack(spacing: CustomSpacing.lg) {
                // Header
                VStack(spacing: CustomSpacing.md) {
                    Text("Custom Theme Example")
                        .font(CustomTypography.displayMedium)
                        .foregroundColor(themeManager.currentTheme.colors.textPrimary)
                    
                    Text("Demonstrating custom theme implementation")
                        .font(CustomTypography.bodyLarge)
                        .foregroundColor(themeManager.currentTheme.colors.textSecondary)
                }
                
                // Custom components
                VStack(spacing: CustomSpacing.lg) {
                    // Custom buttons
                    HStack(spacing: CustomSpacing.md) {
                        CustomPrimaryButton(title: "Primary") {
                            print("Primary button tapped")
                        }
                        
                        VariantButton(
                            title: "Secondary",
                            variant: .secondary
                        ) {
                            print("Secondary button tapped")
                        }
                    }
                    
                    // Custom cards
                    CustomGrid(config: .medium) {
                        CustomCard(variant: .elevated) {
                            AnyView(
                                VStack(alignment: .leading, spacing: CustomSpacing.md) {
                                    Text("Elevated Card")
                                        .font(CustomTypography.headlineMedium)
                                    
                                    Text("This is an elevated card with custom styling.")
                                        .font(CustomTypography.bodyMedium)
                                        .foregroundColor(themeManager.currentTheme.colors.textSecondary)
                                }
                            )
                        }
                        
                        CustomCard(variant: .outlined) {
                            AnyView(
                                VStack(alignment: .leading, spacing: CustomSpacing.md) {
                                    Text("Outlined Card")
                                        .font(CustomTypography.headlineMedium)
                                    
                                    Text("This is an outlined card with custom styling.")
                                        .font(CustomTypography.bodyMedium)
                                        .foregroundColor(themeManager.currentTheme.colors.textSecondary)
                                }
                            )
                        }
                    }
                    
                    // Custom form
                    VStack(spacing: CustomSpacing.md) {
                        CustomTextField(
                            text: .constant(""),
                            placeholder: "Enter your name",
                            icon: "person"
                        )
                        
                        CustomTextField(
                            text: .constant(""),
                            placeholder: "Enter your email",
                            icon: "envelope"
                        )
                    }
                }
                
                // Theme switcher
                HStack(spacing: CustomSpacing.md) {
                    Button("Light Theme") {
                        themeManager.applyTheme(LightTheme())
                    }
                    .buttonStyle(CustomButtonStyle(
                        backgroundColor: themeManager.currentTheme.colors.surface,
                        foregroundColor: themeManager.currentTheme.colors.textPrimary,
                        borderColor: themeManager.currentTheme.colors.border,
                        cornerRadius: 8,
                        shadowRadius: 2
                    ))
                    
                    Button("Dark Theme") {
                        themeManager.applyTheme(DarkTheme())
                    }
                    .buttonStyle(CustomButtonStyle(
                        backgroundColor: themeManager.currentTheme.colors.surface,
                        foregroundColor: themeManager.currentTheme.colors.textPrimary,
                        borderColor: themeManager.currentTheme.colors.border,
                        cornerRadius: 8,
                        shadowRadius: 2
                    ))
                }
            }
            .padding(CustomSpacing.xl)
            .background(themeManager.currentTheme.colors.background)
        }
    }
}

// Light theme
struct LightTheme: CustomTheme {
    var colors: ColorPalette {
        LightColorPalette()
    }
    
    var typography: TypographyScale {
        LightTypography()
    }
    
    var spacing: SpacingScale {
        LightSpacing()
    }
    
    var shadows: ShadowSystem {
        LightShadows()
    }
    
    var borders: BorderSystem {
        LightBorders()
    }
}

// Dark theme
struct DarkTheme: CustomTheme {
    var colors: ColorPalette {
        DarkColorPalette()
    }
    
    var typography: TypographyScale {
        DarkTypography()
    }
    
    var spacing: SpacingScale {
        DarkSpacing()
    }
    
    var shadows: ShadowSystem {
        DarkShadows()
    }
    
    var borders: BorderSystem {
        DarkBorders()
    }
}
```

---

Bu özelleştirme rehberi, SwiftUI Design System Pro'yu markanıza ve tasarım gereksinimlerinize uygun şekilde özelleştirmek için gereken tüm teknikleri kapsamlı bir şekilde açıklamaktadır. Her özelleştirme alanının nasıl uygulanacağı, tema sistemleri ve pratik örnekler dahil edilmiştir.

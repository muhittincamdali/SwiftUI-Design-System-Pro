# 🌙 Theme System

<!-- TOC START -->
## Table of Contents
- [🌙 Theme System](#-theme-system)
- [🎨 Color System](#-color-system)
  - [Primary Colors](#primary-colors)
  - [Semantic Colors](#semantic-colors)
- [🌙 Dark/Light Mode](#-darklight-mode)
  - [Theme Manager](#theme-manager)
  - [Theme Colors](#theme-colors)
- [🎨 Custom Themes](#-custom-themes)
  - [Creating Custom Themes](#creating-custom-themes)
  - [Brand Themes](#brand-themes)
- [🎭 Animation System](#-animation-system)
  - [Animation Presets](#animation-presets)
  - [Custom Animations](#custom-animations)
- [📏 Spacing System](#-spacing-system)
  - [Spacing Tokens](#spacing-tokens)
  - [Usage](#usage)
- [🎨 Typography System](#-typography-system)
  - [Font Sizes](#font-sizes)
  - [Font Weights](#font-weights)
- [🎯 Component Theming](#-component-theming)
  - [Button Themes](#button-themes)
  - [Card Themes](#card-themes)
- [🌙 Dark Mode Support](#-dark-mode-support)
  - [Automatic Switching](#automatic-switching)
  - [Manual Control](#manual-control)
- [🎨 Brand Integration](#-brand-integration)
  - [Brand Colors](#brand-colors)
  - [Brand Theme](#brand-theme)
- [🎭 Animation Themes](#-animation-themes)
  - [Micro-interactions](#micro-interactions)
  - [Page Transitions](#page-transitions)
- [📱 Responsive Theming](#-responsive-theming)
  - [Device-Specific Themes](#device-specific-themes)
- [🎨 Theme Customization](#-theme-customization)
  - [Environment Values](#environment-values)
  - [Theme Modifiers](#theme-modifiers)
- [🧪 Theme Testing](#-theme-testing)
  - [Unit Tests](#unit-tests)
  - [UI Tests](#ui-tests)
- [📚 Next Steps](#-next-steps)
<!-- TOC END -->


The SwiftUI Design System Pro includes a comprehensive theme system that supports dark/light modes, custom themes, and brand integration.

## 🎨 Color System

### Primary Colors
```swift
extension Color {
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let accent = Color("Accent")
    static let success = Color("Success")
    static let warning = Color("Warning")
    static let error = Color("Error")
}
```

### Semantic Colors
```swift
extension Color {
    static let background = Color("Background")
    static let surface = Color("Surface")
    static let text = Color("Text")
    static let textSecondary = Color("TextSecondary")
}
```

## 🌙 Dark/Light Mode

### Theme Manager
```swift
class DSThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false
    
    var currentTheme: DSTheme {
        isDarkMode ? .dark : .light
    }
}
```

### Theme Colors
```swift
struct DSTheme {
    let background: Color
    let surface: Color
    let text: Color
    let textSecondary: Color
    
    static let light = DSTheme(
        background: .white,
        surface: Color(.systemGray6),
        text: .black,
        textSecondary: .gray
    )
    
    static let dark = DSTheme(
        background: .black,
        surface: Color(.systemGray5),
        text: .white,
        textSecondary: .gray
    )
}
```

## 🎨 Custom Themes

### Creating Custom Themes
```swift
struct CustomTheme: DSTheme {
    let primary: Color = .purple
    let secondary: Color = .orange
    let background: Color = .white
    let surface: Color = Color(.systemGray6)
    let text: Color = .black
    let textSecondary: Color = .gray
}
```

### Brand Themes
```swift
struct BrandTheme: DSTheme {
    let primary: Color = .blue
    let secondary: Color = .green
    let accent: Color = .yellow
    let background: Color = .white
    let surface: Color = Color(.systemGray6)
    let text: Color = .black
    let textSecondary: Color = .gray
}
```

## 🎭 Animation System

### Animation Presets
```swift
struct DSAnimation {
    static let spring = Animation.spring(response: 0.6, dampingFraction: 0.8)
    static let easeInOut = Animation.easeInOut(duration: 0.3)
    static let bounce = Animation.interpolatingSpring(stiffness: 100, damping: 10)
    static let slide = Animation.easeInOut(duration: 0.4)
}
```

### Custom Animations
```swift
struct CustomAnimation {
    static let brandSpring = Animation.spring(
        response: 0.8,
        dampingFraction: 0.6,
        blendDuration: 0.5
    )
    
    static let microInteraction = Animation.easeInOut(duration: 0.15)
}
```

## 📏 Spacing System

### Spacing Tokens
```swift
struct DSSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}
```

### Usage
```swift
VStack(spacing: DSSpacing.md) {
    Text("Content")
        .padding(.horizontal, DSSpacing.lg)
        .padding(.vertical, DSSpacing.md)
}
```

## 🎨 Typography System

### Font Sizes
```swift
struct DSTypography {
    static let caption = Font.caption
    static let body = Font.body
    static let title3 = Font.title3
    static let title2 = Font.title2
    static let title1 = Font.title1
    static let largeTitle = Font.largeTitle
}
```

### Font Weights
```swift
struct DSFontWeight {
    static let light = Font.Weight.light
    static let regular = Font.Weight.regular
    static let medium = Font.Weight.medium
    static let semibold = Font.Weight.semibold
    static let bold = Font.Weight.bold
}
```

## 🎯 Component Theming

### Button Themes
```swift
struct CustomButtonTheme: DSButtonStyle {
    func backgroundColor(for colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? .purple : .blue
    }
    
    func textColor(for colorScheme: ColorScheme) -> Color {
        return .white
    }
    
    func borderColor(for colorScheme: ColorScheme) -> Color {
        return .clear
    }
    
    var borderWidth: CGFloat { 0 }
}
```

### Card Themes
```swift
struct CustomCardTheme: DSCardStyle {
    func backgroundColor(for colorScheme: ColorScheme) -> Color {
        return colorScheme == .dark ? Color(.systemGray6) : .white
    }
    
    func cornerRadius() -> CGFloat {
        return 16
    }
    
    func shadow() -> Shadow {
        return Shadow(
            color: .black.opacity(0.1),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}
```

## 🌙 Dark Mode Support

### Automatic Switching
```swift
@Environment(\.colorScheme) var colorScheme

DSButton(
    title: "Theme Aware",
    style: .primary
)
.background(colorScheme == .dark ? Color.darkBackground : Color.lightBackground)
```

### Manual Control
```swift
@StateObject private var themeManager = DSThemeManager()

DSButton(
    title: "Manual Theme",
    style: .primary
)
.background(themeManager.currentTheme.background)
```

## 🎨 Brand Integration

### Brand Colors
```swift
struct BrandColors {
    static let primary = Color("BrandPrimary")
    static let secondary = Color("BrandSecondary")
    static let accent = Color("BrandAccent")
    static let neutral = Color("BrandNeutral")
}
```

### Brand Theme
```swift
struct BrandTheme: DSTheme {
    let primary: Color = BrandColors.primary
    let secondary: Color = BrandColors.secondary
    let accent: Color = BrandColors.accent
    let background: Color = .white
    let surface: Color = Color(.systemGray6)
    let text: Color = .black
    let textSecondary: Color = .gray
}
```

## 🎭 Animation Themes

### Micro-interactions
```swift
struct MicroInteractionTheme {
    static let buttonPress = Animation.easeInOut(duration: 0.1)
    static let cardHover = Animation.easeInOut(duration: 0.2)
    static let modalTransition = Animation.spring(response: 0.6, dampingFraction: 0.8)
}
```

### Page Transitions
```swift
struct PageTransitionTheme {
    static let slide = Animation.easeInOut(duration: 0.3)
    static let fade = Animation.easeInOut(duration: 0.25)
    static let scale = Animation.spring(response: 0.5, dampingFraction: 0.7)
}
```

## 📱 Responsive Theming

### Device-Specific Themes
```swift
struct ResponsiveTheme {
    static func spacing(for device: Device) -> CGFloat {
        switch device {
        case .iPhone: return 16
        case .iPad: return 24
        case .mac: return 32
        }
    }
    
    static func fontSize(for device: Device) -> Font {
        switch device {
        case .iPhone: return .body
        case .iPad: return .title3
        case .mac: return .title2
        }
    }
}
```

## 🎨 Theme Customization

### Environment Values
```swift
struct CustomThemeKey: EnvironmentKey {
    static let defaultValue: DSTheme = DSTheme.light
}

extension EnvironmentValues {
    var customTheme: DSTheme {
        get { self[CustomThemeKey.self] }
        set { self[CustomThemeKey.self] = newValue }
    }
}
```

### Theme Modifiers
```swift
struct ThemeModifier: ViewModifier {
    let theme: DSTheme
    
    func body(content: Content) -> some View {
        content
            .environment(\.customTheme, theme)
            .background(theme.background)
            .foregroundColor(theme.text)
    }
}

extension View {
    func theme(_ theme: DSTheme) -> some View {
        modifier(ThemeModifier(theme: theme))
    }
}
```

## 🧪 Theme Testing

### Unit Tests
```swift
class ThemeTests: XCTestCase {
    func testLightTheme() {
        let theme = DSTheme.light
        XCTAssertEqual(theme.background, .white)
        XCTAssertEqual(theme.text, .black)
    }
    
    func testDarkTheme() {
        let theme = DSTheme.dark
        XCTAssertEqual(theme.background, .black)
        XCTAssertEqual(theme.text, .white)
    }
}
```

### UI Tests
```swift
class ThemeUITests: XCTestCase {
    func testThemeSwitching() {
        let app = XCUIApplication()
        app.launch()
        
        // Test light mode
        XCTAssertTrue(app.otherElements["LightTheme"].exists)
        
        // Switch to dark mode
        app.buttons["DarkModeToggle"].tap()
        XCTAssertTrue(app.otherElements["DarkTheme"].exists)
    }
}
```

## 📚 Next Steps

1. **Component Theming**: Learn how to theme individual components
2. **Brand Integration**: Integrate your brand colors and styles
3. **Animation System**: Create custom animations and transitions
4. **Responsive Design**: Adapt themes for different devices

---

**🎨 Create beautiful, consistent themes with SwiftUI Design System Pro!** 
# ♿ Accessibility Guide

<!-- TOC START -->
## Table of Contents
- [♿ Accessibility Guide](#-accessibility-guide)
- [🎯 VoiceOver Support](#-voiceover-support)
  - [Basic VoiceOver](#basic-voiceover)
  - [Advanced VoiceOver](#advanced-voiceover)
- [📱 Dynamic Type](#-dynamic-type)
  - [Font Scaling](#font-scaling)
  - [Component Scaling](#component-scaling)
- [🎨 High Contrast](#-high-contrast)
  - [High Contrast Support](#high-contrast-support)
  - [Color Contrast](#color-contrast)
- [🎭 Reduced Motion](#-reduced-motion)
  - [Animation Control](#animation-control)
  - [Motion Sensitivity](#motion-sensitivity)
- [🎯 Focus Management](#-focus-management)
  - [Focus Navigation](#focus-navigation)
  - [Focus Order](#focus-order)
- [📊 Screen Reader Support](#-screen-reader-support)
  - [Descriptive Labels](#descriptive-labels)
  - [Status Updates](#status-updates)
- [🎨 Color Blindness Support](#-color-blindness-support)
  - [Color-Independent Design](#color-independent-design)
  - [Semantic Colors](#semantic-colors)
- [📱 Touch Targets](#-touch-targets)
  - [Minimum Touch Area](#minimum-touch-area)
  - [Touch Feedback](#touch-feedback)
- [🎯 Semantic Structure](#-semantic-structure)
  - [Headings](#headings)
  - [Lists](#lists)
  - [Groups](#groups)
- [🎭 Custom Actions](#-custom-actions)
  - [Custom Accessibility Actions](#custom-accessibility-actions)
  - [Gesture Recognition](#gesture-recognition)
- [📊 Testing Accessibility](#-testing-accessibility)
  - [Unit Tests](#unit-tests)
  - [UI Tests](#ui-tests)
  - [Accessibility Inspector](#accessibility-inspector)
- [🎨 Best Practices](#-best-practices)
  - [Descriptive Labels](#descriptive-labels)
  - [Context Awareness](#context-awareness)
  - [Error Handling](#error-handling)
- [📱 Platform-Specific](#-platform-specific)
  - [iOS Accessibility](#ios-accessibility)
  - [macOS Accessibility](#macos-accessibility)
  - [watchOS Accessibility](#watchos-accessibility)
- [🎯 Compliance](#-compliance)
  - [WCAG 2.1 Compliance](#wcag-21-compliance)
  - [Section 508 Compliance](#section-508-compliance)
- [📚 Next Steps](#-next-steps)
<!-- TOC END -->


Comprehensive accessibility guide for SwiftUI Design System Pro, ensuring all components are accessible to users with disabilities.

## 🎯 VoiceOver Support

### Basic VoiceOver
```swift
DSButton(
    title: "Submit Form",
    action: { /* Action */ }
)
.accessibilityLabel("Submit form button")
.accessibilityHint("Double tap to submit the form")
```

### Advanced VoiceOver
```swift
DSButton(title: "Delete") { }
    .accessibilityLabel("Delete item button")
    .accessibilityHint("Double tap to delete this item")
    .accessibilityValue("Item will be permanently deleted")
    .accessibilityTraits(.button)
```

## 📱 Dynamic Type

### Font Scaling
```swift
Text("Dynamic Text")
    .font(.system(size: 16, weight: .medium, design: .default))
    .dynamicTypeSize(.large...(.accessibility3))
```

### Component Scaling
```swift
DSButton(title: "Scalable Button") { }
    .font(.system(size: 16, weight: .semibold))
    .dynamicTypeSize(.large...(.accessibility3))
```

## 🎨 High Contrast

### High Contrast Support
```swift
DSButton(title: "High Contrast Button") { }
    .contrast(1.2)
    .accessibilityIgnoresInvertColors(false)
```

### Color Contrast
```swift
Text("High Contrast Text")
    .foregroundColor(.primary)
    .background(Color.background)
    .contrast(1.5)
```

## 🎭 Reduced Motion

### Animation Control
```swift
withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
    // Animation content
}
.accessibilityReduceMotion(true)
```

### Motion Sensitivity
```swift
DSButton(title: "Motion Sensitive") { }
    .accessibilityReduceMotion(true)
    .animation(.none, value: isPressed)
```

## 🎯 Focus Management

### Focus Navigation
```swift
DSButton(title: "Focusable Button") { }
    .accessibilityFocused($isFocused)
    .onTapGesture {
        // Handle focus
    }
```

### Focus Order
```swift
VStack {
    DSButton(title: "First") { }
        .accessibilitySortPriority(1)
    
    DSButton(title: "Second") { }
        .accessibilitySortPriority(2)
}
```

## 📊 Screen Reader Support

### Descriptive Labels
```swift
DSCard(
    title: "Product Card",
    subtitle: "iPhone 15 Pro - $999"
)
.accessibilityLabel("Product: iPhone 15 Pro, Price: $999")
.accessibilityHint("Double tap to view product details")
```

### Status Updates
```swift
@State private var isLoading = false

DSButton(title: "Load Data") { }
    .accessibilityLabel("Load data button")
    .accessibilityValue(isLoading ? "Loading..." : "Ready")
```

## 🎨 Color Blindness Support

### Color-Independent Design
```swift
DSButton(title: "Success") { }
    .background(.green)
    .overlay(
        Image(systemName: "checkmark")
            .foregroundColor(.white)
    )
```

### Semantic Colors
```swift
Text("Error Message")
    .foregroundColor(.red)
    .background(
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.red.opacity(0.1))
    )
```

## 📱 Touch Targets

### Minimum Touch Area
```swift
DSButton(title: "Large Touch Target") { }
    .frame(minWidth: 44, minHeight: 44)
    .contentShape(Rectangle())
```

### Touch Feedback
```swift
DSButton(title: "Haptic Feedback") { }
    .onTapGesture {
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
```

## 🎯 Semantic Structure

### Headings
```swift
Text("Main Heading")
    .font(.largeTitle)
    .accessibilityAddTraits(.isHeader)
```

### Lists
```swift
LazyVStack {
    ForEach(items, id: \.id) { item in
        DSCard(item: item)
    }
}
.accessibilityElement(children: .contain)
.accessibilityLabel("Product list")
```

### Groups
```swift
VStack {
    Text("Form Section")
        .font(.headline)
        .accessibilityAddTraits(.isHeader)
    
    DSTextField(placeholder: "Name", text: $name)
    DSTextField(placeholder: "Email", text: $email)
}
.accessibilityElement(children: .contain)
.accessibilityLabel("Contact form")
```

## 🎭 Custom Actions

### Custom Accessibility Actions
```swift
DSButton(title: "Custom Actions") { }
    .accessibilityAction(named: "Delete") {
        // Handle delete action
    }
    .accessibilityAction(named: "Edit") {
        // Handle edit action
    }
```

### Gesture Recognition
```swift
DSButton(title: "Multi-Gesture") { }
    .accessibilityAction(named: "Swipe Left") {
        // Handle swipe left
    }
    .accessibilityAction(named: "Swipe Right") {
        // Handle swipe right
    }
```

## 📊 Testing Accessibility

### Unit Tests
```swift
class AccessibilityTests: XCTestCase {
    func testButtonAccessibility() {
        let button = DSButton(title: "Test") { }
        
        XCTAssertEqual(button.accessibilityLabel, "Test")
        XCTAssertEqual(button.accessibilityHint, "Double tap to activate")
    }
}
```

### UI Tests
```swift
class AccessibilityUITests: XCTestCase {
    func testVoiceOverNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        // Test VoiceOver navigation
        let button = app.buttons["Accessible Button"]
        XCTAssertTrue(button.exists)
        
        // Test focus navigation
        button.tap()
        XCTAssertTrue(app.otherElements["Focused Element"].exists)
    }
}
```

### Accessibility Inspector
```swift
// Enable accessibility inspector in debug builds
#if DEBUG
extension View {
    func accessibilityDebug() -> some View {
        self.accessibilityLabel("Debug: \(String(describing: self))")
    }
}
#endif
```

## 🎨 Best Practices

### Descriptive Labels
```swift
// Good
DSButton(title: "Save Changes") { }
    .accessibilityLabel("Save changes button")

// Better
DSButton(title: "Save") { }
    .accessibilityLabel("Save changes to profile")
    .accessibilityHint("Double tap to save your changes")
```

### Context Awareness
```swift
DSCard(
    title: "User Profile",
    subtitle: "John Doe - iOS Developer"
)
.accessibilityLabel("User profile for John Doe, iOS Developer")
.accessibilityHint("Double tap to view full profile")
```

### Error Handling
```swift
@State private var hasError = false

DSTextField(placeholder: "Email", text: $email)
    .accessibilityLabel("Email input field")
    .accessibilityValue(hasError ? "Invalid email format" : email)
    .accessibilityHint(hasError ? "Please enter a valid email address" : "Enter your email address")
```

## 📱 Platform-Specific

### iOS Accessibility
```swift
DSButton(title: "iOS Specific") { }
    .accessibilityTraits(.button)
    .accessibilityRespondsToUserInteraction(true)
```

### macOS Accessibility
```swift
DSButton(title: "macOS Specific") { }
    .accessibilityRole(.button)
    .accessibilityHelp("Click to perform action")
```

### watchOS Accessibility
```swift
DSButton(title: "watchOS Specific") { }
    .accessibilityTraits(.button)
    .accessibilityHint("Crown to navigate, tap to activate")
```

## 🎯 Compliance

### WCAG 2.1 Compliance
- **Level AA**: All components meet WCAG 2.1 AA standards
- **Color Contrast**: Minimum 4.5:1 ratio for normal text
- **Touch Targets**: Minimum 44x44 points for interactive elements
- **Keyboard Navigation**: Full keyboard support for all components

### Section 508 Compliance
- **Electronic and Information Technology Accessibility Standards**
- **Federal government compliance**
- **Screen reader compatibility**
- **Keyboard navigation support**

## 📚 Next Steps

1. **Testing**: Run accessibility tests on your components
2. **Auditing**: Use Xcode's Accessibility Inspector
3. **User Testing**: Test with users who have disabilities
4. **Continuous Improvement**: Regularly update accessibility features

---

**♿ Make your apps accessible to everyone with SwiftUI Design System Pro!** 
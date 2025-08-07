# 🔘 Button API

**SwiftUI Design System Pro** - Complete Button API Documentation

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🔘 Button Types](#-button-types)
- [🎨 Button Styles](#-button-styles)
- [⚙️ Configuration](#️-configuration)
- [♿ Accessibility](#-accessibility)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Button API provides a comprehensive collection of button components designed for modern iOS applications. All buttons are built with accessibility in mind and follow the design system's token-based approach.

### Key Features

- **Multiple Button Types**: Primary, secondary, tertiary, and icon buttons
- **Loading States**: Built-in loading indicators
- **Icon Support**: Easy icon integration
- **Accessibility**: Full VoiceOver and accessibility support
- **Customization**: Extensive customization options
- **Animation**: Smooth animations and transitions

---

## 🔘 Button Types

### Primary Button

The primary button is used for the main action in a view or form.

```swift
PrimaryButton(
    title: String,
    icon: String? = nil,
    isLoading: Bool = false,
    isEnabled: Bool = true,
    size: ButtonSize = .medium,
    action: @escaping () -> Void
)
```

**Parameters:**
- `title`: The button's text label
- `icon`: Optional SF Symbol icon name
- `isLoading`: Shows loading spinner when true
- `isEnabled`: Enables/disables the button
- `size`: Button size (small, medium, large)
- `action`: Closure executed when button is tapped

**Usage:**
```swift
PrimaryButton(title: "Get Started") {
    print("Primary button tapped")
}

PrimaryButton(
    title: "Save Changes",
    icon: "checkmark",
    isLoading: false
) {
    saveChanges()
}
```

### Secondary Button

The secondary button is used for alternative actions or less prominent actions.

```swift
SecondaryButton(
    title: String,
    icon: String? = nil,
    isLoading: Bool = false,
    isEnabled: Bool = true,
    size: ButtonSize = .medium,
    action: @escaping () -> Void
)
```

**Usage:**
```swift
SecondaryButton(title: "Cancel") {
    dismiss()
}

SecondaryButton(
    title: "Download",
    icon: "arrow.down",
    isLoading: true
) {
    downloadFile()
}
```

### Tertiary Button

The tertiary button is used for subtle actions or text-based buttons.

```swift
TertiaryButton(
    title: String,
    icon: String? = nil,
    isEnabled: Bool = true,
    size: ButtonSize = .medium,
    action: @escaping () -> Void
)
```

**Usage:**
```swift
TertiaryButton(title: "Learn More") {
    showMoreInfo()
}

TertiaryButton(
    title: "Skip",
    icon: "arrow.right"
) {
    skipTutorial()
}
```

### Icon Button

The icon button displays only an icon without text.

```swift
IconButton(
    icon: String,
    size: IconButtonSize = .medium,
    isEnabled: Bool = true,
    action: @escaping () -> Void
)
```

**IconButtonSize Options:**
- `.small`: 32x32 points
- `.medium`: 40x40 points
- `.large`: 48x48 points

**Usage:**
```swift
IconButton(icon: "heart") {
    toggleLike()
}

IconButton(
    icon: "share",
    size: .large
) {
    shareContent()
}
```

---

## 🎨 Button Styles

### Button Size

```swift
enum ButtonSize {
    case small
    case medium
    case large
}
```

**Size Specifications:**
- **Small**: Height 32pt, padding 8pt
- **Medium**: Height 40pt, padding 12pt
- **Large**: Height 48pt, padding 16pt

### Icon Button Size

```swift
enum IconButtonSize {
    case small
    case medium
    case large
}
```

**Size Specifications:**
- **Small**: 32x32 points
- **Medium**: 40x40 points
- **Large**: 48x48 points

---

## ⚙️ Configuration

### Custom Button Style

```swift
struct CustomButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color?
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.labelLarge)
            .foregroundColor(foregroundColor)
            .padding(AppSpacing.md)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor ?? Color.clear, lineWidth: 1)
            )
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
```

**Usage:**
```swift
Button("Custom Button") {
    // Action
}
.buttonStyle(CustomButtonStyle(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textInverse,
    borderColor: nil,
    cornerRadius: 8
))
```

### Button Configuration

```swift
struct ButtonConfiguration {
    let size: ButtonSize
    let cornerRadius: CGFloat
    let shadowEnabled: Bool
    let animationEnabled: Bool
}

// Default configuration
let defaultButtonConfig = ButtonConfiguration(
    size: .medium,
    cornerRadius: 8,
    shadowEnabled: true,
    animationEnabled: true
)
```

---

## ♿ Accessibility

### VoiceOver Support

All buttons automatically include VoiceOver support:

```swift
PrimaryButton(
    title: "Save Document",
    icon: "checkmark"
) {
    saveDocument()
}
// Automatically includes: "Save Document, button"
```

### Custom Accessibility Labels

```swift
PrimaryButton(
    title: "Save",
    icon: "checkmark"
) {
    saveDocument()
}
.accessibilityLabel("Save current document")
.accessibilityHint("Double tap to save your changes")
```

### Accessibility Traits

```swift
PrimaryButton(title: "Submit") {
    submitForm()
}
.accessibilityAddTraits(.isButton)
```

### Dynamic Type Support

All buttons automatically scale with Dynamic Type:

```swift
PrimaryButton(title: "Large Text Button") {
    // Action
}
// Automatically scales with user's text size preference
```

---

## 🎯 Usage Examples

### Form Buttons

```swift
struct FormButtonsExample: View {
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: AppSpacing.md) {
            PrimaryButton(
                title: "Submit Form",
                icon: "checkmark",
                isLoading: isLoading
            ) {
                submitForm()
            }
            
            SecondaryButton(title: "Cancel") {
                dismiss()
            }
            
            TertiaryButton(title: "Save Draft") {
                saveDraft()
            }
        }
        .padding(AppSpacing.lg)
    }
    
    private func submitForm() {
        isLoading = true
        // Form submission logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
        }
    }
    
    private func dismiss() {
        // Dismiss logic
    }
    
    private func saveDraft() {
        // Save draft logic
    }
}
```

### Action Buttons

```swift
struct ActionButtonsExample: View {
    var body: some View {
        HStack(spacing: AppSpacing.md) {
            IconButton(icon: "heart") {
                toggleLike()
            }
            
            IconButton(icon: "share") {
                shareContent()
            }
            
            IconButton(icon: "bookmark") {
                bookmarkContent()
            }
            
            IconButton(icon: "ellipsis") {
                showMoreOptions()
            }
        }
        .padding(AppSpacing.md)
    }
    
    private func toggleLike() {
        // Like/unlike logic
    }
    
    private func shareContent() {
        // Share logic
    }
    
    private func bookmarkContent() {
        // Bookmark logic
    }
    
    private func showMoreOptions() {
        // Show options logic
    }
}
```

### Navigation Buttons

```swift
struct NavigationButtonsExample: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Header with navigation buttons
            HStack {
                IconButton(icon: "chevron.left") {
                    dismiss()
                }
                
                Spacer()
                
                Text("Navigation Example")
                    .font(AppTypography.headlineMedium)
                
                Spacer()
                
                IconButton(icon: "ellipsis") {
                    showMenu()
                }
            }
            .padding(AppSpacing.md)
            
            // Content
            VStack(spacing: AppSpacing.md) {
                PrimaryButton(title: "Continue") {
                    navigateToNext()
                }
                
                SecondaryButton(title: "Back") {
                    navigateToPrevious()
                }
                
                TertiaryButton(title: "Skip") {
                    skipToEnd()
                }
            }
        }
    }
    
    private func showMenu() {
        // Show menu logic
    }
    
    private func navigateToNext() {
        // Navigation logic
    }
    
    private func navigateToPrevious() {
        // Navigation logic
    }
    
    private func skipToEnd() {
        // Skip logic
    }
}
```

### Loading States

```swift
struct LoadingStatesExample: View {
    @State private var isLoading = false
    @State private var downloadProgress = 0.0
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Simple loading button
            PrimaryButton(
                title: "Load Data",
                isLoading: isLoading
            ) {
                loadData()
            }
            
            // Download button with progress
            PrimaryButton(
                title: "Download File",
                icon: "arrow.down",
                isLoading: downloadProgress > 0 && downloadProgress < 1.0
            ) {
                downloadFile()
            }
            
            // Progress indicator
            if downloadProgress > 0 && downloadProgress < 1.0 {
                ProgressIndicator(progress: downloadProgress)
                    .frame(height: 4)
            }
        }
        .padding(AppSpacing.lg)
    }
    
    private func loadData() {
        isLoading = true
        // Simulate loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
        }
    }
    
    private func downloadFile() {
        downloadProgress = 0.0
        // Simulate download
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            downloadProgress += 0.01
            if downloadProgress >= 1.0 {
                timer.invalidate()
                downloadProgress = 0.0
            }
        }
    }
}
```

### Button Groups

```swift
struct ButtonGroupsExample: View {
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Horizontal button group
            HStack(spacing: AppSpacing.sm) {
                PrimaryButton(title: "Accept") {
                    accept()
                }
                
                SecondaryButton(title: "Decline") {
                    decline()
                }
            }
            
            // Vertical button group
            VStack(spacing: AppSpacing.sm) {
                PrimaryButton(title: "Primary Action") {
                    primaryAction()
                }
                
                SecondaryButton(title: "Secondary Action") {
                    secondaryAction()
                }
                
                TertiaryButton(title: "Tertiary Action") {
                    tertiaryAction()
                }
            }
            
            // Icon button group
            HStack(spacing: AppSpacing.md) {
                IconButton(icon: "play") {
                    play()
                }
                
                IconButton(icon: "pause") {
                    pause()
                }
                
                IconButton(icon: "stop") {
                    stop()
                }
            }
        }
        .padding(AppSpacing.lg)
    }
    
    private func accept() { /* Accept logic */ }
    private func decline() { /* Decline logic */ }
    private func primaryAction() { /* Primary action */ }
    private func secondaryAction() { /* Secondary action */ }
    private func tertiaryAction() { /* Tertiary action */ }
    private func play() { /* Play logic */ }
    private func pause() { /* Pause logic */ }
    private func stop() { /* Stop logic */ }
}
```

---

## 🔧 Advanced Usage

### Custom Button with Animation

```swift
struct AnimatedButton: View {
    @State private var isPressed = false
    
    var body: some View {
        Button("Animated Button") {
            // Action
        }
        .font(AppTypography.labelLarge)
        .foregroundColor(AppColors.textInverse)
        .padding(AppSpacing.md)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColors.primary)
                .scaleEffect(isPressed ? 0.95 : 1.0)
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
            }
        }
    }
}
```

### Button with Haptic Feedback

```swift
struct HapticButton: View {
    var body: some View {
        PrimaryButton(title: "Haptic Button") {
            // Trigger haptic feedback
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
            
            // Button action
            performAction()
        }
    }
    
    private func performAction() {
        // Button action logic
    }
}
```

---

Bu API dokümantasyonu, SwiftUI Design System Pro'nun tüm buton bileşenlerini kapsamlı bir şekilde açıklamaktadır. Her buton türünün nasıl kullanılacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

# ♿ Accessibility API

<!-- TOC START -->
## Table of Contents
- [♿ Accessibility API](#-accessibility-api)
- [📋 Table of Contents](#-table-of-contents)
- [🎯 Overview](#-overview)
  - [Key Features](#key-features)
- [♿ Accessibility Features](#-accessibility-features)
  - [VoiceOver Support](#voiceover-support)
  - [Dynamic Type](#dynamic-type)
  - [High Contrast Support](#high-contrast-support)
  - [Reduce Motion](#reduce-motion)
- [🎨 Accessibility Components](#-accessibility-components)
  - [Accessible Button](#accessible-button)
  - [Accessible Card](#accessible-card)
  - [Accessible List](#accessible-list)
  - [Accessible Form](#accessible-form)
- [⚙️ Configuration](#-configuration)
  - [Accessibility Configuration](#accessibility-configuration)
  - [Custom Accessibility Style](#custom-accessibility-style)
- [🎯 Usage Examples](#-usage-examples)
  - [Accessible Product Card](#accessible-product-card)
  - [Accessible Form](#accessible-form)
  - [Accessible Navigation](#accessible-navigation)
  - [Accessible List](#accessible-list)
  - [Accessible Modal](#accessible-modal)
<!-- TOC END -->


**SwiftUI Design System Pro** - Complete Accessibility API Documentation

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [♿ Accessibility Features](#-accessibility-features)
- [🎨 Accessibility Components](#-accessibility-components)
- [⚙️ Configuration](#️-configuration)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Accessibility API provides comprehensive accessibility support for all components in the SwiftUI Design System Pro. Every component is designed with accessibility in mind, ensuring that your app is usable by everyone, including users with disabilities.

### Key Features

- **VoiceOver Support**: Full VoiceOver compatibility for screen readers
- **Dynamic Type**: Automatic text scaling with user preferences
- **High Contrast**: Support for high contrast mode
- **Reduce Motion**: Respect user motion preferences
- **Color Blindness**: Color-blind friendly design
- **Keyboard Navigation**: Full keyboard accessibility
- **Focus Management**: Proper focus handling and navigation

---

## ♿ Accessibility Features

### VoiceOver Support

All components automatically include VoiceOver support with appropriate labels, hints, and traits.

```swift
// Automatic VoiceOver support
PrimaryButton(title: "Save Changes") {
    saveChanges()
}
// Automatically includes: "Save Changes, button"

// Custom VoiceOver labels
PrimaryButton(title: "Save") {
    saveChanges()
}
.accessibilityLabel("Save current document")
.accessibilityHint("Double tap to save your changes")
```

### Dynamic Type

All text automatically scales with the user's preferred text size.

```swift
Text("Dynamic Type Example")
    .font(AppTypography.bodyMedium)
    .foregroundColor(AppColors.textPrimary)
// Automatically scales with user's text size preference
```

### High Contrast Support

Components automatically adapt to high contrast mode.

```swift
@Environment(\.legibilityWeight) var legibilityWeight

var textColor: Color {
    legibilityWeight == .bold ? AppColors.textPrimaryBold : AppColors.textPrimary
}
```

### Reduce Motion

Components respect the user's motion preferences.

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

var animation: Animation {
    reduceMotion ? .none : .easeInOut(duration: 0.3)
}
```

---

## 🎨 Accessibility Components

### Accessible Button

The accessible button component provides enhanced accessibility features.

```swift
AccessibleButton(
    title: String,
    accessibilityLabel: String? = nil,
    accessibilityHint: String? = nil,
    accessibilityTraits: AccessibilityTraits = .button,
    action: @escaping () -> Void
)
```

**Usage:**
```swift
AccessibleButton(
    title: "Submit",
    accessibilityLabel: "Submit form data",
    accessibilityHint: "Double tap to submit your information"
) {
    submitForm()
}
```

### Accessible Card

The accessible card component provides proper accessibility structure.

```swift
AccessibleCard(
    accessibilityLabel: String,
    accessibilityHint: String? = nil,
    @ViewBuilder content: () -> Content
)
```

**Usage:**
```swift
AccessibleCard(
    accessibilityLabel: "Product information card",
    accessibilityHint: "Contains product details and pricing"
) {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Product Name")
            .font(AppTypography.headlineMedium)
        
        Text("Product description")
            .font(AppTypography.bodyMedium)
    }
}
```

### Accessible List

The accessible list component provides proper list accessibility.

```swift
AccessibleList<Data, ID>(
    data: Data,
    id: KeyPath<Data.Element, ID>,
    accessibilityLabel: String,
    @ViewBuilder content: (Data.Element) -> Content
) where Data: RandomAccessCollection, ID: Hashable
```

**Usage:**
```swift
AccessibleList(
    data: items,
    id: \.id,
    accessibilityLabel: "List of products"
) { item in
    HStack {
        Text(item.name)
        Spacer()
        Text(item.price)
    }
}
```

### Accessible Form

The accessible form component provides proper form accessibility.

```swift
AccessibleForm(
    accessibilityLabel: String,
    accessibilityHint: String? = nil,
    @ViewBuilder content: () -> Content
)
```

**Usage:**
```swift
AccessibleForm(
    accessibilityLabel: "User registration form",
    accessibilityHint: "Fill out your information to create an account"
) {
    VStack(spacing: AppSpacing.md) {
        DesignSystemTextField(
            text: $name,
            placeholder: "Name"
        )
        
        DesignSystemTextField(
            text: $email,
            placeholder: "Email"
        )
    }
}
```

---

## ⚙️ Configuration

### Accessibility Configuration

```swift
struct AccessibilityConfiguration {
    let voiceOverEnabled: Bool
    let dynamicTypeEnabled: Bool
    let highContrastEnabled: Bool
    let reduceMotionEnabled: Bool
    let accessibilityTraits: Set<AccessibilityTraits>
}

// Default configuration
let defaultAccessibilityConfig = AccessibilityConfiguration(
    voiceOverEnabled: true,
    dynamicTypeEnabled: true,
    highContrastEnabled: true,
    reduceMotionEnabled: true,
    accessibilityTraits: [.button, .header, .link]
)
```

### Custom Accessibility Style

```swift
struct CustomAccessibilityStyle: AccessibilityStyle {
    let labelColor: Color
    let hintColor: Color
    let focusColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .accessibilityLabel(configuration.label)
            .accessibilityHint(configuration.hint)
            .accessibilityAddTraits(configuration.traits)
    }
}
```

---

## 🎯 Usage Examples

### Accessible Product Card

```swift
struct AccessibleProductCard: View {
    let product: Product
    
    var body: some View {
        AccessibleCard(
            accessibilityLabel: "Product card for \(product.name)",
            accessibilityHint: "Double tap to view product details"
        ) {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                // Product image
                AsyncImage(url: product.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(AppColors.backgroundSecondary)
                }
                .frame(height: 200)
                .clipped()
                .cornerRadius(8)
                .accessibilityHidden(true) // Hide from VoiceOver as it's decorative
                
                // Product information
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text(product.name)
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text(product.description)
                        .font(AppTypography.bodyMedium)
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(2)
                    
                    HStack {
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(AppTypography.titleMedium)
                            .foregroundColor(AppColors.primary)
                            .accessibilityLabel("Price: $\(product.price, specifier: "%.2f")")
                        
                        Spacer()
                        
                        AccessibleButton(
                            title: "Add to Cart",
                            accessibilityLabel: "Add \(product.name) to cart",
                            accessibilityHint: "Double tap to add this product to your shopping cart"
                        ) {
                            addToCart(product)
                        }
                    }
                }
            }
        }
        .accessibilityElement(children: .combine)
    }
    
    private func addToCart(_ product: Product) {
        // Add to cart logic
    }
}
```

### Accessible Form

```swift
struct AccessibleForm: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var errors: [String: String] = [:]
    
    var body: some View {
        AccessibleForm(
            accessibilityLabel: "Contact information form",
            accessibilityHint: "Fill out your contact details"
        ) {
            VStack(spacing: AppSpacing.lg) {
                // Form header
                VStack(spacing: AppSpacing.md) {
                    Text("Contact Information")
                        .font(AppTypography.headlineLarge)
                        .foregroundColor(AppColors.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("Please provide your contact details")
                        .font(AppTypography.bodyMedium)
                        .foregroundColor(AppColors.textSecondary)
                }
                
                // Form fields
                VStack(spacing: AppSpacing.md) {
                    // Name field
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Full Name")
                            .font(AppTypography.labelMedium)
                            .foregroundColor(AppColors.textPrimary)
                            .accessibilityAddTraits(.isHeader)
                        
                        DesignSystemTextField(
                            text: $name,
                            placeholder: "Enter your full name",
                            icon: "person",
                            textContentType: .name,
                            validation: .required,
                            errorMessage: errors["name"]
                        )
                        .accessibilityLabel("Full name field")
                        .accessibilityHint("Enter your first and last name")
                    }
                    
                    // Email field
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Email Address")
                            .font(AppTypography.labelMedium)
                            .foregroundColor(AppColors.textPrimary)
                            .accessibilityAddTraits(.isHeader)
                        
                        DesignSystemTextField(
                            text: $email,
                            placeholder: "Enter your email address",
                            icon: "envelope",
                            keyboardType: .emailAddress,
                            textContentType: .emailAddress,
                            validation: .email,
                            errorMessage: errors["email"]
                        )
                        .accessibilityLabel("Email address field")
                        .accessibilityHint("Enter your email address for contact")
                    }
                    
                    // Phone field
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text("Phone Number")
                            .font(AppTypography.labelMedium)
                            .foregroundColor(AppColors.textPrimary)
                            .accessibilityAddTraits(.isHeader)
                        
                        DesignSystemTextField(
                            text: $phone,
                            placeholder: "Enter your phone number",
                            icon: "phone",
                            keyboardType: .phonePad,
                            textContentType: .telephoneNumber,
                            validation: .phone,
                            errorMessage: errors["phone"]
                        )
                        .accessibilityLabel("Phone number field")
                        .accessibilityHint("Enter your phone number for contact")
                    }
                }
                
                // Submit button
                AccessibleButton(
                    title: "Submit",
                    accessibilityLabel: "Submit contact form",
                    accessibilityHint: "Double tap to submit your contact information"
                ) {
                    submitForm()
                }
            }
        }
        .accessibilityElement(children: .contain)
    }
    
    private func submitForm() {
        // Form submission logic
        errors.removeAll()
        
        if name.isEmpty {
            errors["name"] = "Name is required"
        }
        
        if !email.contains("@") {
            errors["email"] = "Please enter a valid email"
        }
        
        if phone.isEmpty {
            errors["phone"] = "Phone number is required"
        }
    }
}
```

### Accessible Navigation

```swift
struct AccessibleNavigation: View {
    @State private var selectedTab = 0
    
    let tabs = [
        TabItem(title: "Home", icon: "house"),
        TabItem(title: "Search", icon: "magnifyingglass"),
        TabItem(title: "Favorites", icon: "heart"),
        TabItem(title: "Profile", icon: "person")
    ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: tabs[0].icon)
                    Text(tabs[0].title)
                }
                .tag(0)
                .accessibilityLabel("Home tab")
                .accessibilityHint("Navigate to home screen")
            
            SearchView()
                .tabItem {
                    Image(systemName: tabs[1].icon)
                    Text(tabs[1].title)
                }
                .tag(1)
                .accessibilityLabel("Search tab")
                .accessibilityHint("Navigate to search screen")
            
            FavoritesView()
                .tabItem {
                    Image(systemName: tabs[2].icon)
                    Text(tabs[2].title)
                }
                .tag(2)
                .accessibilityLabel("Favorites tab")
                .accessibilityHint("Navigate to favorites screen")
            
            ProfileView()
                .tabItem {
                    Image(systemName: tabs[3].icon)
                    Text(tabs[3].title)
                }
                .tag(3)
                .accessibilityLabel("Profile tab")
                .accessibilityHint("Navigate to profile screen")
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Main navigation")
        .accessibilityHint("Use tabs to navigate between different sections")
    }
}
```

### Accessible List

```swift
struct AccessibleList: View {
    let items: [ListItem]
    
    var body: some View {
        AccessibleList(
            data: items,
            id: \.id,
            accessibilityLabel: "List of items"
        ) { item in
            AccessibleCard(
                accessibilityLabel: "Item: \(item.title)",
                accessibilityHint: "Double tap to view details"
            ) {
                HStack(spacing: AppSpacing.md) {
                    // Item icon
                    Image(systemName: item.icon)
                        .foregroundColor(AppColors.primary)
                        .frame(width: 24, height: 24)
                        .accessibilityHidden(true)
                    
                    // Item content
                    VStack(alignment: .leading, spacing: AppSpacing.sm) {
                        Text(item.title)
                            .font(AppTypography.bodyMedium)
                            .foregroundColor(AppColors.textPrimary)
                            .accessibilityAddTraits(.isHeader)
                        
                        Text(item.subtitle)
                            .font(AppTypography.bodySmall)
                            .foregroundColor(AppColors.textSecondary)
                    }
                    
                    Spacer()
                    
                    // Action button
                    AccessibleButton(
                        title: "View",
                        accessibilityLabel: "View details for \(item.title)",
                        accessibilityHint: "Double tap to view detailed information"
                    ) {
                        viewItem(item)
                    }
                }
                .padding(AppSpacing.md)
            }
        }
        .accessibilityElement(children: .contain)
    }
    
    private func viewItem(_ item: ListItem) {
        // View item logic
    }
}

struct ListItem {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
}
```

### Accessible Modal

```swift
struct AccessibleModal: View {
    @Binding var isPresented: Bool
    let title: String
    let message: String
    
    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            // Modal content
            VStack(spacing: AppSpacing.lg) {
                // Header
                VStack(spacing: AppSpacing.md) {
                    Text(title)
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text(message)
                        .font(AppTypography.bodyMedium)
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                }
                
                // Action buttons
                HStack(spacing: AppSpacing.md) {
                    AccessibleButton(
                        title: "Cancel",
                        accessibilityLabel: "Cancel action",
                        accessibilityHint: "Double tap to close this dialog"
                    ) {
                        isPresented = false
                    }
                    
                    AccessibleButton(
                        title: "Confirm",
                        accessibilityLabel: "Confirm action",
                        accessibilityHint: "Double tap to confirm and close dialog"
                    ) {
                        confirmAction()
                        isPresented = false
                    }
                }
            }
            .padding(AppSpacing.lg)
            .background(AppColors.surface)
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(AppSpacing.lg)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Modal dialog")
        .accessibilityHint("Dialog containing important information")
    }
    
    private func confirmAction() {
        // Confirm action logic
    }
}
```

---

Bu API dokümantasyonu, SwiftUI Design System Pro'nun tüm erişilebilirlik özelliklerini kapsamlı bir şekilde açıklamaktadır. Her erişilebilirlik özelliğinin nasıl kullanılacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

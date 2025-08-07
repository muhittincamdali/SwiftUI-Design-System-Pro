# 🧩 Components Guide

**SwiftUI Design System Pro** - Complete Components Guide

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🧩 Component Categories](#-component-categories)
- [🎨 Component Usage](#-component-usage)
- [⚙️ Configuration](#️-configuration)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Components Guide provides comprehensive instructions for using the component library in SwiftUI Design System Pro. This guide covers all aspects of component usage, from basic components to advanced customization.

### Key Component Areas

- **Interactive Components**: Buttons, forms, navigation
- **Layout Components**: Cards, lists, containers
- **Feedback Components**: Alerts, toasts, progress indicators
- **Data Components**: Charts, tables, data displays
- **Navigation Components**: Tabs, breadcrumbs, menus

---

## 🧩 Component Categories

### 1. Interactive Components

Interactive components provide user interaction capabilities.

**Buttons**
- PrimaryButton: Main action button
- SecondaryButton: Secondary action button
- TertiaryButton: Subtle action button
- IconButton: Icon-only button

**Forms**
- DesignSystemTextField: Text input field
- DesignSystemTextArea: Multi-line text input
- DesignSystemToggle: Boolean input
- DesignSystemPicker: Selection input

### 2. Layout Components

Layout components provide structure and organization.

**Cards**
- Card: Basic content container
- ElevatedCard: Card with elevation
- InteractiveCard: Card with interaction
- MediaCard: Card with media content

**Containers**
- ResponsiveStack: Adaptive stack layout
- ResponsiveGrid: Adaptive grid layout
- TypographyStack: Text layout component

### 3. Feedback Components

Feedback components provide user feedback and status.

**Alerts**
- DesignSystemAlert: Modal alert dialog
- Toast: Temporary notification
- ProgressIndicator: Progress visualization
- LoadingSpinner: Loading state

### 4. Data Components

Data components display and visualize data.

**Charts**
- LineChart: Line chart visualization
- BarChart: Bar chart visualization
- PieChart: Pie chart visualization

**Lists**
- DesignSystemListItem: List item component
- DesignSystemSectionedList: Sectioned list
- AccessibleList: Accessible list component

### 5. Navigation Components

Navigation components provide navigation structure.

**Navigation**
- DesignSystemNavigationBar: Top navigation bar
- DesignSystemTabBar: Bottom tab bar
- Breadcrumbs: Hierarchical navigation
- DesignSystemSideMenu: Side navigation menu

---

## 🎨 Component Usage

### 1. Basic Component Usage

**Button Usage**
```swift
PrimaryButton(title: "Get Started") {
    print("Button tapped")
}

SecondaryButton(
    title: "Cancel",
    icon: "xmark"
) {
    dismiss()
}
```

**Card Usage**
```swift
Card {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Card Title")
            .font(AppTypography.headlineMedium)
        
        Text("Card content goes here")
            .font(AppTypography.bodyMedium)
            .foregroundColor(AppColors.textSecondary)
    }
}
```

**Form Usage**
```swift
DesignSystemTextField(
    text: $email,
    placeholder: "Enter email",
    icon: "envelope",
    keyboardType: .emailAddress
)
```

### 2. Component Customization

**Custom Button Style**
```swift
struct CustomButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.labelLarge)
            .foregroundColor(foregroundColor)
            .padding(AppSpacing.md)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

Button("Custom Button") {
    // Action
}
.buttonStyle(CustomButtonStyle(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textInverse,
    cornerRadius: 12
))
```

**Custom Card Style**
```swift
struct CustomCardStyle: CardStyle {
    let backgroundColor: Color
    let borderColor: Color?
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
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
    }
}

Card {
    Text("Custom styled card")
}
.cardStyle(CustomCardStyle(
    backgroundColor: AppColors.surface,
    borderColor: AppColors.border,
    cornerRadius: 12,
    shadowRadius: 4
))
```

### 3. Component Composition

**Composed Component**
```swift
struct ProductCard: View {
    let product: Product
    
    var body: some View {
        Card {
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
                
                // Product information
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text(product.name)
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(product.description)
                        .font(AppTypography.bodyMedium)
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(2)
                    
                    HStack {
                        Text("$\(product.price, specifier: "%.2f")")
                            .font(AppTypography.titleMedium)
                            .foregroundColor(AppColors.primary)
                        
                        Spacer()
                        
                        PrimaryButton(title: "Add to Cart") {
                            addToCart(product)
                        }
                    }
                }
            }
        }
    }
    
    private func addToCart(_ product: Product) {
        // Add to cart logic
    }
}
```

---

## ⚙️ Configuration

### 1. Component Configuration

```swift
struct ComponentConfiguration {
    let defaultSpacing: CGFloat
    let defaultCornerRadius: CGFloat
    let defaultAnimation: Animation
    let accessibilityEnabled: Bool
    let responsiveEnabled: Bool
}

// Default configuration
let defaultComponentConfig = ComponentConfiguration(
    defaultSpacing: AppSpacing.md,
    defaultCornerRadius: 8,
    defaultAnimation: .easeInOut(duration: 0.3),
    accessibilityEnabled: true,
    responsiveEnabled: true
)
```

### 2. Component Registry

```swift
class ComponentRegistry: ObservableObject {
    @Published var registeredComponents: [String: Any.Type] = [:]
    @Published var componentStyles: [String: Any] = [:]
    
    func register<T>(_ component: T.Type, for name: String) {
        registeredComponents[name] = component
    }
    
    func registerStyle<T>(_ style: T, for name: String) {
        componentStyles[name] = style
    }
    
    func getComponent(for name: String) -> Any.Type? {
        return registeredComponents[name]
    }
    
    func getStyle(for name: String) -> Any? {
        return componentStyles[name]
    }
}
```

### 3. Component Manager

```swift
class ComponentManager: ObservableObject {
    @Published var currentTheme: ComponentTheme = .default
    @Published var componentRegistry = ComponentRegistry()
    
    enum ComponentTheme {
        case `default`
        case custom(ComponentConfiguration)
    }
    
    func setTheme(_ theme: ComponentTheme) {
        currentTheme = theme
        // Apply theme to all components
    }
    
    func registerComponent<T>(_ component: T.Type, name: String) {
        componentRegistry.register(component, for: name)
    }
}
```

---

## 🎯 Usage Examples

### 1. Component Showcase

```swift
struct ComponentShowcase: View {
    @State private var selectedTab = 0
    @State private var showAlert = false
    @State private var email = ""
    @State private var message = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppSpacing.lg) {
                    // Buttons section
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Buttons")
                            .font(AppTypography.headlineLarge)
                            .foregroundColor(AppColors.textPrimary)
                        
                        VStack(spacing: AppSpacing.md) {
                            PrimaryButton(title: "Primary Button") {
                                print("Primary button tapped")
                            }
                            
                            SecondaryButton(title: "Secondary Button") {
                                print("Secondary button tapped")
                            }
                            
                            TertiaryButton(title: "Tertiary Button") {
                                print("Tertiary button tapped")
                            }
                            
                            HStack(spacing: AppSpacing.md) {
                                IconButton(icon: "heart") {
                                    print("Heart button tapped")
                                }
                                
                                IconButton(icon: "share") {
                                    print("Share button tapped")
                                }
                                
                                IconButton(icon: "bookmark") {
                                    print("Bookmark button tapped")
                                }
                            }
                        }
                    }
                    
                    // Cards section
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Cards")
                            .font(AppTypography.headlineLarge)
                            .foregroundColor(AppColors.textPrimary)
                        
                        VStack(spacing: AppSpacing.md) {
                            Card {
                                VStack(alignment: .leading, spacing: AppSpacing.md) {
                                    Text("Basic Card")
                                        .font(AppTypography.headlineMedium)
                                    
                                    Text("This is a basic card component with content.")
                                        .font(AppTypography.bodyMedium)
                                        .foregroundColor(AppColors.textSecondary)
                                }
                            }
                            
                            ElevatedCard {
                                VStack(alignment: .leading, spacing: AppSpacing.md) {
                                    Text("Elevated Card")
                                        .font(AppTypography.headlineMedium)
                                    
                                    Text("This card has elevation for emphasis.")
                                        .font(AppTypography.bodyMedium)
                                        .foregroundColor(AppColors.textSecondary)
                                }
                            }
                            
                            InteractiveCard(
                                onTap: { print("Card tapped") }
                            ) {
                                VStack(alignment: .leading, spacing: AppSpacing.md) {
                                    Text("Interactive Card")
                                        .font(AppTypography.headlineMedium)
                                    
                                    Text("Tap this card to interact with it.")
                                        .font(AppTypography.bodyMedium)
                                        .foregroundColor(AppColors.textSecondary)
                                }
                            }
                        }
                    }
                    
                    // Forms section
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Forms")
                            .font(AppTypography.headlineLarge)
                            .foregroundColor(AppColors.textPrimary)
                        
                        VStack(spacing: AppSpacing.md) {
                            DesignSystemTextField(
                                text: $email,
                                placeholder: "Enter your email",
                                icon: "envelope",
                                keyboardType: .emailAddress
                            )
                            
                            DesignSystemTextArea(
                                text: $message,
                                placeholder: "Enter your message",
                                maxLength: 500
                            )
                            
                            PrimaryButton(title: "Submit Form") {
                                showAlert = true
                            }
                        }
                    }
                    
                    // Feedback section
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Feedback")
                            .font(AppTypography.headlineLarge)
                            .foregroundColor(AppColors.textPrimary)
                        
                        VStack(spacing: AppSpacing.md) {
                            ProgressIndicator(progress: 0.7)
                                .frame(height: 8)
                            
                            LoadingSpinner(size: .large)
                            
                            PrimaryButton(title: "Show Alert") {
                                showAlert = true
                            }
                        }
                    }
                }
                .padding(AppSpacing.lg)
            }
            .navigationTitle("Component Showcase")
        }
        .alert("Form Submitted", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text("Your form has been submitted successfully!")
        }
    }
}
```

### 2. Dashboard with Components

```swift
struct DashboardWithComponents: View {
    @State private var selectedTab = 0
    
    let dashboardItems = [
        DashboardItem(title: "Total Users", value: "1,234", icon: "person.3", change: 12.5),
        DashboardItem(title: "Revenue", value: "$45,678", icon: "dollarsign.circle", change: -2.3),
        DashboardItem(title: "Orders", value: "567", icon: "cart", change: 8.7),
        DashboardItem(title: "Growth", value: "23.4%", icon: "chart.line.uptrend.xyaxis", change: 15.2)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppSpacing.lg) {
                    // Header
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Dashboard")
                            .font(AppTypography.displaySmall)
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("Overview of your application metrics")
                            .font(AppTypography.bodyLarge)
                            .foregroundColor(AppColors.textSecondary)
                    }
                    
                    // Stats grid
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: AppSpacing.md) {
                        ForEach(dashboardItems, id: \.title) { item in
                            DashboardCard(item: item)
                        }
                    }
                    
                    // Recent activity
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Recent Activity")
                            .font(AppTypography.headlineLarge)
                            .foregroundColor(AppColors.textPrimary)
                        
                        VStack(spacing: AppSpacing.sm) {
                            ForEach(0..<5) { index in
                                ActivityItem(
                                    title: "Activity \(index + 1)",
                                    subtitle: "Description for activity \(index + 1)",
                                    time: "\(index + 1) hour ago"
                                )
                            }
                        }
                    }
                    
                    // Quick actions
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Quick Actions")
                            .font(AppTypography.headlineLarge)
                            .foregroundColor(AppColors.textPrimary)
                        
                        HStack(spacing: AppSpacing.md) {
                            PrimaryButton(title: "Add User") {
                                // Add user action
                            }
                            
                            SecondaryButton(title: "Export Data") {
                                // Export action
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

struct DashboardCard: View {
    let item: DashboardItem
    
    var body: some View {
        ElevatedCard {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                HStack {
                    Image(systemName: item.icon)
                        .foregroundColor(AppColors.primary)
                        .font(.title2)
                    
                    Spacer()
                    
                    Text(item.value)
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                }
                
                Text(item.title)
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
                
                HStack {
                    Image(systemName: item.change >= 0 ? "arrow.up" : "arrow.down")
                        .foregroundColor(item.change >= 0 ? AppColors.success : AppColors.error)
                        .font(.caption)
                    
                    Text("\(abs(item.change), specifier: "%.1f")%")
                        .font(AppTypography.labelSmall)
                        .foregroundColor(item.change >= 0 ? AppColors.success : AppColors.error)
                }
            }
        }
    }
}

struct ActivityItem: View {
    let title: String
    let subtitle: String
    let time: String
    
    var body: some View {
        HStack(spacing: AppSpacing.md) {
            Circle()
                .fill(AppColors.primary)
                .frame(width: 8, height: 8)
            
            VStack(alignment: .leading, spacing: AppSpacing.xs) {
                Text(title)
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                Text(subtitle)
                    .font(AppTypography.bodySmall)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            Spacer()
            
            Text(time)
                .font(AppTypography.labelSmall)
                .foregroundColor(AppColors.textTertiary)
        }
        .padding(AppSpacing.md)
        .background(AppColors.surface)
        .cornerRadius(8)
    }
}

struct DashboardItem {
    let title: String
    let value: String
    let icon: String
    let change: Double
}
```

### 3. Form with Components

```swift
struct FormWithComponents: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var message = ""
    @State private var notificationsEnabled = false
    @State private var selectedCategory = "General"
    @State private var showSuccess = false
    
    let categories = [
        "General", "Technical", "Billing", "Feature Request", "Bug Report"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppSpacing.lg) {
                    // Form header
                    VStack(spacing: AppSpacing.md) {
                        Text("Contact Form")
                            .font(AppTypography.headlineLarge)
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("Fill out the form below to get in touch")
                            .font(AppTypography.bodyLarge)
                            .foregroundColor(AppColors.textSecondary)
                    }
                    
                    // Form fields
                    VStack(spacing: AppSpacing.md) {
                        // Personal information
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text("Personal Information")
                                .font(AppTypography.headlineMedium)
                                .foregroundColor(AppColors.textPrimary)
                            
                            DesignSystemTextField(
                                text: $name,
                                placeholder: "Enter your full name",
                                icon: "person",
                                textContentType: .name
                            )
                            
                            DesignSystemTextField(
                                text: $email,
                                placeholder: "Enter your email address",
                                icon: "envelope",
                                keyboardType: .emailAddress,
                                textContentType: .emailAddress
                            )
                            
                            DesignSystemTextField(
                                text: $phone,
                                placeholder: "Enter your phone number",
                                icon: "phone",
                                keyboardType: .phonePad,
                                textContentType: .telephoneNumber
                            )
                        }
                        
                        // Category selection
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text("Category")
                                .font(AppTypography.headlineMedium)
                                .foregroundColor(AppColors.textPrimary)
                            
                            DesignSystemPicker(
                                selection: $selectedCategory,
                                title: "Select Category",
                                options: categories.map { PickerOption(title: $0, value: $0) },
                                icon: "folder"
                            )
                        }
                        
                        // Message
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text("Message")
                                .font(AppTypography.headlineMedium)
                                .foregroundColor(AppColors.textPrimary)
                            
                            DesignSystemTextArea(
                                text: $message,
                                placeholder: "Enter your message",
                                maxLength: 1000,
                                minHeight: 120
                            )
                        }
                        
                        // Preferences
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text("Preferences")
                                .font(AppTypography.headlineMedium)
                                .foregroundColor(AppColors.textPrimary)
                            
                            DesignSystemToggle(
                                isOn: $notificationsEnabled,
                                title: "Receive email notifications",
                                subtitle: "Get notified about updates and responses"
                            )
                        }
                        
                        // Submit button
                        PrimaryButton(
                            title: "Send Message",
                            isLoading: false
                        ) {
                            submitForm()
                        }
                    }
                }
                .padding(AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("Contact Form")
        }
        .sheet(isPresented: $showSuccess) {
            SuccessView()
        }
    }
    
    private func submitForm() {
        // Form validation and submission logic
        showSuccess = true
    }
}

struct SuccessView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(AppColors.success)
                .font(.system(size: 60))
            
            Text("Message Sent!")
                .font(AppTypography.headlineLarge)
                .foregroundColor(AppColors.textPrimary)
            
            Text("We'll get back to you as soon as possible.")
                .font(AppTypography.bodyLarge)
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
            
            PrimaryButton(title: "Done") {
                dismiss()
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
}
```

---

Bu bileşen rehberi, SwiftUI Design System Pro'nun bileşen kütüphanesini kullanmak için gereken tüm teknikleri kapsamlı bir şekilde açıklamaktadır. Her bileşenin nasıl kullanılacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

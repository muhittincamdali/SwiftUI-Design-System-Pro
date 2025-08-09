# 🧩 Components API

<!-- TOC START -->
## Table of Contents
- [🧩 Components API](#-components-api)
- [📋 Table of Contents](#-table-of-contents)
- [🎯 Overview](#-overview)
  - [Component Categories](#component-categories)
- [🔘 Buttons](#-buttons)
  - [Primary Button](#primary-button)
  - [Secondary Button](#secondary-button)
  - [Tertiary Button](#tertiary-button)
  - [Icon Button](#icon-button)
- [🃏 Cards](#-cards)
  - [Basic Card](#basic-card)
  - [Elevated Card](#elevated-card)
  - [Interactive Card](#interactive-card)
- [📝 Forms](#-forms)
  - [Text Field](#text-field)
  - [Text Area](#text-area)
  - [Form Validation](#form-validation)
- [🧭 Navigation](#-navigation)
  - [Navigation Bar](#navigation-bar)
  - [Tab Bar](#tab-bar)
  - [Breadcrumbs](#breadcrumbs)
- [📱 Modals](#-modals)
  - [Alert Dialog](#alert-dialog)
  - [Sheet](#sheet)
  - [Popover](#popover)
- [📋 Lists](#-lists)
  - [List Item](#list-item)
  - [Sectioned List](#sectioned-list)
- [📊 Charts](#-charts)
  - [Line Chart](#line-chart)
  - [Bar Chart](#bar-chart)
  - [Pie Chart](#pie-chart)
- [💬 Feedback](#-feedback)
  - [Toast](#toast)
  - [Progress Indicator](#progress-indicator)
  - [Loading Spinner](#loading-spinner)
- [🎯 Usage Examples](#-usage-examples)
  - [Complete Form Example](#complete-form-example)
  - [Dashboard Example](#dashboard-example)
<!-- TOC END -->


**SwiftUI Design System Pro** - Complete Components API Documentation

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🔘 Buttons](#-buttons)
- [🃏 Cards](#-cards)
- [📝 Forms](#-forms)
- [🧭 Navigation](#-navigation)
- [📱 Modals](#-modals)
- [📋 Lists](#-lists)
- [📊 Charts](#-charts)
- [💬 Feedback](#-feedback)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

SwiftUI Design System Pro provides a comprehensive collection of reusable UI components built with modern design principles and accessibility in mind. All components are designed to work seamlessly with the design token system.

### Component Categories

- **Interactive Components**: Buttons, forms, navigation
- **Layout Components**: Cards, lists, containers
- **Feedback Components**: Alerts, toasts, progress indicators
- **Data Components**: Charts, tables, data displays
- **Navigation Components**: Tabs, breadcrumbs, menus

---

## 🔘 Buttons

### Primary Button

```swift
PrimaryButton(
    title: String,
    icon: String? = nil,
    isLoading: Bool = false,
    isEnabled: Bool = true,
    action: @escaping () -> Void
)
```

**Usage:**
```swift
PrimaryButton(title: "Get Started") {
    print("Button tapped")
}

PrimaryButton(
    title: "Save",
    icon: "checkmark",
    isLoading: false
) {
    // Save action
}
```

### Secondary Button

```swift
SecondaryButton(
    title: String,
    icon: String? = nil,
    isLoading: Bool = false,
    isEnabled: Bool = true,
    action: @escaping () -> Void
)
```

**Usage:**
```swift
SecondaryButton(title: "Cancel") {
    // Cancel action
}

SecondaryButton(
    title: "Download",
    icon: "arrow.down",
    isLoading: true
) {
    // Download action
}
```

### Tertiary Button

```swift
TertiaryButton(
    title: String,
    icon: String? = nil,
    isEnabled: Bool = true,
    action: @escaping () -> Void
)
```

**Usage:**
```swift
TertiaryButton(title: "Learn More") {
    // Learn more action
}
```

### Icon Button

```swift
IconButton(
    icon: String,
    size: IconButtonSize = .medium,
    isEnabled: Bool = true,
    action: @escaping () -> Void
)
```

**Usage:**
```swift
IconButton(icon: "heart") {
    // Like action
}

IconButton(
    icon: "share",
    size: .large
) {
    // Share action
}
```

---

## 🃏 Cards

### Basic Card

```swift
Card(
    padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
    @ViewBuilder content: () -> Content
)
```

**Usage:**
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

### Elevated Card

```swift
ElevatedCard(
    elevation: CardElevation = .medium,
    padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
    @ViewBuilder content: () -> Content
)
```

**Usage:**
```swift
ElevatedCard(elevation: .high) {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Elevated Card")
            .font(AppTypography.headlineMedium)
        
        Text("This card has elevation")
            .font(AppTypography.bodyMedium)
    }
}
```

### Interactive Card

```swift
InteractiveCard(
    isSelected: Bool = false,
    onTap: @escaping () -> Void,
    @ViewBuilder content: () -> Content
)
```

**Usage:**
```swift
InteractiveCard(
    isSelected: selectedCard == 1,
    onTap: { selectedCard = 1 }
) {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Interactive Card")
            .font(AppTypography.headlineMedium)
        
        Text("Tap to select")
            .font(AppTypography.bodyMedium)
    }
}
```

---

## 📝 Forms

### Text Field

```swift
DesignSystemTextField(
    text: Binding<String>,
    placeholder: String,
    icon: String? = nil,
    keyboardType: UIKeyboardType = .default,
    textContentType: UITextContentType? = nil,
    isSecure: Bool = false,
    validation: TextFieldValidation? = nil
)
```

**Usage:**
```swift
@State private var email = ""

DesignSystemTextField(
    text: $email,
    placeholder: "Enter email",
    icon: "envelope",
    keyboardType: .emailAddress,
    textContentType: .emailAddress
)
```

### Text Area

```swift
DesignSystemTextArea(
    text: Binding<String>,
    placeholder: String,
    maxLength: Int? = nil,
    validation: TextFieldValidation? = nil
)
```

**Usage:**
```swift
@State private var description = ""

DesignSystemTextArea(
    text: $description,
    placeholder: "Enter description",
    maxLength: 500
)
```

### Form Validation

```swift
struct TextFieldValidation {
    let isValid: (String) -> Bool
    let errorMessage: String
}

// Predefined validations
TextFieldValidation.email
TextFieldValidation.required
TextFieldValidation.minLength(6)
TextFieldValidation.custom { text in
    // Custom validation logic
    return text.count > 0
}
```

---

## 🧭 Navigation

### Navigation Bar

```swift
DesignSystemNavigationBar(
    title: String,
    leftButton: NavigationBarButton? = nil,
    rightButton: NavigationBarButton? = nil,
    style: NavigationBarStyle = .default
)
```

**Usage:**
```swift
DesignSystemNavigationBar(
    title: "Profile",
    leftButton: NavigationBarButton(
        icon: "chevron.left",
        action: { dismiss() }
    ),
    rightButton: NavigationBarButton(
        icon: "ellipsis",
        action: { showMenu() }
    )
)
```

### Tab Bar

```swift
DesignSystemTabBar(
    selection: Binding<Int>,
    tabs: [TabItem]
)
```

**Usage:**
```swift
@State private var selectedTab = 0

let tabs = [
    TabItem(title: "Home", icon: "house"),
    TabItem(title: "Search", icon: "magnifyingglass"),
    TabItem(title: "Profile", icon: "person")
]

DesignSystemTabBar(
    selection: $selectedTab,
    tabs: tabs
)
```

### Breadcrumbs

```swift
Breadcrumbs(
    items: [BreadcrumbItem],
    onItemTap: @escaping (BreadcrumbItem) -> Void
)
```

**Usage:**
```swift
let breadcrumbItems = [
    BreadcrumbItem(title: "Home", isActive: false),
    BreadcrumbItem(title: "Products", isActive: false),
    BreadcrumbItem(title: "Electronics", isActive: true)
]

Breadcrumbs(
    items: breadcrumbItems,
    onItemTap: { item in
        // Navigate to item
    }
)
```

---

## 📱 Modals

### Alert Dialog

```swift
DesignSystemAlert(
    isPresented: Binding<Bool>,
    title: String,
    message: String,
    primaryButton: AlertButton,
    secondaryButton: AlertButton? = nil
)
```

**Usage:**
```swift
@State private var showAlert = false

DesignSystemAlert(
    isPresented: $showAlert,
    title: "Delete Item",
    message: "Are you sure you want to delete this item?",
    primaryButton: AlertButton(
        title: "Delete",
        style: .destructive,
        action: { deleteItem() }
    ),
    secondaryButton: AlertButton(
        title: "Cancel",
        style: .secondary,
        action: { }
    )
)
```

### Sheet

```swift
DesignSystemSheet(
    isPresented: Binding<Bool>,
    title: String? = nil,
    @ViewBuilder content: () -> Content
)
```

**Usage:**
```swift
@State private var showSheet = false

DesignSystemSheet(
    isPresented: $showSheet,
    title: "Settings"
) {
    VStack(spacing: AppSpacing.lg) {
        Text("Sheet content")
            .font(AppTypography.bodyMedium)
        
        PrimaryButton(title: "Done") {
            showSheet = false
        }
    }
    .padding(AppSpacing.lg)
}
```

### Popover

```swift
DesignSystemPopover(
    isPresented: Binding<Bool>,
    arrowEdge: Edge = .top,
    @ViewBuilder content: () -> Content
)
```

**Usage:**
```swift
@State private var showPopover = false

DesignSystemPopover(
    isPresented: $showPopover,
    arrowEdge: .bottom
) {
    VStack(spacing: AppSpacing.md) {
        Text("Popover content")
            .font(AppTypography.bodyMedium)
    }
    .padding(AppSpacing.md)
}
```

---

## 📋 Lists

### List Item

```swift
DesignSystemListItem(
    title: String,
    subtitle: String? = nil,
    icon: String? = nil,
    trailing: AnyView? = nil,
    onTap: @escaping () -> Void
)
```

**Usage:**
```swift
DesignSystemListItem(
    title: "List Item",
    subtitle: "Subtitle text",
    icon: "star",
    trailing: AnyView(
        Image(systemName: "chevron.right")
            .foregroundColor(AppColors.textTertiary)
    ),
    onTap: { print("Item tapped") }
)
```

### Sectioned List

```swift
DesignSystemSectionedList(
    sections: [ListSection],
    style: ListStyle = .plain
)
```

**Usage:**
```swift
let sections = [
    ListSection(
        title: "Section 1",
        items: [
            ListItem(title: "Item 1"),
            ListItem(title: "Item 2")
        ]
    ),
    ListSection(
        title: "Section 2",
        items: [
            ListItem(title: "Item 3"),
            ListItem(title: "Item 4")
        ]
    )
]

DesignSystemSectionedList(sections: sections)
```

---

## 📊 Charts

### Line Chart

```swift
LineChart(
    data: [ChartDataPoint],
    style: ChartStyle = .default
)
```

**Usage:**
```swift
let data = [
    ChartDataPoint(x: 0, y: 10),
    ChartDataPoint(x: 1, y: 15),
    ChartDataPoint(x: 2, y: 12),
    ChartDataPoint(x: 3, y: 18)
]

LineChart(data: data)
```

### Bar Chart

```swift
BarChart(
    data: [ChartDataPoint],
    style: ChartStyle = .default
)
```

**Usage:**
```swift
let data = [
    ChartDataPoint(x: 0, y: 20),
    ChartDataPoint(x: 1, y: 35),
    ChartDataPoint(x: 2, y: 28),
    ChartDataPoint(x: 3, y: 42)
]

BarChart(data: data)
```

### Pie Chart

```swift
PieChart(
    data: [PieChartSegment],
    style: ChartStyle = .default
)
```

**Usage:**
```swift
let segments = [
    PieChartSegment(value: 30, color: AppColors.primary, label: "Segment 1"),
    PieChartSegment(value: 25, color: AppColors.secondary, label: "Segment 2"),
    PieChartSegment(value: 45, color: AppColors.success, label: "Segment 3")
]

PieChart(segments: segments)
```

---

## 💬 Feedback

### Toast

```swift
Toast(
    message: String,
    type: ToastType = .info,
    duration: TimeInterval = 3.0,
    onDismiss: @escaping () -> Void
)
```

**Usage:**
```swift
Toast(
    message: "Operation completed successfully",
    type: .success,
    duration: 2.0
) {
    print("Toast dismissed")
}
```

### Progress Indicator

```swift
ProgressIndicator(
    progress: Double,
    style: ProgressIndicatorStyle = .linear,
    size: ProgressIndicatorSize = .medium
)
```

**Usage:**
```swift
@State private var progress = 0.0

ProgressIndicator(
    progress: progress,
    style: .circular,
    size: .large
)
```

### Loading Spinner

```swift
LoadingSpinner(
    size: LoadingSpinnerSize = .medium,
    color: Color? = nil
)
```

**Usage:**
```swift
LoadingSpinner(
    size: .large,
    color: AppColors.primary
)
```

---

## 🎯 Usage Examples

### Complete Form Example

```swift
struct CompleteFormExample: View {
    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Header
            VStack(spacing: AppSpacing.md) {
                Text("Contact Form")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Fill out the form below")
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            // Form
            VStack(spacing: AppSpacing.md) {
                DesignSystemTextField(
                    text: $name,
                    placeholder: "Enter your name",
                    icon: "person",
                    textContentType: .name
                )
                
                DesignSystemTextField(
                    text: $email,
                    placeholder: "Enter your email",
                    icon: "envelope",
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress,
                    validation: .email
                )
                
                DesignSystemTextArea(
                    text: $message,
                    placeholder: "Enter your message",
                    maxLength: 500
                )
                
                PrimaryButton(
                    title: "Send Message",
                    isLoading: isLoading
                ) {
                    submitForm()
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
    
    private func submitForm() {
        isLoading = true
        // Submit form logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
        }
    }
}
```

### Dashboard Example

```swift
struct DashboardExample: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppSpacing.lg) {
                    // Stats Cards
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: AppSpacing.md) {
                        ElevatedCard {
                            VStack(spacing: AppSpacing.sm) {
                                Text("Total Users")
                                    .font(AppTypography.labelMedium)
                                    .foregroundColor(AppColors.textSecondary)
                                
                                Text("1,234")
                                    .font(AppTypography.headlineLarge)
                                    .foregroundColor(AppColors.primary)
                            }
                        }
                        
                        ElevatedCard {
                            VStack(spacing: AppSpacing.sm) {
                                Text("Active Users")
                                    .font(AppTypography.labelMedium)
                                    .foregroundColor(AppColors.textSecondary)
                                
                                Text("567")
                                    .font(AppTypography.headlineLarge)
                                    .foregroundColor(AppColors.success)
                            }
                        }
                    }
                    
                    // Chart
                    ElevatedCard {
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text("User Growth")
                                .font(AppTypography.headlineMedium)
                            
                            LineChart(data: sampleChartData)
                                .frame(height: 200)
                        }
                    }
                    
                    // Recent Activity
                    ElevatedCard {
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text("Recent Activity")
                                .font(AppTypography.headlineMedium)
                            
                            VStack(spacing: AppSpacing.sm) {
                                ForEach(0..<3) { index in
                                    DesignSystemListItem(
                                        title: "Activity \(index + 1)",
                                        subtitle: "Description for activity \(index + 1)",
                                        icon: "circle.fill",
                                        onTap: { print("Activity \(index + 1) tapped") }
                                    )
                                }
                            }
                        }
                    }
                }
                .padding(AppSpacing.lg)
            }
            .background(AppColors.background)
            .navigationTitle("Dashboard")
        }
    }
    
    private var sampleChartData: [ChartDataPoint] {
        [
            ChartDataPoint(x: 0, y: 10),
            ChartDataPoint(x: 1, y: 15),
            ChartDataPoint(x: 2, y: 12),
            ChartDataPoint(x: 3, y: 18),
            ChartDataPoint(x: 4, y: 22)
        ]
    }
}
```

---

Bu API dokümantasyonu, SwiftUI Design System Pro'nun tüm bileşenlerini kapsamlı bir şekilde açıklamaktadır. Her bileşenin nasıl kullanılacağı, parametreleri ve pratik örnekler dahil edilmiştir.

# 🎨 Component Guide

Welcome to the comprehensive component guide for SwiftUI Design System Pro. This guide covers all available components with detailed examples and usage patterns.

## 📋 Component Categories

### 🎯 Core Components
- [DSButton](#dsbutton) - Primary, secondary, tertiary, and destructive buttons
- [DSCard](#dscard) - Basic, product, profile, and stats cards
- [DSTextField](#dstextfield) - Text input with validation
- [DSSearchField](#dssearchfield) - Search input with suggestions

### 📱 Navigation Components
- [DSNavigationBar](#dsnavigationbar) - Custom navigation bars
- [DSTabBar](#dstabbar) - Tab bar with badges
- [DSBreadcrumb](#dsbreadcrumb) - Navigation breadcrumbs

### 📊 Data Components
- [DSList](#dslist) - Customizable list components
- [DSTable](#dstable) - Data tables with sorting
- [DSChart](#dschart) - Data visualization charts

### 🎭 Interactive Components
- [DSModal](#dsmodal) - Modal presentations
- [DSAlert](#dsalert) - Alert dialogs
- [DSSheet](#dssheet) - Bottom sheets

## 🎯 DSButton

The primary button component with multiple styles and sizes.

### Basic Usage
```swift
DSButton(
    title: "Get Started",
    style: .primary,
    action: { print("Button tapped") }
)
```

### Styles
```swift
// Primary Button
DSButton(
    title: "Primary Action",
    style: .primary,
    action: { /* Action */ }
)

// Secondary Button
DSButton(
    title: "Secondary Action",
    style: .secondary,
    action: { /* Action */ }
)

// Tertiary Button
DSButton(
    title: "Tertiary Action",
    style: .tertiary,
    action: { /* Action */ }
)

// Destructive Button
DSButton(
    title: "Delete",
    style: .destructive,
    action: { /* Action */ }
)
```

### Sizes
```swift
// Small Button
DSButton(
    title: "Small",
    size: .small,
    action: { /* Action */ }
)

// Medium Button (default)
DSButton(
    title: "Medium",
    size: .medium,
    action: { /* Action */ }
)

// Large Button
DSButton(
    title: "Large",
    size: .large,
    action: { /* Action */ }
)
```

### Accessibility
```swift
DSButton(
    title: "Submit Form",
    style: .primary,
    action: { /* Action */ }
)
.accessibilityLabel("Submit form button")
.accessibilityHint("Double tap to submit the form")
```

## 📊 DSCard

Versatile card components for displaying content.

### Basic Card
```swift
DSCard(
    title: "Card Title",
    subtitle: "Card subtitle with description",
    image: "star.fill"
)
```

### Product Card
```swift
DSProductCard(
    title: "iPhone 15 Pro",
    price: "$999",
    image: "iphone",
    rating: 4.5,
    action: { /* Action */ }
)
```

### Profile Card
```swift
DSProfileCard(
    name: "John Doe",
    role: "iOS Developer",
    avatar: "person.circle.fill",
    action: { /* Action */ }
)
```

### Stats Card
```swift
DSStatsCard(
    title: "Revenue",
    value: "$50,000",
    change: "+12%",
    trend: .up
)
```

## 📝 DSTextField

Text input component with validation.

### Basic Usage
```swift
@State private var email = ""

DSTextField(
    placeholder: "Enter email",
    text: $email,
    validation: .email
)
```

### Validation Types
```swift
// Email validation
DSTextField(
    placeholder: "Enter email",
    text: $email,
    validation: .email
)

// Phone validation
DSTextField(
    placeholder: "Enter phone",
    text: $phone,
    validation: .phone
)

// Custom validation
DSTextField(
    placeholder: "Enter password",
    text: $password,
    validation: .custom { text in
        return text.count >= 8
    }
)
```

## 🔍 DSSearchField

Search input with suggestions.

### Basic Usage
```swift
@State private var searchText = ""
@State private var suggestions = ["Apple", "Banana", "Cherry"]

DSSearchField(
    placeholder: "Search products",
    text: $searchText,
    suggestions: suggestions
)
```

### Advanced Usage
```swift
DSSearchField(
    placeholder: "Search with filters",
    text: $searchText,
    suggestions: suggestions,
    onSuggestionSelected: { suggestion in
        // Handle suggestion selection
    },
    onSearch: { query in
        // Perform search
    }
)
```

## 🧭 DSNavigationBar

Custom navigation bar component.

### Basic Usage
```swift
DSNavigationBar(
    title: "Home",
    leftButton: DSButton(title: "Back", style: .tertiary) { },
    rightButton: DSButton(title: "Done", style: .primary) { }
)
```

### With Search
```swift
DSNavigationBar(
    title: "Search",
    searchText: $searchText,
    onSearch: { query in
        // Handle search
    }
)
```

## 📋 DSList

Customizable list component.

### Basic List
```swift
DSList(items: items) { item in
    DSCard(
        title: item.title,
        subtitle: item.subtitle
    )
}
```

### Grouped List
```swift
DSList(
    items: items,
    grouped: true,
    sectionHeader: "Recent Items"
) { item in
    DSCard(
        title: item.title,
        subtitle: item.subtitle
    )
}
```

## 📊 DSTable

Data table with sorting and filtering.

### Basic Table
```swift
DSTable(
    data: tableData,
    columns: [
        .init(title: "Name", keyPath: \.name),
        .init(title: "Email", keyPath: \.email),
        .init(title: "Role", keyPath: \.role)
    ]
)
```

### Sortable Table
```swift
DSTable(
    data: tableData,
    columns: columns,
    sortable: true,
    onSort: { column, direction in
        // Handle sorting
    }
)
```

## 🎭 DSModal

Modal presentation component.

### Basic Modal
```swift
DSModal(
    isPresented: $showModal,
    title: "Modal Title",
    content: {
        Text("Modal content goes here")
    }
)
```

### Custom Modal
```swift
DSModal(
    isPresented: $showModal,
    title: "Custom Modal",
    style: .sheet,
    content: {
        VStack {
            Text("Custom modal content")
            DSButton(title: "Close", action: { showModal = false })
        }
    }
)
```

## ⚠️ DSAlert

Alert dialog component.

### Basic Alert
```swift
DSAlert(
    isPresented: $showAlert,
    title: "Alert Title",
    message: "Alert message goes here",
    primaryButton: .init(title: "OK", action: { }),
    secondaryButton: .init(title: "Cancel", action: { })
)
```

### Confirmation Alert
```swift
DSAlert(
    isPresented: $showConfirmation,
    title: "Delete Item",
    message: "Are you sure you want to delete this item?",
    primaryButton: .init(title: "Delete", style: .destructive, action: { }),
    secondaryButton: .init(title: "Cancel", action: { })
)
```

## 📱 DSSheet

Bottom sheet component.

### Basic Sheet
```swift
DSSheet(
    isPresented: $showSheet,
    title: "Sheet Title",
    content: {
        VStack {
            Text("Sheet content")
            DSButton(title: "Close", action: { showSheet = false })
        }
    }
)
```

### Custom Sheet
```swift
DSSheet(
    isPresented: $showSheet,
    title: "Custom Sheet",
    style: .medium,
    content: {
        // Custom content
    }
)
```

## 🎨 Customization

### Theme Customization
```swift
// Custom button style
struct CustomButtonStyle: DSButtonStyle {
    func backgroundColor(for colorScheme: ColorScheme) -> Color {
        return .purple
    }
    
    func textColor(for colorScheme: ColorScheme) -> Color {
        return .white
    }
}

// Usage
DSButton(
    title: "Custom Button",
    style: CustomButtonStyle(),
    action: { }
)
```

### Component Modifiers
```swift
DSButton(title: "Custom Button") { }
    .modifier(CustomButtonModifier())
    .environment(\.customTheme, CustomTheme())
```

## ♿ Accessibility

All components include built-in accessibility features:

### VoiceOver Support
```swift
DSButton(title: "Accessible Button") { }
    .accessibilityLabel("Submit form button")
    .accessibilityHint("Double tap to submit the form")
    .accessibilityValue("Form submission")
```

### Dynamic Type
```swift
DSText("Dynamic Text")
    .font(.system(size: 16, weight: .medium, design: .default))
    .dynamicTypeSize(.large...(.accessibility3))
```

### High Contrast
```swift
DSButton(title: "High Contrast Button") { }
    .contrast(1.2)
```

## ⚡ Performance

### Lazy Loading
```swift
LazyVStack {
    ForEach(items) { item in
        DSCard(item: item)
    }
}
```

### Image Optimization
```swift
DSImage("hero-image")
    .cachePolicy(.memoryAndDisk)
    .resizable()
    .aspectRatio(contentMode: .fit)
```

### Animation Performance
```swift
withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
    // Smooth animations
}
```

## 🧪 Testing

### Unit Tests
```swift
class DSButtonTests: XCTestCase {
    func testButtonCreation() {
        let button = DSButton(title: "Test") { }
        XCTAssertNotNil(button)
    }
}
```

### UI Tests
```swift
class DSButtonUITests: XCTestCase {
    func testButtonTap() {
        let app = XCUIApplication()
        app.launch()
        
        let button = app.buttons["Test Button"]
        button.tap()
        
        // Verify action
    }
}
```

## 📚 Next Steps

1. **Explore Examples**: Check out the [Examples](../Examples/README.md) for real-world usage
2. **Learn Theming**: Read the [Theme Guide](../Themes/README.md) for customization
3. **Accessibility**: Review the [Accessibility Guide](../Accessibility/README.md)
4. **Performance**: Optimize with the [Performance Guide](../Performance/README.md)

---

**🎨 Build beautiful interfaces with SwiftUI Design System Pro!** 
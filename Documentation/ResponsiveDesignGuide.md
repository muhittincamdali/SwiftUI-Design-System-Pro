# 📱 Responsive Design Guide

**SwiftUI Design System Pro** - Complete Responsive Design Guide

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [📱 Responsive Features](#-responsive-features)
- [🎨 Responsive Components](#-responsive-components)
- [⚙️ Configuration](#️-configuration)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Responsive Design Guide provides comprehensive instructions for creating responsive applications using the SwiftUI Design System Pro. This guide covers all aspects of responsive design, from basic adaptive layouts to advanced responsive components.

### Key Responsive Areas

- **Adaptive Layouts**: Automatic layout adjustments for different screen sizes
- **Device Detection**: Smart detection of device type and capabilities
- **Orientation Support**: Seamless adaptation to portrait and landscape modes
- **Breakpoint System**: Flexible breakpoint management for responsive design
- **Performance Optimization**: Optimized rendering for different device capabilities
- **Accessibility Integration**: Responsive design that maintains accessibility

---

## 📱 Responsive Features

### 1. Device Detection

The API automatically detects device type and capabilities.

```swift
// Device type detection
@Environment(\.horizontalSizeClass) var horizontalSizeClass
@Environment(\.verticalSizeClass) var verticalSizeClass

// Device-specific layout
if horizontalSizeClass == .compact {
    // iPhone portrait layout
} else {
    // iPad or iPhone landscape layout
}
```

### 2. Breakpoint System

Flexible breakpoint system for responsive design.

```swift
enum ResponsiveBreakpoint {
    case small      // iPhone SE, iPhone 8
    case medium     // iPhone 12, iPhone 13
    case large      // iPhone 12 Pro Max, iPhone 13 Pro Max
    case extraLarge // iPad
    case mac        // macOS
}

// Breakpoint detection
@Environment(\.responsiveBreakpoint) var breakpoint
```

### 3. Adaptive Spacing

Spacing that adapts to screen size.

```swift
// Adaptive spacing
let adaptiveSpacing = ResponsiveSpacing(
    small: AppSpacing.sm,
    medium: AppSpacing.md,
    large: AppSpacing.lg,
    extraLarge: AppSpacing.xl
)
```

---

## 🎨 Responsive Components

### 1. Responsive Grid

The responsive grid component automatically adjusts columns based on screen size.

```swift
ResponsiveGrid(
    items: [GridItem],
    columns: ResponsiveColumns = .adaptive,
    spacing: ResponsiveSpacing = .default
)
```

**ResponsiveColumns Options:**
- `.fixed(Int)`: Fixed number of columns
- `.adaptive`: Automatically adjusts based on screen size
- `.custom(ResponsiveColumnConfig)`: Custom column configuration

**Usage:**
```swift
ResponsiveGrid(
    items: products,
    columns: .adaptive,
    spacing: ResponsiveSpacing(
        small: AppSpacing.sm,
        medium: AppSpacing.md,
        large: AppSpacing.lg
    )
) { product in
    ProductCard(product: product)
}
```

### 2. Responsive Stack

The responsive stack component switches between VStack and HStack based on screen size.

```swift
ResponsiveStack(
    horizontalAlignment: HorizontalAlignment = .center,
    verticalAlignment: VerticalAlignment = .center,
    spacing: ResponsiveSpacing = .default,
    @ViewBuilder content: () -> Content
)
```

**Usage:**
```swift
ResponsiveStack(
    horizontalAlignment: .leading,
    spacing: ResponsiveSpacing(
        small: AppSpacing.sm,
        medium: AppSpacing.md,
        large: AppSpacing.lg
    )
) {
    Text("Title")
        .font(AppTypography.headlineMedium)
    
    Text("Subtitle")
        .font(AppTypography.bodyMedium)
        .foregroundColor(AppColors.textSecondary)
}
```

### 3. Responsive Navigation

The responsive navigation component adapts to different screen sizes.

```swift
ResponsiveNavigation(
    title: String,
    leftButton: NavigationBarButton? = nil,
    rightButton: NavigationBarButton? = nil,
    style: ResponsiveNavigationStyle = .default
)
```

**Usage:**
```swift
ResponsiveNavigation(
    title: "Dashboard",
    leftButton: NavigationBarButton(
        icon: "line.3.horizontal",
        title: "Menu",
        action: { showSideMenu() }
    ),
    rightButton: NavigationBarButton(
        icon: "plus",
        title: "Add",
        action: { showAddSheet() }
    )
)
```

---

## ⚙️ Configuration

### 1. Responsive Configuration

```swift
struct ResponsiveConfiguration {
    let breakpoints: [ResponsiveBreakpoint: CGFloat]
    let defaultSpacing: ResponsiveSpacing
    let adaptiveFonts: Bool
    let performanceOptimization: Bool
}

// Default configuration
let defaultResponsiveConfig = ResponsiveConfiguration(
    breakpoints: [
        .small: 375,
        .medium: 414,
        .large: 428,
        .extraLarge: 768,
        .mac: 1024
    ],
    defaultSpacing: ResponsiveSpacing(
        small: AppSpacing.sm,
        medium: AppSpacing.md,
        large: AppSpacing.lg,
        extraLarge: AppSpacing.xl
    ),
    adaptiveFonts: true,
    performanceOptimization: true
)
```

### 2. Custom Responsive Style

```swift
struct CustomResponsiveStyle: ResponsiveStyle {
    let smallLayout: AnyView
    let mediumLayout: AnyView
    let largeLayout: AnyView
    let extraLargeLayout: AnyView
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            switch configuration.breakpoint {
            case .small:
                smallLayout
            case .medium:
                mediumLayout
            case .large:
                largeLayout
            case .extraLarge, .mac:
                extraLargeLayout
            }
        }
    }
}
```

---

## 🎯 Usage Examples

### 1. Responsive Dashboard

```swift
struct ResponsiveDashboard: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        ResponsiveNavigation(title: "Dashboard") {
            ResponsiveGrid(
                items: dashboardItems,
                columns: .adaptive
            ) { item in
                DashboardCard(item: item)
            }
        }
    }
}

struct DashboardCard: View {
    let item: DashboardItem
    
    var body: some View {
        ResponsiveStack(
            horizontalAlignment: .leading,
            spacing: ResponsiveSpacing(
                small: AppSpacing.sm,
                medium: AppSpacing.md,
                large: AppSpacing.lg
            )
        ) {
            // Card content
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
                
                if let change = item.change {
                    HStack {
                        Image(systemName: change >= 0 ? "arrow.up" : "arrow.down")
                            .foregroundColor(change >= 0 ? AppColors.success : AppColors.error)
                            .font(.caption)
                        
                        Text("\(abs(change), specifier: "%.1f")%")
                            .font(AppTypography.labelSmall)
                            .foregroundColor(change >= 0 ? AppColors.success : AppColors.error)
                    }
                }
            }
            .padding(ResponsiveSpacing(
                small: AppSpacing.sm,
                medium: AppSpacing.md,
                large: AppSpacing.lg
            ))
            .background(AppColors.surface)
            .cornerRadius(8)
        }
    }
}
```

### 2. Responsive Product Grid

```swift
struct ResponsiveProductGrid: View {
    let products: [Product]
    
    var body: some View {
        ResponsiveGrid(
            items: products,
            columns: ResponsiveColumns.custom(
                ResponsiveColumnConfig(
                    small: 1,
                    medium: 2,
                    large: 3,
                    extraLarge: 4,
                    mac: 5
                )
            ),
            spacing: ResponsiveSpacing(
                small: AppSpacing.sm,
                medium: AppSpacing.md,
                large: AppSpacing.lg,
                extraLarge: AppSpacing.xl
            )
        ) { product in
            ResponsiveProductCard(product: product)
        }
    }
}

struct ResponsiveProductCard: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: ResponsiveSpacing(
            small: AppSpacing.sm,
            medium: AppSpacing.md,
            large: AppSpacing.lg
        )) {
            // Product image
            AsyncImage(url: product.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(AppColors.backgroundSecondary)
            }
            .frame(height: ResponsiveHeight(
                small: 150,
                medium: 180,
                large: 200,
                extraLarge: 220
            ))
            .clipped()
            .cornerRadius(8)
            
            // Product information
            VStack(alignment: .leading, spacing: ResponsiveSpacing(
                small: AppSpacing.xs,
                medium: AppSpacing.sm,
                large: AppSpacing.md
            )) {
                Text(product.name)
                    .font(ResponsiveFont(
                        small: AppTypography.bodyMedium,
                        medium: AppTypography.bodyLarge,
                        large: AppTypography.headlineSmall,
                        extraLarge: AppTypography.headlineMedium
                    ))
                    .foregroundColor(AppColors.textPrimary)
                    .lineLimit(2)
                
                Text(product.description)
                    .font(ResponsiveFont(
                        small: AppTypography.bodySmall,
                        medium: AppTypography.bodyMedium,
                        large: AppTypography.bodyLarge,
                        extraLarge: AppTypography.bodyLarge
                    ))
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(3)
                
                HStack {
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(ResponsiveFont(
                            small: AppTypography.bodyMedium,
                            medium: AppTypography.titleSmall,
                            large: AppTypography.titleMedium,
                            extraLarge: AppTypography.titleLarge
                        ))
                        .foregroundColor(AppColors.primary)
                    
                    Spacer()
                    
                    PrimaryButton(
                        title: "Add to Cart",
                        size: ResponsiveButtonSize(
                            small: .small,
                            medium: .medium,
                            large: .medium,
                            extraLarge: .large
                        )
                    ) {
                        addToCart(product)
                    }
                }
            }
        }
        .padding(ResponsiveSpacing(
            small: AppSpacing.sm,
            medium: AppSpacing.md,
            large: AppSpacing.lg
        ))
        .background(AppColors.surface)
        .cornerRadius(12)
    }
    
    private func addToCart(_ product: Product) {
        // Add to cart logic
    }
}
```

### 3. Responsive Form

```swift
struct ResponsiveForm: View {
    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    
    var body: some View {
        ResponsiveStack(
            horizontalAlignment: .leading,
            spacing: ResponsiveSpacing(
                small: AppSpacing.md,
                medium: AppSpacing.lg,
                large: AppSpacing.xl
            )
        ) {
            // Form header
            VStack(alignment: .leading, spacing: ResponsiveSpacing(
                small: AppSpacing.sm,
                medium: AppSpacing.md,
                large: AppSpacing.lg
            )) {
                Text("Contact Form")
                    .font(ResponsiveFont(
                        small: AppTypography.headlineMedium,
                        medium: AppTypography.headlineLarge,
                        large: AppTypography.displaySmall,
                        extraLarge: AppTypography.displayMedium
                    ))
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Fill out the form below to get in touch")
                    .font(ResponsiveFont(
                        small: AppTypography.bodyMedium,
                        medium: AppTypography.bodyLarge,
                        large: AppTypography.bodyLarge,
                        extraLarge: AppTypography.bodyLarge
                    ))
                    .foregroundColor(AppColors.textSecondary)
            }
            
            // Form fields
            VStack(spacing: ResponsiveSpacing(
                small: AppSpacing.md,
                medium: AppSpacing.lg,
                large: AppSpacing.xl
            )) {
                // Name and email fields (side by side on larger screens)
                ResponsiveStack(
                    horizontalAlignment: .leading,
                    spacing: ResponsiveSpacing(
                        small: AppSpacing.md,
                        medium: AppSpacing.lg,
                        large: AppSpacing.lg
                    )
                ) {
                    VStack(alignment: .leading, spacing: ResponsiveSpacing(
                        small: AppSpacing.sm,
                        medium: AppSpacing.md,
                        large: AppSpacing.md
                    )) {
                        Text("Name")
                            .font(AppTypography.labelMedium)
                            .foregroundColor(AppColors.textPrimary)
                        
                        DesignSystemTextField(
                            text: $name,
                            placeholder: "Enter your name",
                            icon: "person",
                            textContentType: .name
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: ResponsiveSpacing(
                        small: AppSpacing.sm,
                        medium: AppSpacing.md,
                        large: AppSpacing.md
                    )) {
                        Text("Email")
                            .font(AppTypography.labelMedium)
                            .foregroundColor(AppColors.textPrimary)
                        
                        DesignSystemTextField(
                            text: $email,
                            placeholder: "Enter your email",
                            icon: "envelope",
                            keyboardType: .emailAddress
                        )
                    }
                }
                
                // Message field
                VStack(alignment: .leading, spacing: ResponsiveSpacing(
                    small: AppSpacing.sm,
                    medium: AppSpacing.md,
                    large: AppSpacing.md
                )) {
                    Text("Message")
                        .font(AppTypography.labelMedium)
                        .foregroundColor(AppColors.textPrimary)
                    
                    DesignSystemTextArea(
                        text: $message,
                        placeholder: "Enter your message",
                        minHeight: ResponsiveHeight(
                            small: 100,
                            medium: 120,
                            large: 150,
                            extraLarge: 180
                        )
                    )
                }
                
                // Submit button
                PrimaryButton(
                    title: "Send Message",
                    size: ResponsiveButtonSize(
                        small: .medium,
                        medium: .large,
                        large: .large,
                        extraLarge: .large
                    )
                ) {
                    submitForm()
                }
            }
        }
        .padding(ResponsiveSpacing(
            small: AppSpacing.lg,
            medium: AppSpacing.xl,
            large: AppSpacing.xxl,
            extraLarge: AppSpacing.xxxl
        ))
        .background(AppColors.background)
    }
    
    private func submitForm() {
        // Form submission logic
    }
}
```

### 4. Responsive Navigation Menu

```swift
struct ResponsiveNavigationMenu: View {
    @State private var selectedTab = 0
    @State private var showSideMenu = false
    
    let menuItems = [
        MenuItem(title: "Home", icon: "house"),
        MenuItem(title: "Products", icon: "cube"),
        MenuItem(title: "About", icon: "info.circle"),
        MenuItem(title: "Contact", icon: "envelope")
    ]
    
    var body: some View {
        ResponsiveNavigation(
            title: "App Name",
            leftButton: NavigationBarButton(
                icon: "line.3.horizontal",
                title: "Menu",
                action: { showSideMenu.toggle() }
            ),
            rightButton: NavigationBarButton(
                icon: "person.circle",
                title: "Profile",
                action: { showProfile() }
            )
        ) {
            ResponsiveStack {
                // Side menu (hidden on small screens)
                if showSideMenu {
                    ResponsiveSideMenu(
                        items: menuItems,
                        selectedItem: $selectedTab,
                        isVisible: $showSideMenu
                    )
                }
                
                // Main content
                ResponsiveMainContent(selectedTab: selectedTab)
            }
        }
    }
    
    private func showProfile() {
        // Show profile logic
    }
}

struct ResponsiveSideMenu: View {
    let items: [MenuItem]
    @Binding var selectedItem: Int
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.md) {
            ForEach(0..<items.count, id: \.self) { index in
                Button(action: {
                    selectedItem = index
                    isVisible = false
                }) {
                    HStack(spacing: AppSpacing.md) {
                        Image(systemName: items[index].icon)
                            .foregroundColor(selectedItem == index ? AppColors.primary : AppColors.textSecondary)
                        
                        Text(items[index].title)
                            .font(AppTypography.bodyMedium)
                            .foregroundColor(selectedItem == index ? AppColors.primary : AppColors.textPrimary)
                        
                        Spacer()
                    }
                    .padding(AppSpacing.md)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(selectedItem == index ? AppColors.primary.opacity(0.1) : Color.clear)
                    )
                }
            }
            
            Spacer()
        }
        .padding(AppSpacing.lg)
        .background(AppColors.surface)
        .frame(width: ResponsiveWidth(
            small: 0,
            medium: 0,
            large: 250,
            extraLarge: 280
        ))
        .animation(.easeInOut(duration: 0.3), value: isVisible)
    }
}

struct ResponsiveMainContent: View {
    let selectedTab: Int
    
    var body: some View {
        Group {
            switch selectedTab {
            case 0:
                HomeView()
            case 1:
                ProductsView()
            case 2:
                AboutView()
            case 3:
                ContactView()
            default:
                HomeView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
```

---

Bu responsive design rehberi, SwiftUI Design System Pro ile responsive uygulamalar oluşturmak için gereken tüm teknikleri kapsamlı bir şekilde açıklamaktadır. Her responsive özelliğin nasıl uygulanacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

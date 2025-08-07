# 🧭 Navigation API

**SwiftUI Design System Pro** - Complete Navigation API Documentation

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🧭 Navigation Components](#-navigation-components)
- [🎨 Navigation Styles](#-navigation-styles)
- [⚙️ Configuration](#️-configuration)
- [♿ Accessibility](#-accessibility)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Navigation API provides a comprehensive collection of navigation components for creating intuitive and accessible navigation experiences in iOS applications. All navigation components are designed with modern iOS design patterns and accessibility in mind.

### Key Features

- **Multiple Navigation Types**: Navigation bars, tab bars, breadcrumbs, and menus
- **Customizable Styling**: Extensive customization options for appearance
- **Accessibility**: Full VoiceOver and accessibility support
- **Responsive Design**: Adaptive layouts for different screen sizes
- **Animation Support**: Smooth transitions and animations
- **Integration**: Seamless integration with SwiftUI navigation

---

## 🧭 Navigation Components

### Navigation Bar

The navigation bar component provides a customizable top navigation bar.

```swift
DesignSystemNavigationBar(
    title: String,
    leftButton: NavigationBarButton? = nil,
    rightButton: NavigationBarButton? = nil,
    style: NavigationBarStyle = .default
)
```

**NavigationBarButton Structure:**
```swift
struct NavigationBarButton {
    let icon: String
    let title: String?
    let action: () -> Void
    let isEnabled: Bool
}
```

**NavigationBarStyle Options:**
- `.default`: Standard navigation bar style
- `.transparent`: Transparent background
- `.blurred`: Blurred background effect
- `.custom(NavigationBarStyleConfig)`: Custom styling

**Usage:**
```swift
DesignSystemNavigationBar(
    title: "Profile",
    leftButton: NavigationBarButton(
        icon: "chevron.left",
        title: "Back",
        action: { dismiss() }
    ),
    rightButton: NavigationBarButton(
        icon: "ellipsis",
        title: "More",
        action: { showMenu() }
    ),
    style: .default
)
```

### Tab Bar

The tab bar component provides bottom tab navigation.

```swift
DesignSystemTabBar(
    selection: Binding<Int>,
    tabs: [TabItem],
    style: TabBarStyle = .default
)
```

**TabItem Structure:**
```swift
struct TabItem {
    let title: String
    let icon: String
    let selectedIcon: String?
    let badge: String?
}
```

**Usage:**
```swift
@State private var selectedTab = 0

let tabs = [
    TabItem(title: "Home", icon: "house"),
    TabItem(title: "Search", icon: "magnifyingglass"),
    TabItem(title: "Favorites", icon: "heart"),
    TabItem(title: "Profile", icon: "person")
]

DesignSystemTabBar(
    selection: $selectedTab,
    tabs: tabs,
    style: .default
)
```

### Breadcrumbs

The breadcrumbs component provides hierarchical navigation context.

```swift
Breadcrumbs(
    items: [BreadcrumbItem],
    onItemTap: @escaping (BreadcrumbItem) -> Void,
    style: BreadcrumbStyle = .default
)
```

**BreadcrumbItem Structure:**
```swift
struct BreadcrumbItem {
    let title: String
    let isActive: Bool
    let icon: String?
}
```

**Usage:**
```swift
let breadcrumbItems = [
    BreadcrumbItem(title: "Home", isActive: false, icon: "house"),
    BreadcrumbItem(title: "Products", isActive: false, icon: "cube"),
    BreadcrumbItem(title: "Electronics", isActive: true, icon: "tv")
]

Breadcrumbs(
    items: breadcrumbItems,
    onItemTap: { item in
        navigateToItem(item)
    }
)
```

### Side Menu

The side menu component provides a sliding side navigation menu.

```swift
DesignSystemSideMenu(
    isOpen: Binding<Bool>,
    menuItems: [MenuItem],
    header: AnyView? = nil,
    style: SideMenuStyle = .default
)
```

**MenuItem Structure:**
```swift
struct MenuItem {
    let title: String
    let icon: String
    let action: () -> Void
    let badge: String?
    let isSelected: Bool
}
```

**Usage:**
```swift
@State private var isMenuOpen = false

let menuItems = [
    MenuItem(title: "Dashboard", icon: "chart.bar", action: { navigateToDashboard() }),
    MenuItem(title: "Profile", icon: "person", action: { navigateToProfile() }),
    MenuItem(title: "Settings", icon: "gear", action: { navigateToSettings() })
]

DesignSystemSideMenu(
    isOpen: $isMenuOpen,
    menuItems: menuItems,
    header: AnyView(
        VStack {
            Text("Menu")
                .font(AppTypography.headlineMedium)
        }
    )
)
```

### Floating Action Button

The floating action button provides quick access to primary actions.

```swift
FloatingActionButton(
    icon: String,
    title: String? = nil,
    action: @escaping () -> Void,
    style: FABStyle = .default
)
```

**Usage:**
```swift
FloatingActionButton(
    icon: "plus",
    title: "Add Item"
) {
    showAddItemSheet()
}
```

---

## 🎨 Navigation Styles

### Navigation Bar Style

```swift
struct NavigationBarStyleConfig {
    let backgroundColor: Color
    let titleColor: Color
    let buttonColor: Color
    let shadowEnabled: Bool
    let blurEffect: Bool
}

enum NavigationBarStyle {
    case `default`
    case transparent
    case blurred
    case custom(NavigationBarStyleConfig)
}
```

### Tab Bar Style

```swift
struct TabBarStyleConfig {
    let backgroundColor: Color
    let selectedColor: Color
    let unselectedColor: Color
    let badgeColor: Color
    let shadowEnabled: Bool
}

enum TabBarStyle {
    case `default`
    case custom(TabBarStyleConfig)
}
```

### Breadcrumb Style

```swift
struct BreadcrumbStyleConfig {
    let separatorColor: Color
    let activeColor: Color
    let inactiveColor: Color
    let fontSize: Font
}

enum BreadcrumbStyle {
    case `default`
    case custom(BreadcrumbStyleConfig)
}
```

---

## ⚙️ Configuration

### Navigation Configuration

```swift
struct NavigationConfiguration {
    let defaultAnimation: Animation
    let transitionDuration: Double
    let hapticFeedback: Bool
    let accessibilityEnabled: Bool
}

// Default configuration
let defaultNavigationConfig = NavigationConfiguration(
    defaultAnimation: .easeInOut(duration: 0.3),
    transitionDuration: 0.3,
    hapticFeedback: true,
    accessibilityEnabled: true
)
```

### Custom Navigation Style

```swift
struct CustomNavigationStyle: NavigationStyle {
    let backgroundColor: Color
    let textColor: Color
    let accentColor: Color
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(cornerRadius)
    }
}
```

---

## ♿ Accessibility

### VoiceOver Support

All navigation components automatically include VoiceOver support:

```swift
DesignSystemNavigationBar(
    title: "Accessible Navigation",
    leftButton: NavigationBarButton(
        icon: "chevron.left",
        title: "Back",
        action: { dismiss() }
    )
)
.accessibilityLabel("Navigation bar with back button")
```

### Custom Accessibility

```swift
DesignSystemTabBar(
    selection: $selectedTab,
    tabs: tabs
)
.accessibilityLabel("Main navigation tabs")
.accessibilityHint("Double tap to switch between tabs")
```

### Navigation Accessibility

```swift
Breadcrumbs(
    items: breadcrumbItems,
    onItemTap: { item in
        navigateToItem(item)
    }
)
.accessibilityLabel("Breadcrumb navigation")
.accessibilityHint("Shows current location in app hierarchy")
```

---

## 🎯 Usage Examples

### Main App Navigation

```swift
struct MainAppNavigation: View {
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
            
            SearchView()
                .tabItem {
                    Image(systemName: tabs[1].icon)
                    Text(tabs[1].title)
                }
                .tag(1)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: tabs[2].icon)
                    Text(tabs[2].title)
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: tabs[3].icon)
                    Text(tabs[3].title)
                }
                .tag(3)
        }
        .overlay(
            DesignSystemTabBar(
                selection: $selectedTab,
                tabs: tabs
            )
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 50)
        )
    }
}
```

### Detail View Navigation

```swift
struct DetailViewNavigation: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showShareSheet = false
    @State private var showMoreOptions = false
    
    let item: DetailItem
    
    var body: some View {
        NavigationView {
            VStack {
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: AppSpacing.lg) {
                        // Item details
                        VStack(alignment: .leading, spacing: AppSpacing.md) {
                            Text(item.title)
                                .font(AppTypography.headlineLarge)
                                .foregroundColor(AppColors.textPrimary)
                            
                            Text(item.description)
                                .font(AppTypography.bodyMedium)
                                .foregroundColor(AppColors.textSecondary)
                        }
                        
                        // Additional content
                        // ...
                    }
                    .padding(AppSpacing.lg)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(AppColors.primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: AppSpacing.sm) {
                        Button(action: { showShareSheet = true }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(AppColors.primary)
                        }
                        
                        Button(action: { showMoreOptions = true }) {
                            Image(systemName: "ellipsis")
                                .foregroundColor(AppColors.primary)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [item.title])
        }
        .actionSheet(isPresented: $showMoreOptions) {
            ActionSheet(
                title: Text("More Options"),
                buttons: [
                    .default(Text("Edit")) { editItem() },
                    .destructive(Text("Delete")) { deleteItem() },
                    .cancel()
                ]
            )
        }
    }
    
    private func editItem() {
        // Edit item logic
    }
    
    private func deleteItem() {
        // Delete item logic
    }
}
```

### E-commerce Navigation

```swift
struct EcommerceNavigation: View {
    @State private var selectedCategory = 0
    @State private var searchText = ""
    @State private var showCart = false
    
    let categories = [
        "All", "Electronics", "Clothing", "Books", "Home", "Sports"
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                VStack(spacing: AppSpacing.md) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(AppColors.textSecondary)
                        
                        TextField("Search products...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(AppColors.textSecondary)
                            }
                        }
                    }
                    .padding(AppSpacing.md)
                    .background(AppColors.surface)
                    .cornerRadius(8)
                    
                    // Category tabs
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: AppSpacing.md) {
                            ForEach(0..<categories.count, id: \.self) { index in
                                Button(action: { selectedCategory = index }) {
                                    Text(categories[index])
                                        .font(AppTypography.labelMedium)
                                        .foregroundColor(selectedCategory == index ? AppColors.primary : AppColors.textSecondary)
                                        .padding(.horizontal, AppSpacing.md)
                                        .padding(.vertical, AppSpacing.sm)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(selectedCategory == index ? AppColors.primary.opacity(0.1) : Color.clear)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, AppSpacing.lg)
                    }
                }
                .padding(AppSpacing.lg)
                .background(AppColors.background)
                
                // Product grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: AppSpacing.md) {
                        ForEach(0..<10) { index in
                            ProductCard(product: sampleProducts[index])
                        }
                    }
                    .padding(AppSpacing.lg)
                }
            }
            .navigationTitle("Shop")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showCart = true }) {
                        Image(systemName: "cart")
                            .foregroundColor(AppColors.primary)
                            .overlay(
                                Circle()
                                    .fill(AppColors.error)
                                    .frame(width: 8, height: 8)
                                    .offset(x: 8, y: -8)
                            )
                    }
                }
            }
        }
        .sheet(isPresented: $showCart) {
            CartView()
        }
    }
    
    private var sampleProducts: [Product] {
        // Sample product data
        []
    }
}
```

### Settings Navigation

```swift
struct SettingsNavigation: View {
    @State private var selectedSection = 0
    @State private var showSideMenu = false
    
    let sections = [
        "General", "Privacy", "Notifications", "Appearance", "About"
    ]
    
    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                // Side menu
                if showSideMenu {
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        ForEach(0..<sections.count, id: \.self) { index in
                            Button(action: { selectedSection = index }) {
                                HStack {
                                    Text(sections[index])
                                        .font(AppTypography.bodyMedium)
                                        .foregroundColor(selectedSection == index ? AppColors.primary : AppColors.textPrimary)
                                    
                                    Spacer()
                                    
                                    if selectedSection == index {
                                        Circle()
                                            .fill(AppColors.primary)
                                            .frame(width: 8, height: 8)
                                    }
                                }
                                .padding(AppSpacing.md)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(selectedSection == index ? AppColors.primary.opacity(0.1) : Color.clear)
                                )
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(width: 200)
                    .background(AppColors.surface)
                    .transition(.move(edge: .leading))
                }
                
                // Main content
                VStack {
                    // Section content
                    switch selectedSection {
                    case 0:
                        GeneralSettingsView()
                    case 1:
                        PrivacySettingsView()
                    case 2:
                        NotificationSettingsView()
                    case 3:
                        AppearanceSettingsView()
                    case 4:
                        AboutView()
                    default:
                        GeneralSettingsView()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showSideMenu.toggle() }) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(AppColors.primary)
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showSideMenu)
    }
}
```

### Onboarding Navigation

```swift
struct OnboardingNavigation: View {
    @State private var currentPage = 0
    @State private var showMainApp = false
    
    let onboardingPages = [
        OnboardingPage(
            title: "Welcome",
            subtitle: "Get started with our amazing app",
            image: "welcome",
            color: AppColors.primary
        ),
        OnboardingPage(
            title: "Discover",
            subtitle: "Explore new features and possibilities",
            image: "discover",
            color: AppColors.secondary
        ),
        OnboardingPage(
            title: "Connect",
            subtitle: "Connect with friends and family",
            image: "connect",
            color: AppColors.success
        )
    ]
    
    var body: some View {
        ZStack {
            // Page content
            TabView(selection: $currentPage) {
                ForEach(0..<onboardingPages.count, id: \.self) { index in
                    OnboardingPageView(page: onboardingPages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Navigation controls
            VStack {
                Spacer()
                
                // Page indicators
                HStack(spacing: AppSpacing.sm) {
                    ForEach(0..<onboardingPages.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? AppColors.primary : AppColors.textTertiary)
                            .frame(width: 8, height: 8)
                            .animation(.easeInOut(duration: 0.3), value: currentPage)
                    }
                }
                .padding(.bottom, AppSpacing.lg)
                
                // Action buttons
                HStack(spacing: AppSpacing.md) {
                    if currentPage > 0 {
                        SecondaryButton(title: "Previous") {
                            withAnimation {
                                currentPage -= 1
                            }
                        }
                    }
                    
                    Spacer()
                    
                    if currentPage < onboardingPages.count - 1 {
                        PrimaryButton(title: "Next") {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                    } else {
                        PrimaryButton(title: "Get Started") {
                            showMainApp = true
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.lg)
                .padding(.bottom, AppSpacing.lg)
            }
        }
        .fullScreenCover(isPresented: $showMainApp) {
            MainAppView()
        }
    }
}

struct OnboardingPage {
    let title: String
    let subtitle: String
    let image: String
    let color: Color
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: AppSpacing.xl) {
            Spacer()
            
            // Image
            Image(page.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .foregroundColor(page.color)
            
            // Text content
            VStack(spacing: AppSpacing.md) {
                Text(page.title)
                    .font(AppTypography.displayMedium)
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                
                Text(page.subtitle)
                    .font(AppTypography.bodyLarge)
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding(AppSpacing.lg)
    }
}
```

---

Bu API dokümantasyonu, SwiftUI Design System Pro'nun tüm navigasyon bileşenlerini kapsamlı bir şekilde açıklamaktadır. Her navigasyon bileşeninin nasıl kullanılacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

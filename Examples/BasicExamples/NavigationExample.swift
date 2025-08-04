import SwiftUI
import DesignSystemPro

/// Comprehensive example demonstrating navigation components
struct NavigationExample: View {
    
    // MARK: - Properties
    
    @State private var selectedTabIndex = 0
    @State private var showingSideMenu = false
    @State private var searchText = ""
    @State private var showingProfile = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom Navigation Bar
                DSNavigationBar(
                    title: "Design System Pro",
                    subtitle: "Navigation Components",
                    leadingButton: DSNavigationButton(
                        icon: "line.3.horizontal",
                        action: { showingSideMenu.toggle() },
                        accessibilityLabel: "Menu"
                    ),
                    trailingButtons: [
                        DSNavigationButton(
                            icon: "magnifyingglass",
                            action: { /* Search action */ },
                            accessibilityLabel: "Search"
                        ),
                        DSNavigationButton(
                            icon: "bell",
                            action: { /* Notifications */ },
                            accessibilityLabel: "Notifications"
                        ),
                        DSNavigationButton(
                            icon: "person.circle",
                            action: { showingProfile.toggle() },
                            accessibilityLabel: "Profile"
                        )
                    ],
                    backgroundStyle: .blurred,
                    titleStyle: .large
                )
                
                // Main Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Navigation Bar Examples
                        navigationBarExamples
                        
                        // Tab Bar Examples
                        tabBarExamples
                        
                        // Search Examples
                        searchExamples
                        
                        // Breadcrumb Examples
                        breadcrumbExamples
                    }
                    .padding()
                }
                
                // Custom Tab Bar
                DSTabBar(
                    selectedIndex: $selectedTabIndex,
                    items: [
                        DSTabItem(
                            title: "Home",
                            icon: "house",
                            selectedIcon: "house.fill",
                            accessibilityLabel: "Home tab"
                        ),
                        DSTabItem(
                            title: "Search",
                            icon: "magnifyingglass",
                            selectedIcon: "magnifyingglass",
                            accessibilityLabel: "Search tab"
                        ),
                        DSTabItem(
                            title: "Favorites",
                            icon: "heart",
                            selectedIcon: "heart.fill",
                            badge: "3",
                            accessibilityLabel: "Favorites tab"
                        ),
                        DSTabItem(
                            title: "Profile",
                            icon: "person",
                            selectedIcon: "person.fill",
                            accessibilityLabel: "Profile tab"
                        )
                    ],
                    style: .custom(
                        backgroundColor: Color(.systemBackground),
                        borderColor: Color(.separator),
                        horizontalPadding: 16,
                        verticalPadding: 8,
                        itemStyle: DSTabItemStyle(
                            iconFont: .system(size: 24),
                            iconColor: .secondary,
                            selectedIconColor: .blue,
                            titleFont: .caption,
                            titleColor: .secondary,
                            selectedTitleColor: .blue,
                            selectedBackgroundColor: Color.blue.opacity(0.1),
                            cornerRadius: 8,
                            badgeStyle: .default
                        )
                    )
                )
            }
        }
        .sheet(isPresented: $showingProfile) {
            ProfileView()
        }
        .sheet(isPresented: $showingSideMenu) {
            SideMenuView()
        }
    }
    
    // MARK: - Navigation Bar Examples
    
    private var navigationBarExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Navigation Bar Examples")
                .font(.title2.bold())
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                // Default Navigation Bar
                DSNavigationBar(
                    title: "Default Style",
                    subtitle: "Standard navigation bar"
                )
                .background(Color(.systemBackground))
                .cornerRadius(12)
                
                // Custom Navigation Bar
                DSNavigationBar(
                    title: "Custom Style",
                    subtitle: "With custom colors",
                    leadingButton: DSNavigationButton(
                        icon: "arrow.left",
                        action: {},
                        accessibilityLabel: "Back"
                    ),
                    trailingButtons: [
                        DSNavigationButton(
                            icon: "ellipsis",
                            action: {},
                            accessibilityLabel: "More options"
                        )
                    ],
                    backgroundStyle: .custom(color: .blue, opacity: 0.1),
                    titleStyle: .custom(
                        font: .title.bold(),
                        textColor: .blue,
                        subtitleColor: .blue.opacity(0.7)
                    )
                )
                .background(Color(.systemBackground))
                .cornerRadius(12)
                
                // Transparent Navigation Bar
                DSNavigationBar(
                    title: "Transparent",
                    subtitle: "No background",
                    isTransparent: true
                )
                .background(Color(.systemBackground))
                .cornerRadius(12)
            }
        }
    }
    
    // MARK: - Tab Bar Examples
    
    private var tabBarExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tab Bar Examples")
                .font(.title2.bold())
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                // Default Tab Bar
                DSTabBar(
                    selectedIndex: .constant(1),
                    items: [
                        DSTabItem(
                            title: "Home",
                            icon: "house",
                            selectedIcon: "house.fill",
                            accessibilityLabel: "Home"
                        ),
                        DSTabItem(
                            title: "Search",
                            icon: "magnifyingglass",
                            selectedIcon: "magnifyingglass",
                            accessibilityLabel: "Search"
                        ),
                        DSTabItem(
                            title: "Profile",
                            icon: "person",
                            selectedIcon: "person.fill",
                            accessibilityLabel: "Profile"
                        )
                    ]
                )
                .background(Color(.systemBackground))
                .cornerRadius(12)
                
                // Custom Tab Bar
                DSTabBar(
                    selectedIndex: .constant(0),
                    items: [
                        DSTabItem(
                            title: "Dashboard",
                            icon: "chart.bar",
                            selectedIcon: "chart.bar.fill",
                            badge: "5",
                            accessibilityLabel: "Dashboard"
                        ),
                        DSTabItem(
                            title: "Messages",
                            icon: "message",
                            selectedIcon: "message.fill",
                            badge: "12",
                            accessibilityLabel: "Messages"
                        ),
                        DSTabItem(
                            title: "Settings",
                            icon: "gear",
                            selectedIcon: "gear",
                            accessibilityLabel: "Settings"
                        )
                    ],
                    style: .custom(
                        backgroundColor: Color(.systemGray6),
                        borderColor: Color(.separator),
                        horizontalPadding: 20,
                        verticalPadding: 12,
                        itemStyle: DSTabItemStyle(
                            iconFont: .system(size: 28),
                            iconColor: .secondary,
                            selectedIconColor: .green,
                            titleFont: .caption2,
                            titleColor: .secondary,
                            selectedTitleColor: .green,
                            selectedBackgroundColor: Color.green.opacity(0.15),
                            cornerRadius: 12,
                            badgeStyle: DSTabBadgeStyle(
                                font: .caption2.bold(),
                                textColor: .white,
                                backgroundColor: .red,
                                horizontalPadding: 4,
                                verticalPadding: 2
                            )
                        )
                    )
                )
                .background(Color(.systemBackground))
                .cornerRadius(12)
            }
        }
    }
    
    // MARK: - Search Examples
    
    private var searchExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Search Components")
                .font(.title2.bold())
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                // Search Field
                DSSearchField(
                    placeholder: "Search components...",
                    text: $searchText
                )
                .background(Color(.systemBackground))
                .cornerRadius(12)
                
                // Search with suggestions
                DSSearchField(
                    placeholder: "Search with suggestions",
                    text: $searchText,
                    suggestions: ["Button", "Card", "Navigation", "Chart"]
                )
                .background(Color(.systemBackground))
                .cornerRadius(12)
            }
        }
    }
    
    // MARK: - Breadcrumb Examples
    
    private var breadcrumbExamples: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Breadcrumb Navigation")
                .font(.title2.bold())
                .foregroundColor(.primary)
            
            VStack(spacing: 8) {
                HStack {
                    Text("Home")
                        .foregroundColor(.blue)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                    Text("Components")
                        .foregroundColor(.blue)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                    Text("Navigation")
                        .foregroundColor(.primary)
                }
                .font(.caption)
                
                HStack {
                    Text("Design System")
                        .foregroundColor(.blue)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                    Text("Examples")
                        .foregroundColor(.blue)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                    Text("Navigation")
                        .foregroundColor(.primary)
                }
                .font(.caption)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
    }
}

// MARK: - Profile View

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("John Doe")
                    .font(.title.bold())
                
                Text("iOS Developer")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Side Menu View

struct SideMenuView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Navigation") {
                    Label("Home", systemImage: "house")
                    Label("Components", systemImage: "square.grid.2x2")
                    Label("Documentation", systemImage: "book")
                    Label("Examples", systemImage: "doc.text")
                }
                
                Section("Support") {
                    Label("Issues", systemImage: "exclamationmark.triangle")
                    Label("Discussions", systemImage: "bubble.left.and.bubble.right")
                    Label("Contributing", systemImage: "hand.raised")
                }
            }
            .navigationTitle("Menu")
        }
    }
}

// MARK: - Preview

struct NavigationExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationExample()
    }
} 
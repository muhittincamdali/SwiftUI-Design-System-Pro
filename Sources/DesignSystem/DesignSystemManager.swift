import SwiftUI

/// Advanced design system management for SwiftUI applications.
///
/// This module provides comprehensive design system utilities including
/// theme management, component libraries, and design token systems.
@available(iOS 15.0, *)
public class DesignSystemManager: ObservableObject {
    
    // MARK: - Properties
    
    /// Current theme
    @Published public var currentTheme: DesignTheme = .light
    
    /// Design tokens
    @Published public var designTokens: DesignTokens = DesignTokens()
    
    /// Component library
    @Published public var componentLibrary: ComponentLibrary = ComponentLibrary()
    
    /// Design analytics
    private var analytics: DesignAnalytics?
    
    /// Theme observers
    private var themeObservers: [ThemeObserver] = []
    
    /// Component registry
    private var componentRegistry: [String: AnyComponent] = [:]
    
    // MARK: - Initialization
    
    /// Creates a new design system manager instance.
    ///
    /// - Parameter analytics: Optional design analytics instance
    public init(analytics: DesignAnalytics? = nil) {
        self.analytics = analytics
        setupDesignSystem()
    }
    
    // MARK: - Setup
    
    /// Sets up the design system.
    private func setupDesignSystem() {
        setupDefaultTheme()
        setupDesignTokens()
        setupComponentLibrary()
        setupThemeObservers()
    }
    
    /// Sets up default theme.
    private func setupDefaultTheme() {
        currentTheme = .light
        analytics?.recordThemeChanged(to: currentTheme)
    }
    
    /// Sets up design tokens.
    private func setupDesignTokens() {
        designTokens = DesignTokens()
        analytics?.recordDesignTokensLoaded()
    }
    
    /// Sets up component library.
    private func setupComponentLibrary() {
        componentLibrary = ComponentLibrary()
        analytics?.recordComponentLibraryLoaded()
    }
    
    /// Sets up theme observers.
    private func setupThemeObservers() {
        // Register for system theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSystemThemeChange),
            name: .traitCollectionDidChange,
            object: nil
        )
    }
    
    // MARK: - Theme Management
    
    /// Changes the current theme.
    ///
    /// - Parameter theme: New theme
    public func changeTheme(to theme: DesignTheme) {
        currentTheme = theme
        updateDesignTokens(for: theme)
        notifyThemeObservers()
        analytics?.recordThemeChanged(to: theme)
    }
    
    /// Updates design tokens for the specified theme.
    ///
    /// - Parameter theme: Theme to update tokens for
    private func updateDesignTokens(for theme: DesignTheme) {
        designTokens.update(for: theme)
    }
    
    /// Notifies theme observers of theme change.
    private func notifyThemeObservers() {
        for observer in themeObservers {
            observer.themeDidChange(to: currentTheme)
        }
    }
    
    /// Handles system theme change.
    @objc private func handleSystemThemeChange() {
        let newTheme: DesignTheme = UITraitCollection.current.userInterfaceStyle == .dark ? .dark : .light
        if newTheme != currentTheme {
            changeTheme(to: newTheme)
        }
    }
    
    // MARK: - Component Management
    
    /// Registers a component in the design system.
    ///
    /// - Parameters:
    ///   - component: Component to register
    ///   - name: Component name
    public func registerComponent(_ component: AnyComponent, name: String) {
        componentRegistry[name] = component
        componentLibrary.addComponent(component, name: name)
        analytics?.recordComponentRegistered(name: name)
    }
    
    /// Retrieves a component by name.
    ///
    /// - Parameter name: Component name
    /// - Returns: Component if found
    public func getComponent(name: String) -> AnyComponent? {
        return componentRegistry[name]
    }
    
    /// Gets all registered components.
    ///
    /// - Returns: Array of component names
    public func getAllComponents() -> [String] {
        return Array(componentRegistry.keys)
    }
    
    // MARK: - Design Token Management
    
    /// Gets a color token.
    ///
    /// - Parameter name: Token name
    /// - Returns: Color value
    public func getColorToken(_ name: String) -> Color {
        return designTokens.getColor(name) ?? .primary
    }
    
    /// Gets a typography token.
    ///
    /// - Parameter name: Token name
    /// - Returns: Font value
    public func getTypographyToken(_ name: String) -> Font {
        return designTokens.getTypography(name) ?? .body
    }
    
    /// Gets a spacing token.
    ///
    /// - Parameter name: Token name
    /// - Returns: Spacing value
    public func getSpacingToken(_ name: String) -> CGFloat {
        return designTokens.getSpacing(name) ?? 8
    }
    
    /// Gets a radius token.
    ///
    /// - Parameter name: Token name
    /// - Returns: Radius value
    public func getRadiusToken(_ name: String) -> CGFloat {
        return designTokens.getRadius(name) ?? 4
    }
    
    /// Gets a shadow token.
    ///
    /// - Parameter name: Token name
    /// - Returns: Shadow value
    public func getShadowToken(_ name: String) -> Shadow {
        return designTokens.getShadow(name) ?? Shadow.none
    }
    
    // MARK: - Theme Observer Management
    
    /// Adds a theme observer.
    ///
    /// - Parameter observer: Observer to add
    public func addThemeObserver(_ observer: ThemeObserver) {
        themeObservers.append(observer)
    }
    
    /// Removes a theme observer.
    ///
    /// - Parameter observer: Observer to remove
    public func removeThemeObserver(_ observer: ThemeObserver) {
        themeObservers.removeAll { $0 === observer }
    }
    
    // MARK: - Design System Analysis
    
    /// Analyzes the design system.
    ///
    /// - Returns: Design system analysis report
    public func analyzeDesignSystem() -> DesignSystemAnalysisReport {
        return DesignSystemAnalysisReport(
            currentTheme: currentTheme,
            componentCount: componentRegistry.count,
            tokenCount: designTokens.tokenCount,
            themeObserverCount: themeObservers.count
        )
    }
    
    /// Gets design system statistics.
    ///
    /// - Returns: Design system statistics
    public func getDesignSystemStatistics() -> DesignSystemStatistics {
        return DesignSystemStatistics(
            currentTheme: currentTheme,
            componentCount: componentRegistry.count,
            colorTokenCount: designTokens.colorTokenCount,
            typographyTokenCount: designTokens.typographyTokenCount,
            spacingTokenCount: designTokens.spacingTokenCount,
            radiusTokenCount: designTokens.radiusTokenCount,
            shadowTokenCount: designTokens.shadowTokenCount
        )
    }
    
    // MARK: - Export/Import
    
    /// Exports design system configuration.
    ///
    /// - Returns: Design system configuration
    public func exportConfiguration() -> DesignSystemConfiguration {
        return DesignSystemConfiguration(
            theme: currentTheme,
            designTokens: designTokens,
            componentLibrary: componentLibrary
        )
    }
    
    /// Imports design system configuration.
    ///
    /// - Parameter configuration: Configuration to import
    public func importConfiguration(_ configuration: DesignSystemConfiguration) {
        currentTheme = configuration.theme
        designTokens = configuration.designTokens
        componentLibrary = configuration.componentLibrary
        
        analytics?.recordConfigurationImported()
    }
}

// MARK: - Supporting Types

/// Design themes.
@available(iOS 15.0, *)
public enum DesignTheme: String, CaseIterable {
    case light
    case dark
    case custom
}

/// Design tokens.
@available(iOS 15.0, *)
public struct DesignTokens {
    public var colors: [String: Color] = [:]
    public var typography: [String: Font] = [:]
    public var spacing: [String: CGFloat] = [:]
    public var radius: [String: CGFloat] = [:]
    public var shadows: [String: Shadow] = [:]
    
    public var tokenCount: Int {
        return colors.count + typography.count + spacing.count + radius.count + shadows.count
    }
    
    public var colorTokenCount: Int { colors.count }
    public var typographyTokenCount: Int { typography.count }
    public var spacingTokenCount: Int { spacing.count }
    public var radiusTokenCount: Int { radius.count }
    public var shadowTokenCount: Int { shadows.count }
    
    public mutating func update(for theme: DesignTheme) {
        // Update tokens based on theme
        switch theme {
        case .light:
            colors = lightThemeColors
            typography = lightThemeTypography
            spacing = defaultSpacing
            radius = defaultRadius
            shadows = lightThemeShadows
        case .dark:
            colors = darkThemeColors
            typography = darkThemeTypography
            spacing = defaultSpacing
            radius = defaultRadius
            shadows = darkThemeShadows
        case .custom:
            // Custom theme implementation
            break
        }
    }
    
    public func getColor(_ name: String) -> Color? {
        return colors[name]
    }
    
    public func getTypography(_ name: String) -> Font? {
        return typography[name]
    }
    
    public func getSpacing(_ name: String) -> CGFloat? {
        return spacing[name]
    }
    
    public func getRadius(_ name: String) -> CGFloat? {
        return radius[name]
    }
    
    public func getShadow(_ name: String) -> Shadow? {
        return shadows[name]
    }
    
    // Default token values
    private var lightThemeColors: [String: Color] {
        return [
            "primary": .blue,
            "secondary": .gray,
            "background": .white,
            "surface": .white,
            "text": .black,
            "textSecondary": .gray
        ]
    }
    
    private var darkThemeColors: [String: Color] {
        return [
            "primary": .blue,
            "secondary": .gray,
            "background": .black,
            "surface": .gray,
            "text": .white,
            "textSecondary": .gray
        ]
    }
    
    private var lightThemeTypography: [String: Font] {
        return [
            "heading1": .largeTitle,
            "heading2": .title,
            "heading3": .title2,
            "body": .body,
            "caption": .caption
        ]
    }
    
    private var darkThemeTypography: [String: Font] {
        return [
            "heading1": .largeTitle,
            "heading2": .title,
            "heading3": .title2,
            "body": .body,
            "caption": .caption
        ]
    }
    
    private var defaultSpacing: [String: CGFloat] {
        return [
            "xs": 4,
            "sm": 8,
            "md": 16,
            "lg": 24,
            "xl": 32,
            "xxl": 48
        ]
    }
    
    private var defaultRadius: [String: CGFloat] {
        return [
            "xs": 2,
            "sm": 4,
            "md": 8,
            "lg": 12,
            "xl": 16,
            "xxl": 24
        ]
    }
    
    private var lightThemeShadows: [String: Shadow] {
        return [
            "none": .none,
            "sm": Shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1),
            "md": Shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2),
            "lg": Shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
        ]
    }
    
    private var darkThemeShadows: [String: Shadow] {
        return [
            "none": .none,
            "sm": Shadow(color: .white.opacity(0.1), radius: 2, x: 0, y: 1),
            "md": Shadow(color: .white.opacity(0.15), radius: 4, x: 0, y: 2),
            "lg": Shadow(color: .white.opacity(0.2), radius: 8, x: 0, y: 4)
        ]
    }
}

/// Shadow definition.
@available(iOS 15.0, *)
public struct Shadow {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat
    
    public static let none = Shadow(color: .clear, radius: 0, x: 0, y: 0)
    
    public init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

/// Component library.
@available(iOS 15.0, *)
public struct ComponentLibrary {
    public var components: [String: AnyComponent] = [:]
    
    public mutating func addComponent(_ component: AnyComponent, name: String) {
        components[name] = component
    }
    
    public func getComponent(_ name: String) -> AnyComponent? {
        return components[name]
    }
}

/// Any component protocol.
@available(iOS 15.0, *)
public protocol AnyComponent {
    var name: String { get }
    var description: String { get }
}

/// Theme observer protocol.
@available(iOS 15.0, *)
public protocol ThemeObserver: AnyObject {
    func themeDidChange(to theme: DesignTheme)
}

/// Design system analysis report.
@available(iOS 15.0, *)
public struct DesignSystemAnalysisReport {
    public let currentTheme: DesignTheme
    public let componentCount: Int
    public let tokenCount: Int
    public let themeObserverCount: Int
}

/// Design system statistics.
@available(iOS 15.0, *)
public struct DesignSystemStatistics {
    public let currentTheme: DesignTheme
    public let componentCount: Int
    public let colorTokenCount: Int
    public let typographyTokenCount: Int
    public let spacingTokenCount: Int
    public let radiusTokenCount: Int
    public let shadowTokenCount: Int
}

/// Design system configuration.
@available(iOS 15.0, *)
public struct DesignSystemConfiguration {
    public let theme: DesignTheme
    public let designTokens: DesignTokens
    public let componentLibrary: ComponentLibrary
}

// MARK: - Design Analytics

/// Design analytics protocol.
@available(iOS 15.0, *)
public protocol DesignAnalytics {
    func recordThemeChanged(to theme: DesignTheme)
    func recordDesignTokensLoaded()
    func recordComponentLibraryLoaded()
    func recordComponentRegistered(name: String)
    func recordConfigurationImported()
} 
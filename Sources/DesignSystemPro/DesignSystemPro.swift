// DesignSystemPro.swift
// DesignSystemPro
//
// Main export file for the complete design system.
// Import this module to access all components, tokens, and themes.

import SwiftUI

// MARK: - Re-exports

// Core Tokens
@_exported import struct SwiftUI.Color
@_exported import struct SwiftUI.Font

// MARK: - Version

public enum DesignSystemPro {
    public static let version = "2.0.0"
    public static let name = "DesignSystemPro"
    
    /// Initialize the design system with optional configuration
    @MainActor
    public static func configure(
        theme: any DSTheme = LightTheme(),
        followSystemColorScheme: Bool = true
    ) {
        let manager = ThemeManager.shared
        manager.followSystem = followSystemColorScheme
        if !followSystemColorScheme {
            manager.setTheme(theme)
        }
    }
}

// MARK: - DSView Protocol

/// Protocol for design system components
public protocol DSComponent: View {
    associatedtype Configuration
    var configuration: Configuration { get }
}

// MARK: - App Entry Point Helper

public struct DSApp<Content: View>: View {
    let content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        DSThemeProvider {
            content()
                .dsToastContainer()
        }
    }
}

// MARK: - Quick Start

/*
 QUICK START GUIDE
 =================
 
 1. SETUP
 --------
 // In your App file:
 @main
 struct MyApp: App {
     var body: some Scene {
         WindowGroup {
             DSApp {
                 ContentView()
             }
         }
     }
 }
 
 2. USE COMPONENTS
 -----------------
 // Buttons
 DSButton.primary("Submit") { }
 DSButton("Cancel", variant: .secondary) { }
 
 // Text Fields
 DSTextField("Email", text: $email, placeholder: "Enter email")
 
 // Cards
 DSCard {
     Text("Card content")
 }
 
 // Badges
 DSBadge("New", variant: .success)
 
 3. USE TOKENS
 -------------
 // Colors
 .foregroundColor(ColorTokens.Accent.primary.light)
 
 // Typography
 Text("Title").dsTypography(TypographyTokens.Heading.h1)
 
 // Spacing
 .padding(SpacingScale.lg.rawValue)
 
 4. THEMING
 ----------
 // Set custom theme
 ThemeManager.shared.setTheme(DarkTheme())
 
 // Create brand theme
 let brand = BrandConfiguration(
     primaryColor: Color.purple,
     secondaryColor: Color.pink
 )
 let theme = brand.generateTheme(id: "myBrand", name: "My Brand")
 ThemeManager.shared.setTheme(theme)
 
 5. TOASTS
 ---------
 DSToastManager.shared.success("Saved!")
 DSToastManager.shared.error("Failed to save")
 
 */

// MARK: - Component Catalog

/// All available components in the design system
public enum DSComponentCatalog {
    // Buttons
    public static let button = "DSButton"
    public static let iconButton = "DSIconButton"
    
    // Inputs
    public static let textField = "DSTextField"
    public static let textArea = "DSTextArea"
    public static let searchField = "DSSearchField"
    public static let otpField = "DSOTPField"
    
    // Selection
    public static let toggle = "DSToggle"
    public static let checkbox = "DSCheckbox"
    public static let radio = "DSRadio"
    
    // Display
    public static let card = "DSCard"
    public static let badge = "DSBadge"
    public static let avatar = "DSAvatar"
    public static let skeleton = "DSSkeleton"
    
    // Feedback
    public static let toast = "DSToast"
    public static let alert = "DSAlert"
    public static let modal = "DSModal"
    
    // Navigation
    public static let navigationBar = "DSNavigationBar"
    public static let tabBar = "DSTabBar"
    
    // Data Display
    public static let chart = "DSChart"
    public static let progressIndicator = "DSProgressIndicator"
}

// MARK: - Accessibility

public enum DSAccessibility {
    /// Check if reduce motion is preferred
    @MainActor
    public static var prefersReducedMotion: Bool {
        #if canImport(UIKit)
        return UIAccessibility.isReduceMotionEnabled
        #else
        return false
        #endif
    }
    
    /// Check if bold text is preferred
    @MainActor
    public static var prefersBoldText: Bool {
        #if canImport(UIKit)
        return UIAccessibility.isBoldTextEnabled
        #else
        return false
        #endif
    }
    
    /// Check if high contrast is preferred
    @MainActor
    public static var prefersHighContrast: Bool {
        #if canImport(UIKit)
        return UIAccessibility.isDarkerSystemColorsEnabled
        #else
        return false
        #endif
    }
}

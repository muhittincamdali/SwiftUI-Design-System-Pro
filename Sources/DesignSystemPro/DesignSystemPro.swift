// DesignSystemPro.swift
// DesignSystemPro
//
// Library entry points: version information, one-time configuration and the
// `DSApp` root wrapper that installs the theme provider and toast container.

import SwiftUI

public enum DesignSystemPro {
    public static let version = "2.0.0"
    public static let name = "DesignSystemPro"

    /// Configures the shared ``ThemeManager``.
    ///
    /// - Parameters:
    ///   - theme: Theme to apply when `followSystemColorScheme` is `false`.
    ///   - followSystemColorScheme: When `true`, the light or dark theme is chosen
    ///     from the system color scheme and `theme` is ignored.
    @MainActor
    public static func configure(
        theme: any DSTheme = LightTheme(),
        followSystemColorScheme: Bool = true
    ) {
        let manager = ThemeManager.shared
        if followSystemColorScheme {
            manager.followSystem = true
        } else {
            manager.setTheme(theme)
        }
    }
}

// MARK: - App Entry Point Helper

/// Root wrapper that installs ``DSThemeProvider`` and the toast overlay.
///
/// ```swift
/// @main
/// struct MyApp: App {
///     var body: some Scene {
///         WindowGroup {
///             DSApp { ContentView() }
///         }
///     }
/// }
/// ```
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

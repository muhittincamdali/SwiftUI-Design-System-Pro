import SwiftUI

/// Main entry point for the SwiftUI Design System Pro.
public enum DesignSystemPro {
    public static let version = "2.0.0"
}

/// A world-class standard for typography.
public struct ProTypography: Sendable {
    @MainActor public static let headline = Font.system(.title, design: .rounded).bold()
    @MainActor public static let body = Font.system(.body, design: .default)
    @MainActor public static let caption = Font.system(.caption, design: .monospaced)
}

/// A world-class standard for colors.
public struct ProColors: Sendable {
    public static let primary = Color.blue
    public static let secondary = Color.gray
    public static let accent = Color.orange
}

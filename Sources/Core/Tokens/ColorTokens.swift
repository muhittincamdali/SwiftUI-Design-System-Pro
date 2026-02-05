// ColorTokens.swift
// DesignSystemPro
//
// Production-grade color token system with semantic colors,
// accessibility support, and dynamic theme integration.

import SwiftUI

// MARK: - Color Token Protocol

/// Protocol for color tokens that support semantic naming and accessibility
public protocol ColorToken {
    var light: Color { get }
    var dark: Color { get }
    var highContrast: Color { get }
    var accessibilityLabel: String { get }
    
    func resolved(for colorScheme: ColorScheme, highContrast: Bool) -> Color
}

extension ColorToken {
    public func resolved(for colorScheme: ColorScheme, highContrast: Bool = false) -> Color {
        if highContrast {
            return self.highContrast
        }
        return colorScheme == .dark ? dark : light
    }
}

// MARK: - Primitive Colors

/// Raw color values - the foundation layer
/// These should never be used directly in UI components
public enum PrimitiveColors {
    
    // MARK: - Gray Scale (11 steps)
    public enum Gray {
        public static let gray50 = Color(hex: "#FAFAFA")
        public static let gray100 = Color(hex: "#F5F5F5")
        public static let gray200 = Color(hex: "#EEEEEE")
        public static let gray300 = Color(hex: "#E0E0E0")
        public static let gray400 = Color(hex: "#BDBDBD")
        public static let gray500 = Color(hex: "#9E9E9E")
        public static let gray600 = Color(hex: "#757575")
        public static let gray700 = Color(hex: "#616161")
        public static let gray800 = Color(hex: "#424242")
        public static let gray900 = Color(hex: "#212121")
        public static let gray950 = Color(hex: "#0A0A0A")
    }
    
    // MARK: - Primary Blue
    public enum Blue {
        public static let blue50 = Color(hex: "#EFF6FF")
        public static let blue100 = Color(hex: "#DBEAFE")
        public static let blue200 = Color(hex: "#BFDBFE")
        public static let blue300 = Color(hex: "#93C5FD")
        public static let blue400 = Color(hex: "#60A5FA")
        public static let blue500 = Color(hex: "#3B82F6")
        public static let blue600 = Color(hex: "#2563EB")
        public static let blue700 = Color(hex: "#1D4ED8")
        public static let blue800 = Color(hex: "#1E40AF")
        public static let blue900 = Color(hex: "#1E3A8A")
        public static let blue950 = Color(hex: "#172554")
    }
    
    // MARK: - Success Green
    public enum Green {
        public static let green50 = Color(hex: "#F0FDF4")
        public static let green100 = Color(hex: "#DCFCE7")
        public static let green200 = Color(hex: "#BBF7D0")
        public static let green300 = Color(hex: "#86EFAC")
        public static let green400 = Color(hex: "#4ADE80")
        public static let green500 = Color(hex: "#22C55E")
        public static let green600 = Color(hex: "#16A34A")
        public static let green700 = Color(hex: "#15803D")
        public static let green800 = Color(hex: "#166534")
        public static let green900 = Color(hex: "#14532D")
        public static let green950 = Color(hex: "#052E16")
    }
    
    // MARK: - Warning Yellow/Amber
    public enum Amber {
        public static let amber50 = Color(hex: "#FFFBEB")
        public static let amber100 = Color(hex: "#FEF3C7")
        public static let amber200 = Color(hex: "#FDE68A")
        public static let amber300 = Color(hex: "#FCD34D")
        public static let amber400 = Color(hex: "#FBBF24")
        public static let amber500 = Color(hex: "#F59E0B")
        public static let amber600 = Color(hex: "#D97706")
        public static let amber700 = Color(hex: "#B45309")
        public static let amber800 = Color(hex: "#92400E")
        public static let amber900 = Color(hex: "#78350F")
        public static let amber950 = Color(hex: "#451A03")
    }
    
    // MARK: - Error Red
    public enum Red {
        public static let red50 = Color(hex: "#FEF2F2")
        public static let red100 = Color(hex: "#FEE2E2")
        public static let red200 = Color(hex: "#FECACA")
        public static let red300 = Color(hex: "#FCA5A5")
        public static let red400 = Color(hex: "#F87171")
        public static let red500 = Color(hex: "#EF4444")
        public static let red600 = Color(hex: "#DC2626")
        public static let red700 = Color(hex: "#B91C1C")
        public static let red800 = Color(hex: "#991B1B")
        public static let red900 = Color(hex: "#7F1D1D")
        public static let red950 = Color(hex: "#450A0A")
    }
    
    // MARK: - Purple
    public enum Purple {
        public static let purple50 = Color(hex: "#FAF5FF")
        public static let purple100 = Color(hex: "#F3E8FF")
        public static let purple200 = Color(hex: "#E9D5FF")
        public static let purple300 = Color(hex: "#D8B4FE")
        public static let purple400 = Color(hex: "#C084FC")
        public static let purple500 = Color(hex: "#A855F7")
        public static let purple600 = Color(hex: "#9333EA")
        public static let purple700 = Color(hex: "#7C3AED")
        public static let purple800 = Color(hex: "#6B21A8")
        public static let purple900 = Color(hex: "#581C87")
        public static let purple950 = Color(hex: "#3B0764")
    }
    
    // MARK: - Teal
    public enum Teal {
        public static let teal50 = Color(hex: "#F0FDFA")
        public static let teal100 = Color(hex: "#CCFBF1")
        public static let teal200 = Color(hex: "#99F6E4")
        public static let teal300 = Color(hex: "#5EEAD4")
        public static let teal400 = Color(hex: "#2DD4BF")
        public static let teal500 = Color(hex: "#14B8A6")
        public static let teal600 = Color(hex: "#0D9488")
        public static let teal700 = Color(hex: "#0F766E")
        public static let teal800 = Color(hex: "#115E59")
        public static let teal900 = Color(hex: "#134E4A")
        public static let teal950 = Color(hex: "#042F2E")
    }
    
    // MARK: - Pink
    public enum Pink {
        public static let pink50 = Color(hex: "#FDF2F8")
        public static let pink100 = Color(hex: "#FCE7F3")
        public static let pink200 = Color(hex: "#FBCFE8")
        public static let pink300 = Color(hex: "#F9A8D4")
        public static let pink400 = Color(hex: "#F472B6")
        public static let pink500 = Color(hex: "#EC4899")
        public static let pink600 = Color(hex: "#DB2777")
        public static let pink700 = Color(hex: "#BE185D")
        public static let pink800 = Color(hex: "#9D174D")
        public static let pink900 = Color(hex: "#831843")
        public static let pink950 = Color(hex: "#500724")
    }
    
    // MARK: - Orange
    public enum Orange {
        public static let orange50 = Color(hex: "#FFF7ED")
        public static let orange100 = Color(hex: "#FFEDD5")
        public static let orange200 = Color(hex: "#FED7AA")
        public static let orange300 = Color(hex: "#FDBA74")
        public static let orange400 = Color(hex: "#FB923C")
        public static let orange500 = Color(hex: "#F97316")
        public static let orange600 = Color(hex: "#EA580C")
        public static let orange700 = Color(hex: "#C2410C")
        public static let orange800 = Color(hex: "#9A3412")
        public static let orange900 = Color(hex: "#7C2D12")
        public static let orange950 = Color(hex: "#431407")
    }
}

// MARK: - Semantic Color Tokens

/// Semantic colors that map to UI concepts
/// These are the tokens that should be used in components
public struct SemanticColorToken: ColorToken {
    public let light: Color
    public let dark: Color
    public let highContrast: Color
    public let accessibilityLabel: String
    
    public init(
        light: Color,
        dark: Color,
        highContrast: Color? = nil,
        accessibilityLabel: String = ""
    ) {
        self.light = light
        self.dark = dark
        self.highContrast = highContrast ?? light
        self.accessibilityLabel = accessibilityLabel
    }
}

// MARK: - Color Tokens Namespace

public enum ColorTokens {
    
    // MARK: - Background Colors
    public enum Background {
        public static let primary = SemanticColorToken(
            light: .white,
            dark: PrimitiveColors.Gray.gray900,
            highContrast: .white,
            accessibilityLabel: "Primary background"
        )
        
        public static let secondary = SemanticColorToken(
            light: PrimitiveColors.Gray.gray50,
            dark: PrimitiveColors.Gray.gray800,
            highContrast: PrimitiveColors.Gray.gray100,
            accessibilityLabel: "Secondary background"
        )
        
        public static let tertiary = SemanticColorToken(
            light: PrimitiveColors.Gray.gray100,
            dark: PrimitiveColors.Gray.gray700,
            highContrast: PrimitiveColors.Gray.gray200,
            accessibilityLabel: "Tertiary background"
        )
        
        public static let elevated = SemanticColorToken(
            light: .white,
            dark: PrimitiveColors.Gray.gray800,
            accessibilityLabel: "Elevated surface"
        )
        
        public static let overlay = SemanticColorToken(
            light: Color.black.opacity(0.4),
            dark: Color.black.opacity(0.6),
            accessibilityLabel: "Overlay background"
        )
    }
    
    // MARK: - Foreground Colors
    public enum Foreground {
        public static let primary = SemanticColorToken(
            light: PrimitiveColors.Gray.gray900,
            dark: PrimitiveColors.Gray.gray50,
            highContrast: .black,
            accessibilityLabel: "Primary text"
        )
        
        public static let secondary = SemanticColorToken(
            light: PrimitiveColors.Gray.gray600,
            dark: PrimitiveColors.Gray.gray400,
            highContrast: PrimitiveColors.Gray.gray700,
            accessibilityLabel: "Secondary text"
        )
        
        public static let tertiary = SemanticColorToken(
            light: PrimitiveColors.Gray.gray500,
            dark: PrimitiveColors.Gray.gray500,
            accessibilityLabel: "Tertiary text"
        )
        
        public static let placeholder = SemanticColorToken(
            light: PrimitiveColors.Gray.gray400,
            dark: PrimitiveColors.Gray.gray600,
            accessibilityLabel: "Placeholder text"
        )
        
        public static let disabled = SemanticColorToken(
            light: PrimitiveColors.Gray.gray300,
            dark: PrimitiveColors.Gray.gray700,
            accessibilityLabel: "Disabled text"
        )
        
        public static let onAccent = SemanticColorToken(
            light: .white,
            dark: .white,
            accessibilityLabel: "Text on accent color"
        )
    }
    
    // MARK: - Accent Colors
    public enum Accent {
        public static let primary = SemanticColorToken(
            light: PrimitiveColors.Blue.blue600,
            dark: PrimitiveColors.Blue.blue400,
            highContrast: PrimitiveColors.Blue.blue700,
            accessibilityLabel: "Primary accent"
        )
        
        public static let secondary = SemanticColorToken(
            light: PrimitiveColors.Purple.purple600,
            dark: PrimitiveColors.Purple.purple400,
            accessibilityLabel: "Secondary accent"
        )
        
        public static let tertiary = SemanticColorToken(
            light: PrimitiveColors.Teal.teal600,
            dark: PrimitiveColors.Teal.teal400,
            accessibilityLabel: "Tertiary accent"
        )
    }
    
    // MARK: - Status Colors
    public enum Status {
        public static let success = SemanticColorToken(
            light: PrimitiveColors.Green.green600,
            dark: PrimitiveColors.Green.green400,
            highContrast: PrimitiveColors.Green.green700,
            accessibilityLabel: "Success"
        )
        
        public static let successBackground = SemanticColorToken(
            light: PrimitiveColors.Green.green50,
            dark: PrimitiveColors.Green.green950,
            accessibilityLabel: "Success background"
        )
        
        public static let warning = SemanticColorToken(
            light: PrimitiveColors.Amber.amber600,
            dark: PrimitiveColors.Amber.amber400,
            highContrast: PrimitiveColors.Amber.amber700,
            accessibilityLabel: "Warning"
        )
        
        public static let warningBackground = SemanticColorToken(
            light: PrimitiveColors.Amber.amber50,
            dark: PrimitiveColors.Amber.amber950,
            accessibilityLabel: "Warning background"
        )
        
        public static let error = SemanticColorToken(
            light: PrimitiveColors.Red.red600,
            dark: PrimitiveColors.Red.red400,
            highContrast: PrimitiveColors.Red.red700,
            accessibilityLabel: "Error"
        )
        
        public static let errorBackground = SemanticColorToken(
            light: PrimitiveColors.Red.red50,
            dark: PrimitiveColors.Red.red950,
            accessibilityLabel: "Error background"
        )
        
        public static let info = SemanticColorToken(
            light: PrimitiveColors.Blue.blue600,
            dark: PrimitiveColors.Blue.blue400,
            accessibilityLabel: "Information"
        )
        
        public static let infoBackground = SemanticColorToken(
            light: PrimitiveColors.Blue.blue50,
            dark: PrimitiveColors.Blue.blue950,
            accessibilityLabel: "Information background"
        )
    }
    
    // MARK: - Border Colors
    public enum Border {
        public static let primary = SemanticColorToken(
            light: PrimitiveColors.Gray.gray200,
            dark: PrimitiveColors.Gray.gray700,
            accessibilityLabel: "Primary border"
        )
        
        public static let secondary = SemanticColorToken(
            light: PrimitiveColors.Gray.gray300,
            dark: PrimitiveColors.Gray.gray600,
            accessibilityLabel: "Secondary border"
        )
        
        public static let focus = SemanticColorToken(
            light: PrimitiveColors.Blue.blue500,
            dark: PrimitiveColors.Blue.blue400,
            accessibilityLabel: "Focus border"
        )
        
        public static let error = SemanticColorToken(
            light: PrimitiveColors.Red.red500,
            dark: PrimitiveColors.Red.red400,
            accessibilityLabel: "Error border"
        )
    }
    
    // MARK: - Interactive Colors
    public enum Interactive {
        public static let hover = SemanticColorToken(
            light: PrimitiveColors.Gray.gray100,
            dark: PrimitiveColors.Gray.gray800,
            accessibilityLabel: "Hover state"
        )
        
        public static let pressed = SemanticColorToken(
            light: PrimitiveColors.Gray.gray200,
            dark: PrimitiveColors.Gray.gray700,
            accessibilityLabel: "Pressed state"
        )
        
        public static let selected = SemanticColorToken(
            light: PrimitiveColors.Blue.blue50,
            dark: PrimitiveColors.Blue.blue900,
            accessibilityLabel: "Selected state"
        )
        
        public static let disabled = SemanticColorToken(
            light: PrimitiveColors.Gray.gray100,
            dark: PrimitiveColors.Gray.gray800,
            accessibilityLabel: "Disabled state"
        )
    }
}

// MARK: - Color Extension for Hex Support

extension Color {
    /// Initialize a Color from a hex string
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    /// Convert Color to hex string
    public func toHex() -> String? {
        #if canImport(UIKit)
        guard let components = UIColor(self).cgColor.components else { return nil }
        #elseif canImport(AppKit)
        guard let components = NSColor(self).cgColor.components else { return nil }
        #else
        return nil
        #endif
        
        let r = Float(components[0])
        let g = Float(components.count >= 3 ? components[1] : components[0])
        let b = Float(components.count >= 3 ? components[2] : components[0])
        
        return String(format: "#%02lX%02lX%02lX",
                      lroundf(r * 255),
                      lroundf(g * 255),
                      lroundf(b * 255))
    }
}

// MARK: - Dynamic Color View Extension

extension View {
    /// Apply a semantic color token that automatically adapts to color scheme
    public func dsBackgroundColor(_ token: SemanticColorToken) -> some View {
        self.modifier(DynamicColorModifier(token: token, type: .background))
    }
    
    /// Apply a semantic foreground color token
    public func dsForegroundColor(_ token: SemanticColorToken) -> some View {
        self.modifier(DynamicColorModifier(token: token, type: .foreground))
    }
}

private struct DynamicColorModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityHighContrast) private var highContrast
    
    let token: SemanticColorToken
    let type: ColorType
    
    enum ColorType {
        case background
        case foreground
    }
    
    func body(content: Content) -> some View {
        let resolvedColor = token.resolved(for: colorScheme, highContrast: highContrast)
        
        switch type {
        case .background:
            return AnyView(content.background(resolvedColor))
        case .foreground:
            return AnyView(content.foregroundColor(resolvedColor))
        }
    }
}

// MARK: - Accessibility Extensions

extension EnvironmentValues {
    /// Check if high contrast mode is enabled
    public var accessibilityHighContrast: Bool {
        #if canImport(UIKit)
        return UIAccessibility.isDarkerSystemColorsEnabled
        #else
        return false
        #endif
    }
}

// MARK: - Color Contrast Utilities

public enum ColorContrastUtility {
    /// Calculate relative luminance of a color
    public static func relativeLuminance(_ color: Color) -> Double {
        #if canImport(UIKit)
        guard let components = UIColor(color).cgColor.components else { return 0 }
        #elseif canImport(AppKit)
        guard let components = NSColor(color).cgColor.components else { return 0 }
        #else
        return 0
        #endif
        
        let r = adjustGamma(components[0])
        let g = adjustGamma(components.count >= 3 ? components[1] : components[0])
        let b = adjustGamma(components.count >= 3 ? components[2] : components[0])
        
        return 0.2126 * r + 0.7152 * g + 0.0722 * b
    }
    
    private static func adjustGamma(_ value: CGFloat) -> Double {
        let v = Double(value)
        return v <= 0.03928 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4)
    }
    
    /// Calculate contrast ratio between two colors (WCAG standard)
    public static func contrastRatio(_ color1: Color, _ color2: Color) -> Double {
        let l1 = relativeLuminance(color1)
        let l2 = relativeLuminance(color2)
        
        let lighter = max(l1, l2)
        let darker = min(l1, l2)
        
        return (lighter + 0.05) / (darker + 0.05)
    }
    
    /// Check if contrast meets WCAG AA standard (4.5:1 for normal text)
    public static func meetsWCAG_AA(_ foreground: Color, _ background: Color) -> Bool {
        return contrastRatio(foreground, background) >= 4.5
    }
    
    /// Check if contrast meets WCAG AAA standard (7:1 for normal text)
    public static func meetsWCAG_AAA(_ foreground: Color, _ background: Color) -> Bool {
        return contrastRatio(foreground, background) >= 7.0
    }
    
    /// Check if contrast meets WCAG AA standard for large text (3:1)
    public static func meetsWCAG_AA_LargeText(_ foreground: Color, _ background: Color) -> Bool {
        return contrastRatio(foreground, background) >= 3.0
    }
}

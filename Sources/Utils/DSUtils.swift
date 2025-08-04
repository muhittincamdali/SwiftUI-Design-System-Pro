import SwiftUI

/**
 * Design System Utilities
 * 
 * Utility functions and extensions for SwiftUI Design System Pro
 */
public struct DSUtils {
    public init() {}
}

// MARK: - Color Extensions

extension Color {
    /**
     * Create color from hex string
     */
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
    
    /**
     * Convert color to hex string
     */
    public func toHex() -> String {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return "#000000"
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let hex = String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        return hex
    }
}

// MARK: - View Extensions

extension View {
    /**
     * Apply corner radius to specific corners
     */
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /**
     * Apply shadow with custom parameters
     */
    public func customShadow(
        color: Color = .black,
        radius: CGFloat = 10,
        x: CGFloat = 0,
        y: CGFloat = 5,
        opacity: Double = 0.1
    ) -> some View {
        self.shadow(color: color.opacity(opacity), radius: radius, x: x, y: y)
    }
    
    /**
     * Apply haptic feedback
     */
    public func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) -> some View {
        self.onTapGesture {
            let impactFeedback = UIImpactFeedbackGenerator(style: style)
            impactFeedback.impactOccurred()
        }
    }
    
    /**
     * Apply success haptic feedback
     */
    public func successHaptic() -> some View {
        self.onTapGesture {
            let notificationFeedback = UINotificationFeedbackGenerator()
            notificationFeedback.notificationOccurred(.success)
        }
    }
    
    /**
     * Apply error haptic feedback
     */
    public func errorHaptic() -> some View {
        self.onTapGesture {
            let notificationFeedback = UINotificationFeedbackGenerator()
            notificationFeedback.notificationOccurred(.error)
        }
    }
}

// MARK: - Rounded Corner Shape

public struct RoundedCorner: Shape {
    public var radius: CGFloat = .infinity
    public var corners: UIRectCorner = .allCorners
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Device Utilities

public struct DSDevice {
    /**
     * Check if device is iPhone
     */
    public static var isiPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    /**
     * Check if device is iPad
     */
    public static var isiPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /**
     * Check if device is Mac
     */
    public static var isMac: Bool {
        UIDevice.current.userInterfaceIdiom == .mac
    }
    
    /**
     * Get device screen size
     */
    public static var screenSize: CGSize {
        UIScreen.main.bounds.size
    }
    
    /**
     * Get device screen width
     */
    public static var screenWidth: CGFloat {
        screenSize.width
    }
    
    /**
     * Get device screen height
     */
    public static var screenHeight: CGFloat {
        screenSize.height
    }
}

// MARK: - Validation Utilities

public struct DSValidation {
    /**
     * Validate email format
     */
    public static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    /**
     * Validate phone number format
     */
    public static func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[+]?[0-9]{10,15}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    
    /**
     * Validate password strength
     */
    public static func isValidPassword(_ password: String) -> Bool {
        let hasMinLength = password.count >= 8
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
        let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
        
        return hasMinLength && hasUppercase && hasLowercase && hasNumber
    }
}

// MARK: - String Utilities

extension String {
    /**
     * Capitalize first letter
     */
    public var capitalizedFirst: String {
        guard !isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
    
    /**
     * Truncate string to specified length
     */
    public func truncated(to length: Int, trailing: String = "...") -> String {
        if count > length {
            return String(prefix(length)) + trailing
        }
        return self
    }
    
    /**
     * Remove extra whitespace
     */
    public var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Date Utilities

extension Date {
    /**
     * Format date to string
     */
    public func formattedString(_ format: String = "MMM dd, yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /**
     * Check if date is today
     */
    public var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    /**
     * Check if date is yesterday
     */
    public var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
} 
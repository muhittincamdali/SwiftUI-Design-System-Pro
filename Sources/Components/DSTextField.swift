import SwiftUI

public struct DSTextField: View {
    public let placeholder: String
    @Binding public var text: String
    public let validation: DSValidationType?
    public let style: DSTextFieldStyle
    public let size: DSTextFieldSize
    public let isSecure: Bool
    public let keyboardType: UIKeyboardType
    public let returnKeyType: UIReturnKeyType
    public let onCommit: (() -> Void)?
    public let onEditingChanged: ((Bool) -> Void)?
    
    @State private var isEditing = false
    @State private var isValid = true
    @State private var errorMessage = ""
    @FocusState private var isFocused: Bool
    
    public init(
        placeholder: String,
        text: Binding<String>,
        validation: DSValidationType? = nil,
        style: DSTextFieldStyle = .primary,
        size: DSTextFieldSize = .medium,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        returnKeyType: UIReturnKeyType = .done,
        onCommit: (() -> Void)? = nil,
        onEditingChanged: ((Bool) -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.validation = validation
        self.style = style
        self.size = size
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.onCommit = onCommit
        self.onEditingChanged = onEditingChanged
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .textFieldStyle(.plain)
                        .focused($isFocused)
                        .onSubmit { onCommit?() }
                        .onChange(of: isFocused) { newValue in
                            isEditing = newValue
                            onEditingChanged?(newValue)
                            validateInput()
                        }
                } else {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(.plain)
                        .focused($isFocused)
                        .keyboardType(keyboardType)
                        .submitLabel(returnKeyType.submitLabel)
                        .onSubmit { onCommit?() }
                        .onChange(of: isFocused) { newValue in
                            isEditing = newValue
                            onEditingChanged?(newValue)
                            validateInput()
                        }
                }
            }
            .frame(height: size.height)
            .background(style.backgroundColor(for: colorScheme))
            .cornerRadius(style.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .stroke(isEditing ? style.focusedBorderColor : style.borderColor, lineWidth: isEditing ? 2 : 1)
            )
            .animation(.easeInOut(duration: 0.2), value: isEditing)
            
            if !isValid && !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .onChange(of: text) { _ in validateInput() }
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    private func validateInput() {
        guard let validation = validation else {
            isValid = true
            errorMessage = ""
            return
        }
        
        let validationResult = validation.validate(text)
        isValid = validationResult.isValid
        errorMessage = validationResult.errorMessage
    }
}

public struct DSTextFieldStyle {
    public let backgroundColor: (ColorScheme) -> Color
    public let borderColor: Color
    public let focusedBorderColor: Color
    public let cornerRadius: CGFloat
    
    public init(
        backgroundColor: @escaping (ColorScheme) -> Color,
        borderColor: Color,
        focusedBorderColor: Color,
        cornerRadius: CGFloat
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.focusedBorderColor = focusedBorderColor
        self.cornerRadius = cornerRadius
    }
    
    public static let primary = DSTextFieldStyle(
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        borderColor: Color(.systemGray4),
        focusedBorderColor: .blue,
        cornerRadius: 8
    )
    
    public static let secondary = DSTextFieldStyle(
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6)
        },
        borderColor: Color(.systemGray3),
        focusedBorderColor: .green,
        cornerRadius: 12
    )
}

public enum DSTextFieldSize {
    case small, medium, large
    
    public var height: CGFloat {
        switch self {
        case .small: return 36
        case .medium: return 44
        case .large: return 52
        }
    }
}

public enum DSValidationType {
    case email, phone, password, custom((String) -> DSValidationResult)
    
    public func validate(_ text: String) -> DSValidationResult {
        switch self {
        case .email: return validateEmail(text)
        case .phone: return validatePhone(text)
        case .password: return validatePassword(text)
        case .custom(let validator): return validator(text)
        }
    }
    
    private func validateEmail(_ text: String) -> DSValidationResult {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailPredicate.evaluate(with: text)
        return DSValidationResult(isValid: isValid, errorMessage: isValid ? "" : "Please enter a valid email address")
    }
    
    private func validatePhone(_ text: String) -> DSValidationResult {
        let phoneRegex = "^[+]?[0-9]{10,15}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phonePredicate.evaluate(with: text)
        return DSValidationResult(isValid: isValid, errorMessage: isValid ? "" : "Please enter a valid phone number")
    }
    
    private func validatePassword(_ text: String) -> DSValidationResult {
        let hasMinLength = text.count >= 8
        let hasUppercase = text.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = text.range(of: "[a-z]", options: .regularExpression) != nil
        let hasNumber = text.range(of: "[0-9]", options: .regularExpression) != nil
        let isValid = hasMinLength && hasUppercase && hasLowercase && hasNumber
        return DSValidationResult(isValid: isValid, errorMessage: isValid ? "" : "Password must be at least 8 characters with uppercase, lowercase, and number")
    }
}

public struct DSValidationResult {
    public let isValid: Bool
    public let errorMessage: String
    
    public init(isValid: Bool, errorMessage: String) {
        self.isValid = isValid
        self.errorMessage = errorMessage
    }
}

extension UIReturnKeyType {
    var submitLabel: SubmitLabel {
        switch self {
        case .done: return .done
        case .go: return .go
        case .next: return .next
        case .search: return .search
        case .send: return .send
        case .join: return .join
        case .route: return .route
        case .emergencyCall: return .emergencyCall
        case .continue: return .continue
        case .default: return .done
        @unknown default: return .done
        }
    }
} 
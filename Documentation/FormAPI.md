# 📝 Form API

**SwiftUI Design System Pro** - Complete Form API Documentation

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [📝 Form Components](#-form-components)
- [✅ Validation](#-validation)
- [⚙️ Configuration](#️-configuration)
- [♿ Accessibility](#-accessibility)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Form API provides a comprehensive collection of form components for creating user-friendly input interfaces. All form components are designed with accessibility in mind and follow the design system's token-based approach.

### Key Features

- **Multiple Input Types**: Text fields, text areas, toggles, pickers, and more
- **Built-in Validation**: Real-time validation with error messages
- **Accessibility**: Full VoiceOver and accessibility support
- **Customization**: Extensive styling and behavior options
- **Form Management**: Easy form state management
- **Error Handling**: Comprehensive error display and handling

---

## 📝 Form Components

### Text Field

The text field component provides single-line text input with various customization options.

```swift
DesignSystemTextField(
    text: Binding<String>,
    placeholder: String,
    icon: String? = nil,
    keyboardType: UIKeyboardType = .default,
    textContentType: UITextContentType? = nil,
    isSecure: Bool = false,
    validation: TextFieldValidation? = nil,
    errorMessage: String? = nil
)
```

**Parameters:**
- `text`: Binding to the text value
- `placeholder`: Placeholder text
- `icon`: Optional SF Symbol icon name
- `keyboardType`: Keyboard type for the field
- `textContentType`: Content type for auto-fill
- `isSecure`: Whether the field is for secure input
- `validation`: Validation rules
- `errorMessage`: Custom error message

**Usage:**
```swift
@State private var email = ""
@State private var emailError: String?

DesignSystemTextField(
    text: $email,
    placeholder: "Enter your email",
    icon: "envelope",
    keyboardType: .emailAddress,
    textContentType: .emailAddress,
    validation: .email,
    errorMessage: emailError
)
```

### Text Area

The text area component provides multi-line text input.

```swift
DesignSystemTextArea(
    text: Binding<String>,
    placeholder: String,
    maxLength: Int? = nil,
    minHeight: CGFloat = 100,
    validation: TextFieldValidation? = nil,
    errorMessage: String? = nil
)
```

**Usage:**
```swift
@State private var description = ""
@State private var descriptionError: String?

DesignSystemTextArea(
    text: $description,
    placeholder: "Enter your description",
    maxLength: 500,
    minHeight: 120,
    validation: .required,
    errorMessage: descriptionError
)
```

### Toggle

The toggle component provides boolean input with custom styling.

```swift
DesignSystemToggle(
    isOn: Binding<Bool>,
    title: String,
    subtitle: String? = nil,
    icon: String? = nil
)
```

**Usage:**
```swift
@State private var notificationsEnabled = false

DesignSystemToggle(
    isOn: $notificationsEnabled,
    title: "Enable Notifications",
    subtitle: "Receive push notifications for updates",
    icon: "bell"
)
```

### Picker

The picker component provides selection from a list of options.

```swift
DesignSystemPicker<T>(
    selection: Binding<T>,
    title: String,
    options: [PickerOption<T>],
    icon: String? = nil
)
```

**Usage:**
```swift
@State private var selectedCountry = "US"

let countries = [
    PickerOption(title: "United States", value: "US"),
    PickerOption(title: "Canada", value: "CA"),
    PickerOption(title: "United Kingdom", value: "UK")
]

DesignSystemPicker(
    selection: $selectedCountry,
    title: "Country",
    options: countries,
    icon: "globe"
)
```

### Date Picker

The date picker component provides date and time selection.

```swift
DesignSystemDatePicker(
    date: Binding<Date>,
    title: String,
    mode: DatePickerMode = .date,
    icon: String? = nil
)
```

**Usage:**
```swift
@State private var birthDate = Date()

DesignSystemDatePicker(
    date: $birthDate,
    title: "Birth Date",
    mode: .date,
    icon: "calendar"
)
```

### Slider

The slider component provides range selection.

```swift
DesignSystemSlider(
    value: Binding<Double>,
    range: ClosedRange<Double>,
    title: String,
    subtitle: String? = nil,
    step: Double = 1.0
)
```

**Usage:**
```swift
@State private var rating = 5.0

DesignSystemSlider(
    value: $rating,
    range: 1...10,
    title: "Rating",
    subtitle: "Rate your experience",
    step: 0.5
)
```

---

## ✅ Validation

### Validation Types

```swift
enum TextFieldValidation {
    case required
    case email
    case phone
    case url
    case minLength(Int)
    case maxLength(Int)
    case pattern(String)
    case custom((String) -> Bool)
}
```

### Predefined Validations

```swift
// Required field
TextFieldValidation.required

// Email validation
TextFieldValidation.email

// Phone number validation
TextFieldValidation.phone

// URL validation
TextFieldValidation.url

// Length validation
TextFieldValidation.minLength(6)
TextFieldValidation.maxLength(50)

// Custom pattern validation
TextFieldValidation.pattern("^[A-Za-z]+$")

// Custom validation
TextFieldValidation.custom { text in
    return text.contains("@")
}
```

### Validation Usage

```swift
@State private var password = ""
@State private var passwordError: String?

DesignSystemTextField(
    text: $password,
    placeholder: "Enter password",
    icon: "lock",
    isSecure: true,
    validation: .minLength(8),
    errorMessage: passwordError
)
.onChange(of: password) { newValue in
    // Custom validation logic
    if newValue.count < 8 {
        passwordError = "Password must be at least 8 characters"
    } else {
        passwordError = nil
    }
}
```

---

## ⚙️ Configuration

### Form Configuration

```swift
struct FormConfiguration {
    let spacing: CGFloat
    let validationMode: ValidationMode
    let errorDisplayMode: ErrorDisplayMode
    let animationEnabled: Bool
}

enum ValidationMode {
    case immediate    // Validate on every change
    case onBlur      // Validate when field loses focus
    case onSubmit    // Validate only on form submission
}

enum ErrorDisplayMode {
    case inline      // Show errors below fields
    case summary     // Show errors in summary
    case both        // Show both inline and summary
}
```

### Custom Form Style

```swift
struct CustomFormStyle: FormStyle {
    let backgroundColor: Color
    let borderColor: Color
    let cornerRadius: CGFloat
    let padding: EdgeInsets
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
            .cornerRadius(cornerRadius)
            .padding(padding)
    }
}
```

---

## ♿ Accessibility

### VoiceOver Support

All form components automatically include VoiceOver support:

```swift
DesignSystemTextField(
    text: $email,
    placeholder: "Enter email"
)
.accessibilityLabel("Email address field")
.accessibilityHint("Enter your email address")
```

### Custom Accessibility

```swift
DesignSystemToggle(
    isOn: $notificationsEnabled,
    title: "Notifications"
)
.accessibilityLabel("Enable notifications toggle")
.accessibilityValue(notificationsEnabled ? "Enabled" : "Disabled")
.accessibilityHint("Double tap to toggle notifications")
```

### Form Accessibility

```swift
VStack(spacing: AppSpacing.md) {
    // Form fields
}
.accessibilityElement(children: .contain)
.accessibilityLabel("User registration form")
```

---

## 🎯 Usage Examples

### Registration Form

```swift
struct RegistrationForm: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var acceptTerms = false
    
    @State private var errors: [String: String] = [:]
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Header
            VStack(spacing: AppSpacing.md) {
                Text("Create Account")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Fill out the form below to create your account")
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            // Form
            VStack(spacing: AppSpacing.md) {
                // Name fields
                HStack(spacing: AppSpacing.md) {
                    DesignSystemTextField(
                        text: $firstName,
                        placeholder: "First Name",
                        icon: "person",
                        textContentType: .givenName,
                        validation: .required,
                        errorMessage: errors["firstName"]
                    )
                    
                    DesignSystemTextField(
                        text: $lastName,
                        placeholder: "Last Name",
                        icon: "person",
                        textContentType: .familyName,
                        validation: .required,
                        errorMessage: errors["lastName"]
                    )
                }
                
                // Email field
                DesignSystemTextField(
                    text: $email,
                    placeholder: "Email Address",
                    icon: "envelope",
                    keyboardType: .emailAddress,
                    textContentType: .emailAddress,
                    validation: .email,
                    errorMessage: errors["email"]
                )
                
                // Password fields
                DesignSystemTextField(
                    text: $password,
                    placeholder: "Password",
                    icon: "lock",
                    isSecure: true,
                    textContentType: .newPassword,
                    validation: .minLength(8),
                    errorMessage: errors["password"]
                )
                
                DesignSystemTextField(
                    text: $confirmPassword,
                    placeholder: "Confirm Password",
                    icon: "lock",
                    isSecure: true,
                    textContentType: .newPassword,
                    validation: .custom { text in
                        return text == password
                    },
                    errorMessage: errors["confirmPassword"]
                )
                
                // Terms toggle
                DesignSystemToggle(
                    isOn: $acceptTerms,
                    title: "I accept the Terms and Conditions",
                    subtitle: "You must accept the terms to continue"
                )
                
                // Submit button
                PrimaryButton(
                    title: "Create Account",
                    isLoading: isLoading
                ) {
                    submitForm()
                }
                .disabled(!acceptTerms)
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
    
    private func submitForm() {
        isLoading = true
        errors.removeAll()
        
        // Validate form
        if firstName.isEmpty {
            errors["firstName"] = "First name is required"
        }
        
        if lastName.isEmpty {
            errors["lastName"] = "Last name is required"
        }
        
        if !email.contains("@") {
            errors["email"] = "Please enter a valid email"
        }
        
        if password.count < 8 {
            errors["password"] = "Password must be at least 8 characters"
        }
        
        if password != confirmPassword {
            errors["confirmPassword"] = "Passwords do not match"
        }
        
        if !acceptTerms {
            return
        }
        
        // Submit if no errors
        if errors.isEmpty {
            // Submit form logic
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
                // Handle success
            }
        } else {
            isLoading = false
        }
    }
}
```

### Settings Form

```swift
struct SettingsForm: View {
    @State private var notificationsEnabled = true
    @State private var emailNotifications = true
    @State private var pushNotifications = false
    @State private var selectedLanguage = "en"
    @State private var selectedTheme = "system"
    @State private var autoSave = true
    @State private var syncInterval = 15.0
    
    let languages = [
        PickerOption(title: "English", value: "en"),
        PickerOption(title: "Spanish", value: "es"),
        PickerOption(title: "French", value: "fr"),
        PickerOption(title: "German", value: "de")
    ]
    
    let themes = [
        PickerOption(title: "System", value: "system"),
        PickerOption(title: "Light", value: "light"),
        PickerOption(title: "Dark", value: "dark")
    ]
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            // Header
            VStack(spacing: AppSpacing.md) {
                Text("Settings")
                    .font(AppTypography.headlineLarge)
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Customize your app experience")
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
            }
            
            // Form
            VStack(spacing: AppSpacing.lg) {
                // Notifications Section
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    Text("Notifications")
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                    
                    VStack(spacing: AppSpacing.sm) {
                        DesignSystemToggle(
                            isOn: $notificationsEnabled,
                            title: "Enable Notifications",
                            subtitle: "Receive notifications for important updates"
                        )
                        
                        if notificationsEnabled {
                            DesignSystemToggle(
                                isOn: $emailNotifications,
                                title: "Email Notifications",
                                subtitle: "Receive notifications via email"
                            )
                            
                            DesignSystemToggle(
                                isOn: $pushNotifications,
                                title: "Push Notifications",
                                subtitle: "Receive push notifications on your device"
                            )
                        }
                    }
                }
                
                // Preferences Section
                VStack(alignment: .leading, spacing: AppSpacing.md) {
                    Text("Preferences")
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                    
                    VStack(spacing: AppSpacing.md) {
                        DesignSystemPicker(
                            selection: $selectedLanguage,
                            title: "Language",
                            options: languages,
                            icon: "globe"
                        )
                        
                        DesignSystemPicker(
                            selection: $selectedTheme,
                            title: "Theme",
                            options: themes,
                            icon: "paintbrush"
                        )
                        
                        DesignSystemToggle(
                            isOn: $autoSave,
                            title: "Auto Save",
                            subtitle: "Automatically save your work"
                        )
                        
                        DesignSystemSlider(
                            value: $syncInterval,
                            range: 5...60,
                            title: "Sync Interval",
                            subtitle: "Sync data every \(Int(syncInterval)) minutes",
                            step: 5
                        )
                    }
                }
                
                // Save Button
                PrimaryButton(title: "Save Settings") {
                    saveSettings()
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
    
    private func saveSettings() {
        // Save settings logic
    }
}
```

### Contact Form

```swift
struct ContactForm: View {
    @State private var name = ""
    @State private var email = ""
    @State private var subject = ""
    @State private var message = ""
    @State private var priority = "normal"
    @State private var includeScreenshot = false
    
    @State private var errors: [String: String] = [:]
    @State private var isLoading = false
    @State private var showSuccess = false
    
    let priorities = [
        PickerOption(title: "Low", value: "low"),
        PickerOption(title: "Normal", value: "normal"),
        PickerOption(title: "High", value: "high"),
        PickerOption(title: "Urgent", value: "urgent")
    ]
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            if showSuccess {
                // Success view
                VStack(spacing: AppSpacing.md) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(AppColors.success)
                        .font(.system(size: 60))
                    
                    Text("Message Sent!")
                        .font(AppTypography.headlineLarge)
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("We'll get back to you as soon as possible.")
                        .font(AppTypography.bodyMedium)
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                    
                    SecondaryButton(title: "Send Another") {
                        resetForm()
                    }
                }
            } else {
                // Form
                VStack(spacing: AppSpacing.lg) {
                    // Header
                    VStack(spacing: AppSpacing.md) {
                        Text("Contact Us")
                            .font(AppTypography.headlineLarge)
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("We'd love to hear from you")
                            .font(AppTypography.bodyMedium)
                            .foregroundColor(AppColors.textSecondary)
                    }
                    
                    // Form fields
                    VStack(spacing: AppSpacing.md) {
                        DesignSystemTextField(
                            text: $name,
                            placeholder: "Your Name",
                            icon: "person",
                            textContentType: .name,
                            validation: .required,
                            errorMessage: errors["name"]
                        )
                        
                        DesignSystemTextField(
                            text: $email,
                            placeholder: "Your Email",
                            icon: "envelope",
                            keyboardType: .emailAddress,
                            textContentType: .emailAddress,
                            validation: .email,
                            errorMessage: errors["email"]
                        )
                        
                        DesignSystemTextField(
                            text: $subject,
                            placeholder: "Subject",
                            icon: "text.bubble",
                            validation: .required,
                            errorMessage: errors["subject"]
                        )
                        
                        DesignSystemPicker(
                            selection: $priority,
                            title: "Priority",
                            options: priorities,
                            icon: "flag"
                        )
                        
                        DesignSystemTextArea(
                            text: $message,
                            placeholder: "Your message...",
                            maxLength: 1000,
                            minHeight: 150,
                            validation: .required,
                            errorMessage: errors["message"]
                        )
                        
                        DesignSystemToggle(
                            isOn: $includeScreenshot,
                            title: "Include Screenshot",
                            subtitle: "Automatically attach a screenshot of the current screen"
                        )
                        
                        PrimaryButton(
                            title: "Send Message",
                            isLoading: isLoading
                        ) {
                            submitForm()
                        }
                    }
                }
            }
        }
        .padding(AppSpacing.lg)
        .background(AppColors.background)
    }
    
    private func submitForm() {
        isLoading = true
        errors.removeAll()
        
        // Validate form
        if name.isEmpty {
            errors["name"] = "Name is required"
        }
        
        if !email.contains("@") {
            errors["email"] = "Please enter a valid email"
        }
        
        if subject.isEmpty {
            errors["subject"] = "Subject is required"
        }
        
        if message.isEmpty {
            errors["message"] = "Message is required"
        }
        
        // Submit if no errors
        if errors.isEmpty {
            // Submit form logic
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
                showSuccess = true
            }
        } else {
            isLoading = false
        }
    }
    
    private func resetForm() {
        name = ""
        email = ""
        subject = ""
        message = ""
        priority = "normal"
        includeScreenshot = false
        errors.removeAll()
        showSuccess = false
    }
}
```

---

Bu API dokümantasyonu, SwiftUI Design System Pro'nun tüm form bileşenlerini kapsamlı bir şekilde açıklamaktadır. Her form bileşeninin nasıl kullanılacağı, doğrulama seçenekleri ve pratik örnekler dahil edilmiştir.

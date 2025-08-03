import XCTest
import SwiftUI
@testable import DesignSystemPro

class DSTextFieldTests: XCTestCase {
    
    func testTextFieldCreation() {
        // Given
        @State var text = ""
        
        // When
        let textField = DSTextField(
            placeholder: "Enter text",
            text: $text
        )
        
        // Then
        XCTAssertNotNil(textField)
    }
    
    func testTextFieldWithValidation() {
        // Given
        @State var email = ""
        
        // When
        let textField = DSTextField(
            placeholder: "Enter email",
            text: $email,
            validation: .email
        )
        
        // Then
        XCTAssertNotNil(textField)
    }
    
    func testTextFieldStyles() {
        // Given
        @State var text = ""
        let styles: [DSTextFieldStyle] = [.primary, .secondary]
        
        // When & Then
        for style in styles {
            let textField = DSTextField(
                placeholder: "Test",
                text: $text,
                style: style
            )
            XCTAssertNotNil(textField)
        }
    }
    
    func testTextFieldSizes() {
        // Given
        @State var text = ""
        let sizes: [DSTextFieldSize] = [.small, .medium, .large]
        
        // When & Then
        for size in sizes {
            let textField = DSTextField(
                placeholder: "Test",
                text: $text,
                size: size
            )
            XCTAssertNotNil(textField)
        }
    }
    
    func testSecureTextField() {
        // Given
        @State var password = ""
        
        // When
        let textField = DSTextField(
            placeholder: "Enter password",
            text: $password,
            isSecure: true
        )
        
        // Then
        XCTAssertNotNil(textField)
    }
    
    func testTextFieldWithKeyboardType() {
        // Given
        @State var phone = ""
        
        // When
        let textField = DSTextField(
            placeholder: "Enter phone",
            text: $phone,
            keyboardType: .phonePad
        )
        
        // Then
        XCTAssertNotNil(textField)
    }
    
    func testTextFieldWithOnCommit() {
        // Given
        @State var text = ""
        var commitCalled = false
        
        // When
        let textField = DSTextField(
            placeholder: "Test",
            text: $text,
            onCommit: { commitCalled = true }
        )
        
        // Then
        XCTAssertNotNil(textField)
    }
    
    func testTextFieldWithOnEditingChanged() {
        // Given
        @State var text = ""
        var editingChanged = false
        
        // When
        let textField = DSTextField(
            placeholder: "Test",
            text: $text,
            onEditingChanged: { _ in editingChanged = true }
        )
        
        // Then
        XCTAssertNotNil(textField)
    }
    
    func testEmailValidation() {
        // Given
        let validation = DSValidationType.email
        
        // When & Then
        let validEmail = "test@example.com"
        let result1 = validation.validate(validEmail)
        XCTAssertTrue(result1.isValid)
        XCTAssertEqual(result1.errorMessage, "")
        
        let invalidEmail = "invalid-email"
        let result2 = validation.validate(invalidEmail)
        XCTAssertFalse(result2.isValid)
        XCTAssertEqual(result2.errorMessage, "Please enter a valid email address")
    }
    
    func testPhoneValidation() {
        // Given
        let validation = DSValidationType.phone
        
        // When & Then
        let validPhone = "+1234567890"
        let result1 = validation.validate(validPhone)
        XCTAssertTrue(result1.isValid)
        XCTAssertEqual(result1.errorMessage, "")
        
        let invalidPhone = "abc"
        let result2 = validation.validate(invalidPhone)
        XCTAssertFalse(result2.isValid)
        XCTAssertEqual(result2.errorMessage, "Please enter a valid phone number")
    }
    
    func testPasswordValidation() {
        // Given
        let validation = DSValidationType.password
        
        // When & Then
        let validPassword = "Password123"
        let result1 = validation.validate(validPassword)
        XCTAssertTrue(result1.isValid)
        XCTAssertEqual(result1.errorMessage, "")
        
        let invalidPassword = "weak"
        let result2 = validation.validate(invalidPassword)
        XCTAssertFalse(result2.isValid)
        XCTAssertTrue(result2.errorMessage.contains("Password must be at least 8 characters"))
    }
    
    func testCustomValidation() {
        // Given
        let validation = DSValidationType.custom { text in
            return DSValidationResult(
                isValid: text.count >= 5,
                errorMessage: text.count >= 5 ? "" : "Must be at least 5 characters"
            )
        }
        
        // When & Then
        let validText = "12345"
        let result1 = validation.validate(validText)
        XCTAssertTrue(result1.isValid)
        XCTAssertEqual(result1.errorMessage, "")
        
        let invalidText = "123"
        let result2 = validation.validate(invalidText)
        XCTAssertFalse(result2.isValid)
        XCTAssertEqual(result2.errorMessage, "Must be at least 5 characters")
    }
    
    func testTextFieldStyleProperties() {
        // Given
        let primaryStyle = DSTextFieldStyle.primary
        let secondaryStyle = DSTextFieldStyle.secondary
        
        // When & Then
        XCTAssertEqual(primaryStyle.cornerRadius, 8)
        XCTAssertEqual(secondaryStyle.cornerRadius, 12)
        XCTAssertEqual(primaryStyle.borderColor, Color(.systemGray4))
        XCTAssertEqual(secondaryStyle.borderColor, Color(.systemGray3))
    }
    
    func testTextFieldSizeProperties() {
        // Given
        let smallSize = DSTextFieldSize.small
        let mediumSize = DSTextFieldSize.medium
        let largeSize = DSTextFieldSize.large
        
        // When & Then
        XCTAssertEqual(smallSize.height, 36)
        XCTAssertEqual(mediumSize.height, 44)
        XCTAssertEqual(largeSize.height, 52)
    }
    
    func testUIReturnKeyTypeExtension() {
        // Given & When & Then
        XCTAssertEqual(UIReturnKeyType.done.submitLabel, .done)
        XCTAssertEqual(UIReturnKeyType.go.submitLabel, .go)
        XCTAssertEqual(UIReturnKeyType.next.submitLabel, .next)
        XCTAssertEqual(UIReturnKeyType.search.submitLabel, .search)
        XCTAssertEqual(UIReturnKeyType.send.submitLabel, .send)
        XCTAssertEqual(UIReturnKeyType.join.submitLabel, .join)
        XCTAssertEqual(UIReturnKeyType.route.submitLabel, .route)
        XCTAssertEqual(UIReturnKeyType.emergencyCall.submitLabel, .emergencyCall)
        XCTAssertEqual(UIReturnKeyType.continue.submitLabel, .continue)
        XCTAssertEqual(UIReturnKeyType.default.submitLabel, .done)
    }
} 
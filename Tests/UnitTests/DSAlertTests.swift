import XCTest
import SwiftUI
@testable import DesignSystemPro

class DSAlertTests: XCTestCase {
    
    func testAlertCreation() {
        // Given
        @State var isPresented = false
        let primaryButton = DSAlertButton(title: "OK")
        
        // When
        let alert = DSAlert(
            isPresented: $isPresented,
            title: "Test Alert",
            message: "This is a test alert",
            primaryButton: primaryButton
        )
        
        // Then
        XCTAssertNotNil(alert)
    }
    
    func testAlertWithSecondaryButton() {
        // Given
        @State var isPresented = false
        let primaryButton = DSAlertButton(title: "OK")
        let secondaryButton = DSAlertButton(title: "Cancel", style: .secondary)
        
        // When
        let alert = DSAlert(
            isPresented: $isPresented,
            title: "Test Alert",
            message: "This is a test alert",
            primaryButton: primaryButton,
            secondaryButton: secondaryButton
        )
        
        // Then
        XCTAssertNotNil(alert)
    }
    
    func testAlertStyles() {
        // Given
        @State var isPresented = false
        let primaryButton = DSAlertButton(title: "OK")
        let styles: [DSAlertStyle] = [.default, .success, .error, .warning]
        
        // When & Then
        for style in styles {
            let alert = DSAlert(
                isPresented: $isPresented,
                title: "Test Alert",
                message: "Test message",
                primaryButton: primaryButton,
                style: style
            )
            XCTAssertNotNil(alert)
        }
    }
    
    func testAlertButtonCreation() {
        // Given
        var actionCalled = false
        
        // When
        let button = DSAlertButton(
            title: "Test Button",
            style: .primary
        ) {
            actionCalled = true
        }
        
        // Then
        XCTAssertEqual(button.title, "Test Button")
        XCTAssertEqual(button.style, .primary)
        XCTAssertNotNil(button.action)
    }
    
    func testAlertButtonStyles() {
        // Given
        let styles: [DSButtonStyle] = [.primary, .secondary, .tertiary, .destructive]
        
        // When & Then
        for style in styles {
            let button = DSAlertButton(
                title: "Test",
                style: style
            )
            XCTAssertEqual(button.style, style)
        }
    }
    
    func testAlertStyleProperties() {
        // Given
        let defaultStyle = DSAlertStyle.default
        let successStyle = DSAlertStyle.success
        let errorStyle = DSAlertStyle.error
        let warningStyle = DSAlertStyle.warning
        
        // When & Then
        XCTAssertEqual(defaultStyle.maxWidth, 320)
        XCTAssertEqual(successStyle.maxWidth, 320)
        XCTAssertEqual(errorStyle.maxWidth, 320)
        XCTAssertEqual(warningStyle.maxWidth, 320)
        
        XCTAssertEqual(defaultStyle.cornerRadius, 16)
        XCTAssertEqual(successStyle.cornerRadius, 16)
        XCTAssertEqual(errorStyle.cornerRadius, 16)
        XCTAssertEqual(warningStyle.cornerRadius, 16)
        
        XCTAssertEqual(defaultStyle.titleColor, .primary)
        XCTAssertEqual(successStyle.titleColor, .primary)
        XCTAssertEqual(errorStyle.titleColor, .primary)
        XCTAssertEqual(warningStyle.titleColor, .primary)
        
        XCTAssertEqual(defaultStyle.messageColor, Color(.systemGray))
        XCTAssertEqual(successStyle.messageColor, Color(.systemGray))
        XCTAssertEqual(errorStyle.messageColor, Color(.systemGray))
        XCTAssertEqual(warningStyle.messageColor, Color(.systemGray))
    }
    
    func testAlertStyleIcons() {
        // Given
        let defaultStyle = DSAlertStyle.default
        let successStyle = DSAlertStyle.success
        let errorStyle = DSAlertStyle.error
        let warningStyle = DSAlertStyle.warning
        
        // When & Then
        XCTAssertNil(defaultStyle.icon)
        XCTAssertEqual(successStyle.icon, "checkmark.circle.fill")
        XCTAssertEqual(errorStyle.icon, "exclamationmark.triangle.fill")
        XCTAssertEqual(warningStyle.icon, "exclamationmark.triangle.fill")
    }
    
    func testAlertStyleColors() {
        // Given
        let defaultStyle = DSAlertStyle.default
        let successStyle = DSAlertStyle.success
        let errorStyle = DSAlertStyle.error
        let warningStyle = DSAlertStyle.warning
        
        // When & Then
        XCTAssertEqual(defaultStyle.iconColor, .blue)
        XCTAssertEqual(successStyle.iconColor, .green)
        XCTAssertEqual(errorStyle.iconColor, .red)
        XCTAssertEqual(warningStyle.iconColor, .orange)
    }
    
    func testAlertStyleDismissOnBackdropTap() {
        // Given
        let defaultStyle = DSAlertStyle.default
        let successStyle = DSAlertStyle.success
        let errorStyle = DSAlertStyle.error
        let warningStyle = DSAlertStyle.warning
        
        // When & Then
        XCTAssertTrue(defaultStyle.dismissOnBackdropTap)
        XCTAssertTrue(successStyle.dismissOnBackdropTap)
        XCTAssertTrue(errorStyle.dismissOnBackdropTap)
        XCTAssertTrue(warningStyle.dismissOnBackdropTap)
    }
    
    func testAlertStyleTransitions() {
        // Given
        let defaultStyle = DSAlertStyle.default
        let successStyle = DSAlertStyle.success
        let errorStyle = DSAlertStyle.error
        let warningStyle = DSAlertStyle.warning
        
        // When & Then
        XCTAssertNotNil(defaultStyle.transition)
        XCTAssertNotNil(successStyle.transition)
        XCTAssertNotNil(errorStyle.transition)
        XCTAssertNotNil(warningStyle.transition)
    }
    
    func testAlertStyleAnimations() {
        // Given
        let defaultStyle = DSAlertStyle.default
        let successStyle = DSAlertStyle.success
        let errorStyle = DSAlertStyle.error
        let warningStyle = DSAlertStyle.warning
        
        // When & Then
        XCTAssertNotNil(defaultStyle.animation)
        XCTAssertNotNil(successStyle.animation)
        XCTAssertNotNil(errorStyle.animation)
        XCTAssertNotNil(warningStyle.animation)
    }
    
    func testAlertStyleBackgroundColors() {
        // Given
        let defaultStyle = DSAlertStyle.default
        
        // When & Then
        XCTAssertNotNil(defaultStyle.backgroundColor(.light))
        XCTAssertNotNil(defaultStyle.backgroundColor(.dark))
    }
} 
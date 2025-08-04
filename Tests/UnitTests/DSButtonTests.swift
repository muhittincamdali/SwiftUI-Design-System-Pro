import XCTest
import SwiftUI
@testable import DesignSystemPro

/**
 * DSButton Unit Tests
 * 
 * Comprehensive unit tests for the DSButton component
 * covering all styles, sizes, and functionality.
 */
final class DSButtonTests: XCTestCase {
    
    // MARK: - Button Creation Tests
    
    func testButtonCreation() {
        // Given
        let title = "Test Button"
        var buttonTapped = false
        
        // When
        let button = DSButton(
            title: title,
            style: .primary,
            size: .medium
        ) {
            buttonTapped = true
        }
        
        // Then
        XCTAssertNotNil(button)
        XCTAssertEqual(button.title, title)
        XCTAssertEqual(button.style, .primary)
        XCTAssertEqual(button.size, .medium)
    }
    
    func testButtonWithDefaultValues() {
        // Given
        let title = "Default Button"
        
        // When
        let button = DSButton(title: title) {
            // Action
        }
        
        // Then
        XCTAssertEqual(button.title, title)
        XCTAssertEqual(button.style, .primary) // Default style
        XCTAssertEqual(button.size, .medium) // Default size
    }
    
    // MARK: - Button Styles Tests
    
    func testPrimaryButtonStyle() {
        // Given
        let button = DSButton(
            title: "Primary",
            style: .primary
        ) {
            // Action
        }
        
        // When
        let backgroundColor = button.style.backgroundColor(for: .light)
        let textColor = button.style.textColor(for: .light)
        let borderWidth = button.style.borderWidth
        
        // Then
        XCTAssertEqual(backgroundColor, .blue)
        XCTAssertEqual(textColor, .white)
        XCTAssertEqual(borderWidth, 0)
    }
    
    func testSecondaryButtonStyle() {
        // Given
        let button = DSButton(
            title: "Secondary",
            style: .secondary
        ) {
            // Action
        }
        
        // When
        let backgroundColor = button.style.backgroundColor(for: .light)
        let textColor = button.style.textColor(for: .light)
        let borderWidth = button.style.borderWidth
        
        // Then
        XCTAssertEqual(backgroundColor, Color(.systemGray6))
        XCTAssertEqual(textColor, .black)
        XCTAssertEqual(borderWidth, 1)
    }
    
    func testTertiaryButtonStyle() {
        // Given
        let button = DSButton(
            title: "Tertiary",
            style: .tertiary
        ) {
            // Action
        }
        
        // When
        let backgroundColor = button.style.backgroundColor(for: .light)
        let textColor = button.style.textColor(for: .light)
        let borderWidth = button.style.borderWidth
        
        // Then
        XCTAssertEqual(backgroundColor, .clear)
        XCTAssertEqual(textColor, .blue)
        XCTAssertEqual(borderWidth, 1)
    }
    
    func testDestructiveButtonStyle() {
        // Given
        let button = DSButton(
            title: "Destructive",
            style: .destructive
        ) {
            // Action
        }
        
        // When
        let backgroundColor = button.style.backgroundColor(for: .light)
        let textColor = button.style.textColor(for: .light)
        let borderWidth = button.style.borderWidth
        
        // Then
        XCTAssertEqual(backgroundColor, .red)
        XCTAssertEqual(textColor, .white)
        XCTAssertEqual(borderWidth, 0)
    }
    
    // MARK: - Button Sizes Tests
    
    func testSmallButtonSize() {
        // Given
        let button = DSButton(
            title: "Small",
            size: .small
        ) {
            // Action
        }
        
        // When
        let height = button.size.height
        let cornerRadius = button.size.cornerRadius
        let font = button.size.font
        let fontWeight = button.size.fontWeight
        
        // Then
        XCTAssertEqual(height, 32)
        XCTAssertEqual(cornerRadius, 6)
        XCTAssertEqual(font, .caption)
        XCTAssertEqual(fontWeight, .medium)
    }
    
    func testMediumButtonSize() {
        // Given
        let button = DSButton(
            title: "Medium",
            size: .medium
        ) {
            // Action
        }
        
        // When
        let height = button.size.height
        let cornerRadius = button.size.cornerRadius
        let font = button.size.font
        let fontWeight = button.size.fontWeight
        
        // Then
        XCTAssertEqual(height, 44)
        XCTAssertEqual(cornerRadius, 8)
        XCTAssertEqual(font, .body)
        XCTAssertEqual(fontWeight, .semibold)
    }
    
    func testLargeButtonSize() {
        // Given
        let button = DSButton(
            title: "Large",
            size: .large
        ) {
            // Action
        }
        
        // When
        let height = button.size.height
        let cornerRadius = button.size.cornerRadius
        let font = button.size.font
        let fontWeight = button.size.fontWeight
        
        // Then
        XCTAssertEqual(height, 56)
        XCTAssertEqual(cornerRadius, 12)
        XCTAssertEqual(font, .title3)
        XCTAssertEqual(fontWeight, .bold)
    }
    
    // MARK: - Dark Mode Tests
    
    func testButtonColorsInDarkMode() {
        // Given
        let button = DSButton(
            title: "Dark Mode",
            style: .secondary
        ) {
            // Action
        }
        
        // When
        let backgroundColor = button.style.backgroundColor(for: .dark)
        let textColor = button.style.textColor(for: .dark)
        let borderColor = button.style.borderColor(for: .dark)
        
        // Then
        XCTAssertEqual(backgroundColor, Color(.systemGray5))
        XCTAssertEqual(textColor, .white)
        XCTAssertEqual(borderColor, Color(.systemGray4))
    }
    
    func testButtonColorsInLightMode() {
        // Given
        let button = DSButton(
            title: "Light Mode",
            style: .secondary
        ) {
            // Action
        }
        
        // When
        let backgroundColor = button.style.backgroundColor(for: .light)
        let textColor = button.style.textColor(for: .light)
        let borderColor = button.style.borderColor(for: .light)
        
        // Then
        XCTAssertEqual(backgroundColor, Color(.systemGray6))
        XCTAssertEqual(textColor, .black)
        XCTAssertEqual(borderColor, Color(.systemGray3))
    }
    
    // MARK: - Accessibility Tests
    
    func testButtonAccessibilityLabel() {
        // Given
        let title = "Accessible Button"
        let button = DSButton(title: title) {
            // Action
        }
        
        // When
        let accessibilityLabel = button.body.accessibilityLabel
        
        // Then
        XCTAssertEqual(accessibilityLabel, title)
    }
    
    func testButtonAccessibilityHint() {
        // Given
        let button = DSButton(title: "Test") {
            // Action
        }
        
        // When
        let accessibilityHint = button.body.accessibilityHint
        
        // Then
        XCTAssertEqual(accessibilityHint, "Double tap to activate")
    }
    
    // MARK: - Performance Tests
    
    func testButtonCreationPerformance() {
        measure {
            for _ in 0..<1000 {
                _ = DSButton(title: "Performance Test") {
                    // Action
                }
            }
        }
    }
    
    func testButtonRenderingPerformance() {
        let button = DSButton(title: "Performance Test") {
            // Action
        }
        
        measure {
            for _ in 0..<100 {
                _ = button.body
            }
        }
    }
}

// MARK: - Mock Button for Testing
class MockDSButton {
    let title: String
    let style: DSButtonStyle
    let size: DSButtonSize
    let action: () -> Void
    
    init(
        title: String,
        style: DSButtonStyle = .primary,
        size: DSButtonSize = .medium,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.size = size
        self.action = action
    }
    
    func tap() {
        action()
    }
} 
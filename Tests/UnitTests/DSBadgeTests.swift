import XCTest
import SwiftUI
@testable import DesignSystemPro

class DSBadgeTests: XCTestCase {
    
    func testBadgeCreationWithText() {
        // Given
        let text = "New"
        
        // When
        let badge = DSBadge(text: text)
        
        // Then
        XCTAssertNotNil(badge)
    }
    
    func testBadgeCreationWithNumber() {
        // Given
        let number = 5
        
        // When
        let badge = DSBadge(number: number)
        
        // Then
        XCTAssertNotNil(badge)
    }
    
    func testBadgeCreationWithDot() {
        // Given
        let showDot = true
        
        // When
        let badge = DSBadge(showDot: showDot)
        
        // Then
        XCTAssertNotNil(badge)
    }
    
    func testBadgeStyles() {
        // Given
        let text = "Test"
        let styles: [DSBadgeStyle] = [.primary, .secondary, .success, .warning, .error, .info]
        
        // When & Then
        for style in styles {
            let badge = DSBadge(
                text: text,
                style: style
            )
            XCTAssertNotNil(badge)
        }
    }
    
    func testBadgeSizes() {
        // Given
        let text = "Test"
        let sizes: [DSBadgeSize] = [.small, .medium, .large]
        
        // When & Then
        for size in sizes {
            let badge = DSBadge(
                text: text,
                size: size
            )
            XCTAssertNotNil(badge)
        }
    }
    
    func testBadgeStyleProperties() {
        // Given
        let primaryStyle = DSBadgeStyle.primary
        let secondaryStyle = DSBadgeStyle.secondary
        let successStyle = DSBadgeStyle.success
        let warningStyle = DSBadgeStyle.warning
        let errorStyle = DSBadgeStyle.error
        let infoStyle = DSBadgeStyle.info
        
        // When & Then
        XCTAssertEqual(primaryStyle.backgroundColor, .blue)
        XCTAssertEqual(secondaryStyle.backgroundColor, Color(.systemGray4))
        XCTAssertEqual(successStyle.backgroundColor, .green)
        XCTAssertEqual(warningStyle.backgroundColor, .orange)
        XCTAssertEqual(errorStyle.backgroundColor, .red)
        XCTAssertEqual(infoStyle.backgroundColor, .cyan)
        
        XCTAssertEqual(primaryStyle.textColor, .white)
        XCTAssertEqual(secondaryStyle.textColor, .primary)
        XCTAssertEqual(successStyle.textColor, .white)
        XCTAssertEqual(warningStyle.textColor, .white)
        XCTAssertEqual(errorStyle.textColor, .white)
        XCTAssertEqual(infoStyle.textColor, .white)
        
        XCTAssertEqual(primaryStyle.borderColor, .clear)
        XCTAssertEqual(secondaryStyle.borderColor, Color(.systemGray3))
        XCTAssertEqual(successStyle.borderColor, .clear)
        XCTAssertEqual(warningStyle.borderColor, .clear)
        XCTAssertEqual(errorStyle.borderColor, .clear)
        XCTAssertEqual(infoStyle.borderColor, .clear)
        
        XCTAssertEqual(primaryStyle.borderWidth, 0)
        XCTAssertEqual(secondaryStyle.borderWidth, 1)
        XCTAssertEqual(successStyle.borderWidth, 0)
        XCTAssertEqual(warningStyle.borderWidth, 0)
        XCTAssertEqual(errorStyle.borderWidth, 0)
        XCTAssertEqual(infoStyle.borderWidth, 0)
    }
    
    func testBadgeSizeProperties() {
        // Given
        let smallSize = DSBadgeSize.small
        let mediumSize = DSBadgeSize.medium
        let largeSize = DSBadgeSize.large
        
        // When & Then
        XCTAssertEqual(smallSize.font, .caption2)
        XCTAssertEqual(mediumSize.font, .caption)
        XCTAssertEqual(largeSize.font, .footnote)
        
        XCTAssertEqual(smallSize.fontWeight, .medium)
        XCTAssertEqual(mediumSize.fontWeight, .semibold)
        XCTAssertEqual(largeSize.fontWeight, .bold)
        
        XCTAssertEqual(smallSize.horizontalPadding, 6)
        XCTAssertEqual(mediumSize.horizontalPadding, 8)
        XCTAssertEqual(largeSize.horizontalPadding, 12)
        
        XCTAssertEqual(smallSize.verticalPadding, 2)
        XCTAssertEqual(mediumSize.verticalPadding, 4)
        XCTAssertEqual(largeSize.verticalPadding, 6)
        
        XCTAssertEqual(smallSize.cornerRadius, 8)
        XCTAssertEqual(mediumSize.cornerRadius, 10)
        XCTAssertEqual(largeSize.cornerRadius, 12)
        
        XCTAssertEqual(smallSize.dotSize, 6)
        XCTAssertEqual(mediumSize.dotSize, 8)
        XCTAssertEqual(largeSize.dotSize, 10)
    }
    
    func testCustomBadgeStyle() {
        // Given
        let customConfig = DSBadgeStyleConfiguration(
            backgroundColor: .purple,
            textColor: .white,
            borderColor: .purple,
            borderWidth: 2
        )
        
        // When
        let customStyle = DSBadgeStyle.custom(customConfig)
        
        // Then
        XCTAssertEqual(customStyle.backgroundColor, .purple)
        XCTAssertEqual(customStyle.textColor, .white)
        XCTAssertEqual(customStyle.borderColor, .purple)
        XCTAssertEqual(customStyle.borderWidth, 2)
    }
    
    func testBadgeStyleConfiguration() {
        // Given
        let backgroundColor = Color.red
        let textColor = Color.white
        let borderColor = Color.blue
        let borderWidth: CGFloat = 3
        
        // When
        let config = DSBadgeStyleConfiguration(
            backgroundColor: backgroundColor,
            textColor: textColor,
            borderColor: borderColor,
            borderWidth: borderWidth
        )
        
        // Then
        XCTAssertEqual(config.backgroundColor, backgroundColor)
        XCTAssertEqual(config.textColor, textColor)
        XCTAssertEqual(config.borderColor, borderColor)
        XCTAssertEqual(config.borderWidth, borderWidth)
    }
    
    func testBadgeStyleConfigurationWithDefaults() {
        // Given
        let backgroundColor = Color.green
        let textColor = Color.black
        
        // When
        let config = DSBadgeStyleConfiguration(
            backgroundColor: backgroundColor,
            textColor: textColor
        )
        
        // Then
        XCTAssertEqual(config.backgroundColor, backgroundColor)
        XCTAssertEqual(config.textColor, textColor)
        XCTAssertEqual(config.borderColor, .clear)
        XCTAssertEqual(config.borderWidth, 0)
    }
} 
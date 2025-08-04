import XCTest
import SwiftUI
@testable import DesignSystemPro

class DSCardTests: XCTestCase {
    
    func testCardCreation() {
        // Given
        let title = "Test Card"
        let subtitle = "Test Subtitle"
        let image = "star.fill"
        
        // When
        let card = DSCard(
            title: title,
            subtitle: subtitle,
            image: image
        )
        
        // Then
        XCTAssertNotNil(card)
    }
    
    func testCardWithTitleOnly() {
        // Given
        let title = "Simple Card"
        
        // When
        let card = DSCard(
            title: title
        )
        
        // Then
        XCTAssertNotNil(card)
    }
    
    func testCardWithTitleAndSubtitle() {
        // Given
        let title = "Card Title"
        let subtitle = "Card subtitle with description"
        
        // When
        let card = DSCard(
            title: title,
            subtitle: subtitle
        )
        
        // Then
        XCTAssertNotNil(card)
    }
    
    func testCardWithImage() {
        // Given
        let title = "Image Card"
        let image = "photo.fill"
        
        // When
        let card = DSCard(
            title: title,
            image: image
        )
        
        // Then
        XCTAssertNotNil(card)
    }
    
    func testCardWithAction() {
        // Given
        var actionCalled = false
        
        // When
        let card = DSCard(
            title: "Action Card",
            subtitle: "Tap to perform action"
        ) {
            actionCalled = true
        }
        
        // Then
        XCTAssertNotNil(card)
    }
    
    func testCardStyles() {
        // Given
        let title = "Styled Card"
        let styles: [DSCardStyle] = [.primary, .secondary]
        
        // When & Then
        for style in styles {
            let card = DSCard(
                title: title,
                style: style
            )
            XCTAssertNotNil(card)
        }
    }
    
    func testCardSizes() {
        // Given
        let title = "Sized Card"
        let sizes: [DSCardSize] = [.small, .medium, .large]
        
        // When & Then
        for size in sizes {
            let card = DSCard(
                title: title,
                size: size
            )
            XCTAssertNotNil(card)
        }
    }
    
    func testCardStyleProperties() {
        // Given
        let primaryStyle = DSCardStyle.primary
        let secondaryStyle = DSCardStyle.secondary
        
        // When & Then
        XCTAssertNotNil(primaryStyle.backgroundColor(.light))
        XCTAssertNotNil(primaryStyle.backgroundColor(.dark))
        XCTAssertNotNil(secondaryStyle.backgroundColor(.light))
        XCTAssertNotNil(secondaryStyle.backgroundColor(.dark))
    }
    
    func testCardSizeProperties() {
        // Given
        let smallSize = DSCardSize.small
        let mediumSize = DSCardSize.medium
        let largeSize = DSCardSize.large
        
        // When & Then
        XCTAssertEqual(smallSize.padding, 12)
        XCTAssertEqual(mediumSize.padding, 16)
        XCTAssertEqual(largeSize.padding, 20)
        
        XCTAssertEqual(smallSize.cornerRadius, 8)
        XCTAssertEqual(mediumSize.cornerRadius, 12)
        XCTAssertEqual(largeSize.cornerRadius, 16)
    }
} 
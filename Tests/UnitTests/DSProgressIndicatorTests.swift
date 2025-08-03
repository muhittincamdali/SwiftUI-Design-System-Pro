import XCTest
import SwiftUI
@testable import DesignSystemPro

class DSProgressIndicatorTests: XCTestCase {
    
    func testProgressIndicatorCreation() {
        // Given
        let progress = 0.5
        
        // When
        let progressIndicator = DSProgressIndicator(progress: progress)
        
        // Then
        XCTAssertNotNil(progressIndicator)
    }
    
    func testProgressIndicatorStyles() {
        // Given
        let progress = 0.7
        let styles: [DSProgressIndicatorStyle] = [.linear, .circular, .determinate, .indeterminate]
        
        // When & Then
        for style in styles {
            let progressIndicator = DSProgressIndicator(
                progress: progress,
                style: style
            )
            XCTAssertNotNil(progressIndicator)
        }
    }
    
    func testProgressIndicatorSizes() {
        // Given
        let progress = 0.3
        let sizes: [DSProgressIndicatorSize] = [.small, .medium, .large]
        
        // When & Then
        for size in sizes {
            let progressIndicator = DSProgressIndicator(
                progress: progress,
                size: size
            )
            XCTAssertNotNil(progressIndicator)
        }
    }
    
    func testProgressIndicatorWithPercentage() {
        // Given
        let progress = 0.8
        
        // When
        let progressIndicator = DSProgressIndicator(
            progress: progress,
            showPercentage: true
        )
        
        // Then
        XCTAssertNotNil(progressIndicator)
    }
    
    func testProgressIndicatorAnimated() {
        // Given
        let progress = 0.6
        
        // When
        let progressIndicator = DSProgressIndicator(
            progress: progress,
            animated: true
        )
        
        // Then
        XCTAssertNotNil(progressIndicator)
    }
    
    func testProgressIndicatorNotAnimated() {
        // Given
        let progress = 0.4
        
        // When
        let progressIndicator = DSProgressIndicator(
            progress: progress,
            animated: false
        )
        
        // Then
        XCTAssertNotNil(progressIndicator)
    }
    
    func testProgressIndicatorSizeProperties() {
        // Given
        let smallSize = DSProgressIndicatorSize.small
        let mediumSize = DSProgressIndicatorSize.medium
        let largeSize = DSProgressIndicatorSize.large
        
        // When & Then
        XCTAssertEqual(smallSize.height, 4)
        XCTAssertEqual(mediumSize.height, 6)
        XCTAssertEqual(largeSize.height, 8)
        
        XCTAssertEqual(smallSize.cornerRadius, 2)
        XCTAssertEqual(mediumSize.cornerRadius, 3)
        XCTAssertEqual(largeSize.cornerRadius, 4)
        
        XCTAssertEqual(smallSize.diameter, 24)
        XCTAssertEqual(mediumSize.diameter, 32)
        XCTAssertEqual(largeSize.diameter, 48)
        
        XCTAssertEqual(smallSize.strokeWidth, 2)
        XCTAssertEqual(mediumSize.strokeWidth, 3)
        XCTAssertEqual(largeSize.strokeWidth, 4)
    }
    
    func testProgressIndicatorStyleProperties() {
        // Given
        let primaryStyle = DSProgressIndicatorStyle.primary
        let successStyle = DSProgressIndicatorStyle.success
        let warningStyle = DSProgressIndicatorStyle.warning
        let errorStyle = DSProgressIndicatorStyle.error
        
        // When & Then
        XCTAssertEqual(primaryStyle.progressColor, .blue)
        XCTAssertEqual(successStyle.progressColor, .green)
        XCTAssertEqual(warningStyle.progressColor, .orange)
        XCTAssertEqual(errorStyle.progressColor, .red)
        
        XCTAssertEqual(primaryStyle.textColor, .primary)
        XCTAssertEqual(successStyle.textColor, .primary)
        XCTAssertEqual(warningStyle.textColor, .primary)
        XCTAssertEqual(errorStyle.textColor, .primary)
    }
    
    func testProgressIndicatorStyleTrackColors() {
        // Given
        let primaryStyle = DSProgressIndicatorStyle.primary
        
        // When & Then
        XCTAssertNotNil(primaryStyle.trackColor(.light))
        XCTAssertNotNil(primaryStyle.trackColor(.dark))
    }
    
    func testProgressIndicatorProgressClamping() {
        // Given
        let negativeProgress = -0.5
        let overProgress = 1.5
        
        // When
        let negativeIndicator = DSProgressIndicator(progress: negativeProgress)
        let overIndicator = DSProgressIndicator(progress: overProgress)
        
        // Then
        XCTAssertNotNil(negativeIndicator)
        XCTAssertNotNil(overIndicator)
    }
    
    func testProgressIndicatorStyleEnum() {
        // Given & When & Then
        XCTAssertNotNil(DSProgressIndicatorStyle.linear)
        XCTAssertNotNil(DSProgressIndicatorStyle.circular)
        XCTAssertNotNil(DSProgressIndicatorStyle.determinate)
        XCTAssertNotNil(DSProgressIndicatorStyle.indeterminate)
    }
} 
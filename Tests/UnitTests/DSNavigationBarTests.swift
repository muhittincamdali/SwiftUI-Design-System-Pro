import XCTest
import SwiftUI
@testable import DesignSystemPro

final class DSNavigationBarTests: XCTestCase {
    
    // MARK: - Properties
    
    var navigationBar: DSNavigationBar!
    var mockLeadingButton: DSNavigationButton!
    var mockTrailingButtons: [DSNavigationButton]!
    
    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
        
        mockLeadingButton = DSNavigationButton(
            icon: "line.3.horizontal",
            action: {},
            accessibilityLabel: "Menu"
        )
        
        mockTrailingButtons = [
            DSNavigationButton(
                icon: "bell",
                action: {},
                accessibilityLabel: "Notifications"
            ),
            DSNavigationButton(
                icon: "person.circle",
                action: {},
                accessibilityLabel: "Profile"
            )
        ]
        
        navigationBar = DSNavigationBar(
            title: "Test Title",
            subtitle: "Test Subtitle",
            leadingButton: mockLeadingButton,
            trailingButtons: mockTrailingButtons
        )
    }
    
    override func tearDown() {
        navigationBar = nil
        mockLeadingButton = nil
        mockTrailingButtons = nil
        super.tearDown()
    }
    
    // MARK: - Initialization Tests
    
    func testNavigationBarInitialization() {
        // Given
        let title = "Test Title"
        let subtitle = "Test Subtitle"
        
        // When
        let navigationBar = DSNavigationBar(
            title: title,
            subtitle: subtitle
        )
        
        // Then
        XCTAssertEqual(navigationBar.title, title)
        XCTAssertEqual(navigationBar.subtitle, subtitle)
        XCTAssertNil(navigationBar.leadingButton)
        XCTAssertTrue(navigationBar.trailingButtons.isEmpty)
        XCTAssertEqual(navigationBar.backgroundStyle, .default)
        XCTAssertEqual(navigationBar.titleStyle, .default)
        XCTAssertFalse(navigationBar.isTransparent)
    }
    
    func testNavigationBarWithAllParameters() {
        // Given
        let title = "Complete Title"
        let subtitle = "Complete Subtitle"
        let customBackgroundStyle = DSNavigationBarBackgroundStyle.custom(color: .red, opacity: 0.8)
        let customTitleStyle = DSNavigationBarTitleStyle.custom(
            font: .largeTitle,
            textColor: .blue,
            subtitleColor: .green
        )
        
        // When
        let navigationBar = DSNavigationBar(
            title: title,
            subtitle: subtitle,
            leadingButton: mockLeadingButton,
            trailingButtons: mockTrailingButtons,
            backgroundStyle: customBackgroundStyle,
            titleStyle: customTitleStyle,
            isTransparent: true
        )
        
        // Then
        XCTAssertEqual(navigationBar.title, title)
        XCTAssertEqual(navigationBar.subtitle, subtitle)
        XCTAssertEqual(navigationBar.leadingButton?.icon, mockLeadingButton.icon)
        XCTAssertEqual(navigationBar.trailingButtons.count, mockTrailingButtons.count)
        XCTAssertEqual(navigationBar.backgroundStyle.color, customBackgroundStyle.color)
        XCTAssertEqual(navigationBar.backgroundStyle.opacity, customBackgroundStyle.opacity)
        XCTAssertEqual(navigationBar.titleStyle.font, customTitleStyle.font)
        XCTAssertEqual(navigationBar.titleStyle.textColor, customTitleStyle.textColor)
        XCTAssertTrue(navigationBar.isTransparent)
    }
    
    // MARK: - Navigation Button Tests
    
    func testNavigationButtonInitialization() {
        // Given
        let icon = "test.icon"
        let accessibilityLabel = "Test Button"
        var actionCalled = false
        
        // When
        let button = DSNavigationButton(
            icon: icon,
            action: { actionCalled = true },
            accessibilityLabel: accessibilityLabel
        )
        
        // Then
        XCTAssertEqual(button.icon, icon)
        XCTAssertEqual(button.accessibilityLabel, accessibilityLabel)
        
        // Test action
        button.action()
        XCTAssertTrue(actionCalled)
    }
    
    // MARK: - Background Style Tests
    
    func testBackgroundStyleDefault() {
        // Given & When
        let defaultStyle = DSNavigationBarBackgroundStyle.default
        
        // Then
        XCTAssertEqual(defaultStyle.color, Color(.systemBackground))
        XCTAssertEqual(defaultStyle.opacity, 1.0)
    }
    
    func testBackgroundStyleBlurred() {
        // Given & When
        let blurredStyle = DSNavigationBarBackgroundStyle.blurred
        
        // Then
        XCTAssertEqual(blurredStyle.color, Color(.systemBackground))
        XCTAssertEqual(blurredStyle.opacity, 0.8)
    }
    
    func testBackgroundStyleCustom() {
        // Given
        let customColor = Color.red
        let customOpacity = 0.5
        
        // When
        let customStyle = DSNavigationBarBackgroundStyle.custom(color: customColor, opacity: customOpacity)
        
        // Then
        XCTAssertEqual(customStyle.color, customColor)
        XCTAssertEqual(customStyle.opacity, customOpacity)
    }
    
    // MARK: - Title Style Tests
    
    func testTitleStyleDefault() {
        // Given & When
        let defaultStyle = DSNavigationBarTitleStyle.default
        
        // Then
        XCTAssertEqual(defaultStyle.font, .title2.bold())
        XCTAssertEqual(defaultStyle.textColor, .primary)
        XCTAssertEqual(defaultStyle.subtitleColor, .secondary)
    }
    
    func testTitleStyleLarge() {
        // Given & When
        let largeStyle = DSNavigationBarTitleStyle.large
        
        // Then
        XCTAssertEqual(largeStyle.font, .largeTitle.bold())
        XCTAssertEqual(largeStyle.textColor, .primary)
        XCTAssertEqual(largeStyle.subtitleColor, .secondary)
    }
    
    func testTitleStyleCustom() {
        // Given
        let customFont = Font.largeTitle
        let customTextColor = Color.blue
        let customSubtitleColor = Color.green
        
        // When
        let customStyle = DSNavigationBarTitleStyle.custom(
            font: customFont,
            textColor: customTextColor,
            subtitleColor: customSubtitleColor
        )
        
        // Then
        XCTAssertEqual(customStyle.font, customFont)
        XCTAssertEqual(customStyle.textColor, customTextColor)
        XCTAssertEqual(customStyle.subtitleColor, customSubtitleColor)
    }
    
    // MARK: - Edge Cases
    
    func testNavigationBarWithEmptyTitle() {
        // Given & When
        let navigationBar = DSNavigationBar(title: "")
        
        // Then
        XCTAssertEqual(navigationBar.title, "")
        XCTAssertNil(navigationBar.subtitle)
        XCTAssertNil(navigationBar.leadingButton)
        XCTAssertTrue(navigationBar.trailingButtons.isEmpty)
    }
    
    func testNavigationBarWithNilSubtitle() {
        // Given & When
        let navigationBar = DSNavigationBar(title: "Test", subtitle: nil)
        
        // Then
        XCTAssertEqual(navigationBar.title, "Test")
        XCTAssertNil(navigationBar.subtitle)
    }
    
    func testNavigationBarWithEmptyTrailingButtons() {
        // Given & When
        let navigationBar = DSNavigationBar(
            title: "Test",
            trailingButtons: []
        )
        
        // Then
        XCTAssertTrue(navigationBar.trailingButtons.isEmpty)
    }
    
    func testNavigationBarWithNilLeadingButton() {
        // Given & When
        let navigationBar = DSNavigationBar(
            title: "Test",
            leadingButton: nil
        )
        
        // Then
        XCTAssertNil(navigationBar.leadingButton)
    }
    
    // MARK: - Performance Tests
    
    func testNavigationBarPerformance() {
        // Given
        let largeTrailingButtons = (0..<10).map { index in
            DSNavigationButton(
                icon: "icon\(index)",
                action: {},
                accessibilityLabel: "Button \(index)"
            )
        }
        
        // When & Then
        measure {
            let _ = DSNavigationBar(
                title: "Performance Test",
                trailingButtons: largeTrailingButtons
            )
        }
    }
    
    // MARK: - Memory Tests
    
    func testNavigationBarMemoryUsage() {
        // Given
        var navigationBars: [DSNavigationBar] = []
        
        // When
        for i in 0..<100 {
            let navigationBar = DSNavigationBar(
                title: "Title \(i)",
                subtitle: "Subtitle \(i)",
                leadingButton: mockLeadingButton,
                trailingButtons: mockTrailingButtons
            )
            navigationBars.append(navigationBar)
        }
        
        // Then
        XCTAssertEqual(navigationBars.count, 100)
        
        // Clean up
        navigationBars.removeAll()
    }
} 
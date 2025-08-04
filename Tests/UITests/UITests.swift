import XCTest
import SwiftUI
@testable import DesignSystemPro

class UITests: XCTestCase {
    
    func testButtonTap() {
        let app = XCUIApplication()
        app.launch()
        
        let button = app.buttons["Test Button"]
        XCTAssertTrue(button.exists)
        button.tap()
    }
    
    func testTextFieldInput() {
        let app = XCUIApplication()
        app.launch()
        
        let textField = app.textFields["Test TextField"]
        XCTAssertTrue(textField.exists)
        textField.tap()
        textField.typeText("Test input")
    }
    
    func testSearchFieldInput() {
        let app = XCUIApplication()
        app.launch()
        
        let searchField = app.searchFields["Test SearchField"]
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("Test search")
    }
    
    func testCardTap() {
        let app = XCUIApplication()
        app.launch()
        
        let card = app.otherElements["Test Card"]
        XCTAssertTrue(card.exists)
        card.tap()
    }
    
    func testModalPresentation() {
        let app = XCUIApplication()
        app.launch()
        
        let modalButton = app.buttons["Show Modal"]
        XCTAssertTrue(modalButton.exists)
        modalButton.tap()
        
        let modal = app.otherElements["Modal Content"]
        XCTAssertTrue(modal.exists)
    }
    
    func testAlertPresentation() {
        let app = XCUIApplication()
        app.launch()
        
        let alertButton = app.buttons["Show Alert"]
        XCTAssertTrue(alertButton.exists)
        alertButton.tap()
        
        let alert = app.alerts["Test Alert"]
        XCTAssertTrue(alert.exists)
    }
    
    func testProgressIndicator() {
        let app = XCUIApplication()
        app.launch()
        
        let progressIndicator = app.otherElements["Progress Indicator"]
        XCTAssertTrue(progressIndicator.exists)
    }
    
    func testBadgeDisplay() {
        let app = XCUIApplication()
        app.launch()
        
        let badge = app.otherElements["Test Badge"]
        XCTAssertTrue(badge.exists)
    }
    
    func testAccessibility() {
        let app = XCUIApplication()
        app.launch()
        
        // Test VoiceOver support
        let accessibleButton = app.buttons["Accessible Button"]
        XCTAssertTrue(accessibleButton.exists)
        XCTAssertTrue(accessibleButton.isAccessibilityElement)
    }
    
    func testDarkMode() {
        let app = XCUIApplication()
        app.launch()
        
        // Test dark mode toggle
        let darkModeToggle = app.switches["Dark Mode Toggle"]
        XCTAssertTrue(darkModeToggle.exists)
        darkModeToggle.tap()
    }
    
    func testComponentInteraction() {
        let app = XCUIApplication()
        app.launch()
        
        // Test form interaction
        let emailField = app.textFields["Email Field"]
        let passwordField = app.secureTextFields["Password Field"]
        let submitButton = app.buttons["Submit Button"]
        
        XCTAssertTrue(emailField.exists)
        XCTAssertTrue(passwordField.exists)
        XCTAssertTrue(submitButton.exists)
        
        emailField.tap()
        emailField.typeText("test@example.com")
        
        passwordField.tap()
        passwordField.typeText("password123")
        
        submitButton.tap()
    }
    
    func testNavigation() {
        let app = XCUIApplication()
        app.launch()
        
        // Test navigation between screens
        let navigationButton = app.buttons["Navigate Button"]
        XCTAssertTrue(navigationButton.exists)
        navigationButton.tap()
        
        let destinationScreen = app.otherElements["Destination Screen"]
        XCTAssertTrue(destinationScreen.exists)
    }
    
    func testScrollPerformance() {
        let app = XCUIApplication()
        app.launch()
        
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.exists)
        
        // Test scroll performance
        scrollView.swipeUp()
        scrollView.swipeDown()
    }
    
    func testComponentStates() {
        let app = XCUIApplication()
        app.launch()
        
        // Test different component states
        let enabledButton = app.buttons["Enabled Button"]
        let disabledButton = app.buttons["Disabled Button"]
        
        XCTAssertTrue(enabledButton.exists)
        XCTAssertTrue(disabledButton.exists)
        XCTAssertTrue(enabledButton.isEnabled)
        XCTAssertFalse(disabledButton.isEnabled)
    }
} 
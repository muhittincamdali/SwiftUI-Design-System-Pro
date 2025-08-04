import XCTest
import SwiftUI
@testable import DesignSystemPro

class DSModalTests: XCTestCase {
    
    func testModalCreation() {
        // Given
        @State var isPresented = false
        
        // When
        let modal = DSModal(
            isPresented: $isPresented,
            title: "Test Modal"
        ) {
            Text("Modal content")
        }
        
        // Then
        XCTAssertNotNil(modal)
    }
    
    func testModalWithTitle() {
        // Given
        @State var isPresented = false
        
        // When
        let modal = DSModal(
            isPresented: $isPresented,
            title: "Test Title"
        ) {
            VStack {
                Text("Content")
                DSButton(title: "Close") {
                    isPresented = false
                }
            }
        }
        
        // Then
        XCTAssertNotNil(modal)
    }
    
    func testModalWithoutTitle() {
        // Given
        @State var isPresented = false
        
        // When
        let modal = DSModal(
            isPresented: $isPresented
        ) {
            Text("Content without title")
        }
        
        // Then
        XCTAssertNotNil(modal)
    }
    
    func testModalStyles() {
        // Given
        @State var isPresented = false
        let styles: [DSModalStyle] = [.sheet, .center, .fullScreen]
        
        // When & Then
        for style in styles {
            let modal = DSModal(
                isPresented: $isPresented,
                style: style
            ) {
                Text("Content")
            }
            XCTAssertNotNil(modal)
        }
    }
    
    func testModalWithOnDismiss() {
        // Given
        @State var isPresented = false
        var dismissCalled = false
        
        // When
        let modal = DSModal(
            isPresented: $isPresented,
            onDismiss: {
                dismissCalled = true
            }
        ) {
            Text("Content")
        }
        
        // Then
        XCTAssertNotNil(modal)
    }
    
    func testModalStyleProperties() {
        // Given
        let sheetStyle = DSModalStyle.sheet
        let centerStyle = DSModalStyle.center
        let fullScreenStyle = DSModalStyle.fullScreen
        
        // When & Then
        XCTAssertEqual(sheetStyle.cornerRadius, 20)
        XCTAssertEqual(centerStyle.cornerRadius, 16)
        XCTAssertEqual(fullScreenStyle.cornerRadius, 0)
        
        XCTAssertEqual(sheetStyle.contentPadding, 20)
        XCTAssertEqual(centerStyle.contentPadding, 24)
        XCTAssertEqual(fullScreenStyle.contentPadding, 20)
        
        XCTAssertTrue(sheetStyle.dismissOnBackdropTap)
        XCTAssertTrue(centerStyle.dismissOnBackdropTap)
        XCTAssertFalse(fullScreenStyle.dismissOnBackdropTap)
    }
    
    func testModalStyleTransitions() {
        // Given
        let sheetStyle = DSModalStyle.sheet
        let centerStyle = DSModalStyle.center
        let fullScreenStyle = DSModalStyle.fullScreen
        
        // When & Then
        XCTAssertNotNil(sheetStyle.transition)
        XCTAssertNotNil(centerStyle.transition)
        XCTAssertNotNil(fullScreenStyle.transition)
    }
    
    func testModalStyleAnimations() {
        // Given
        let sheetStyle = DSModalStyle.sheet
        let centerStyle = DSModalStyle.center
        let fullScreenStyle = DSModalStyle.fullScreen
        
        // When & Then
        XCTAssertNotNil(sheetStyle.animation)
        XCTAssertNotNil(centerStyle.animation)
        XCTAssertNotNil(fullScreenStyle.animation)
    }
    
    func testModalStyleColors() {
        // Given
        let sheetStyle = DSModalStyle.sheet
        
        // When & Then
        XCTAssertNotNil(sheetStyle.backgroundColor(.light))
        XCTAssertNotNil(sheetStyle.backgroundColor(.dark))
        XCTAssertNotNil(sheetStyle.headerBackgroundColor(.light))
        XCTAssertNotNil(sheetStyle.headerBackgroundColor(.dark))
        XCTAssertNotNil(sheetStyle.closeButtonBackgroundColor(.light))
        XCTAssertNotNil(sheetStyle.closeButtonBackgroundColor(.dark))
    }
} 
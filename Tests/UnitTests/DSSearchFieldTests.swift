import XCTest
import SwiftUI
@testable import DesignSystemPro

class DSSearchFieldTests: XCTestCase {
    
    func testSearchFieldCreation() {
        // Given
        @State var searchText = ""
        
        // When
        let searchField = DSSearchField(
            placeholder: "Search",
            text: $searchText
        )
        
        // Then
        XCTAssertNotNil(searchField)
    }
    
    func testSearchFieldWithSuggestions() {
        // Given
        @State var searchText = ""
        let suggestions = ["Apple", "Banana", "Cherry"]
        
        // When
        let searchField = DSSearchField(
            placeholder: "Search fruits",
            text: $searchText,
            suggestions: suggestions
        )
        
        // Then
        XCTAssertNotNil(searchField)
    }
    
    func testSearchFieldWithOnSuggestionSelected() {
        // Given
        @State var searchText = ""
        let suggestions = ["Apple", "Banana"]
        var selectedSuggestion: String?
        
        // When
        let searchField = DSSearchField(
            placeholder: "Search",
            text: $searchText,
            suggestions: suggestions,
            onSuggestionSelected: { suggestion in
                selectedSuggestion = suggestion
            }
        )
        
        // Then
        XCTAssertNotNil(searchField)
    }
    
    func testSearchFieldWithOnSearch() {
        // Given
        @State var searchText = ""
        var searchCalled = false
        
        // When
        let searchField = DSSearchField(
            placeholder: "Search",
            text: $searchText,
            onSearch: { _ in
                searchCalled = true
            }
        )
        
        // Then
        XCTAssertNotNil(searchField)
    }
    
    func testSearchFieldStyles() {
        // Given
        @State var searchText = ""
        let styles: [DSSearchFieldStyle] = [.primary]
        
        // When & Then
        for style in styles {
            let searchField = DSSearchField(
                placeholder: "Test",
                text: $searchText,
                style: style
            )
            XCTAssertNotNil(searchField)
        }
    }
    
    func testSearchFieldSizes() {
        // Given
        @State var searchText = ""
        let sizes: [DSSearchFieldSize] = [.small, .medium, .large]
        
        // When & Then
        for size in sizes {
            let searchField = DSSearchField(
                placeholder: "Test",
                text: $searchText,
                size: size
            )
            XCTAssertNotNil(searchField)
        }
    }
    
    func testSearchFieldStyleProperties() {
        // Given
        let primaryStyle = DSSearchFieldStyle.primary
        
        // When & Then
        XCTAssertEqual(primaryStyle.cornerRadius, 12)
        XCTAssertEqual(primaryStyle.iconColor, Color(.systemGray))
        XCTAssertEqual(primaryStyle.clearButtonColor, Color(.systemGray))
        XCTAssertEqual(primaryStyle.suggestionTextColor, .primary)
        XCTAssertEqual(primaryStyle.suggestionIconColor, Color(.systemGray))
    }
    
    func testSearchFieldSizeProperties() {
        // Given
        let smallSize = DSSearchFieldSize.small
        let mediumSize = DSSearchFieldSize.medium
        let largeSize = DSSearchFieldSize.large
        
        // When & Then
        XCTAssertEqual(smallSize.height, 36)
        XCTAssertEqual(mediumSize.height, 44)
        XCTAssertEqual(largeSize.height, 52)
    }
} 
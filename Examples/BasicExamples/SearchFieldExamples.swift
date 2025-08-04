import SwiftUI

struct SearchFieldExamples: View {
    @State private var searchText = ""
    @State private var productSearchText = ""
    @State private var userSearchText = ""
    
    let productSuggestions = ["iPhone 15 Pro", "MacBook Air", "iPad Pro", "Apple Watch", "AirPods Pro"]
    let userSuggestions = ["John Doe", "Jane Smith", "Mike Johnson", "Sarah Wilson", "David Brown"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Basic Search Fields
                basicSearchFieldsSection
                
                // Search Fields with Suggestions
                searchFieldsWithSuggestionsSection
                
                // Styled Search Fields
                styledSearchFieldsSection
                
                // Sized Search Fields
                sizedSearchFieldsSection
            }
            .padding()
        }
        .navigationTitle("Search Field Examples")
    }
    
    // MARK: - Basic Search Fields
    private var basicSearchFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Basic Search Fields")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSSearchField(
                    placeholder: "Search anything...",
                    text: $searchText
                )
                
                DSSearchField(
                    placeholder: "Search with onSearch callback",
                    text: $searchText,
                    onSearch: { query in
                        print("Searching for: \(query)")
                    }
                )
            }
        }
    }
    
    // MARK: - Search Fields with Suggestions
    private var searchFieldsWithSuggestionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Search Fields with Suggestions")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSSearchField(
                    placeholder: "Search products",
                    text: $productSearchText,
                    suggestions: productSuggestions,
                    onSuggestionSelected: { suggestion in
                        productSearchText = suggestion
                        print("Selected product: \(suggestion)")
                    }
                )
                
                DSSearchField(
                    placeholder: "Search users",
                    text: $userSearchText,
                    suggestions: userSuggestions,
                    onSuggestionSelected: { suggestion in
                        userSearchText = suggestion
                        print("Selected user: \(suggestion)")
                    },
                    onSearch: { query in
                        print("Searching users for: \(query)")
                    }
                )
            }
        }
    }
    
    // MARK: - Styled Search Fields
    private var styledSearchFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Styled Search Fields")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSSearchField(
                    placeholder: "Primary style search",
                    text: $searchText,
                    style: .primary
                )
            }
        }
    }
    
    // MARK: - Sized Search Fields
    private var sizedSearchFieldsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sized Search Fields")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSSearchField(
                    placeholder: "Small search field",
                    text: $searchText,
                    size: .small
                )
                
                DSSearchField(
                    placeholder: "Medium search field",
                    text: $searchText,
                    size: .medium
                )
                
                DSSearchField(
                    placeholder: "Large search field",
                    text: $searchText,
                    size: .large
                )
            }
        }
    }
}

struct SearchFieldExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchFieldExamples()
        }
    }
} 
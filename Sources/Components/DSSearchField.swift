import SwiftUI

public struct DSSearchField: View {
    public let placeholder: String
    @Binding public var text: String
    public let suggestions: [String]
    public let onSuggestionSelected: ((String) -> Void)?
    public let onSearch: ((String) -> Void)?
    public let style: DSSearchFieldStyle
    public let size: DSSearchFieldSize
    
    @State private var isSearching = false
    @State private var showSuggestions = false
    @FocusState private var isFocused: Bool
    
    public init(
        placeholder: String,
        text: Binding<String>,
        suggestions: [String] = [],
        onSuggestionSelected: ((String) -> Void)? = nil,
        onSearch: ((String) -> Void)? = nil,
        style: DSSearchFieldStyle = .primary,
        size: DSSearchFieldSize = .medium
    ) {
        self.placeholder = placeholder
        self._text = text
        self.suggestions = suggestions
        self.onSuggestionSelected = onSuggestionSelected
        self.onSearch = onSearch
        self.style = style
        self.size = size
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(style.iconColor)
                    .font(.system(size: 16, weight: .medium))
                
                TextField(placeholder, text: $text)
                    .textFieldStyle(.plain)
                    .focused($isFocused)
                    .onChange(of: isFocused) { newValue in
                        isSearching = newValue
                        showSuggestions = newValue && !suggestions.isEmpty
                    }
                    .onChange(of: text) { newValue in
                        onSearch?(newValue)
                        showSuggestions = isFocused && !suggestions.isEmpty && !newValue.isEmpty
                    }
                    .onSubmit {
                        onSearch?(text)
                        isFocused = false
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                        showSuggestions = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(style.clearButtonColor)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal, 16)
            .frame(height: size.height)
            .background(style.backgroundColor(for: colorScheme))
            .cornerRadius(style.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .stroke(isSearching ? style.focusedBorderColor : style.borderColor, lineWidth: isSearching ? 2 : 1)
            )
            .animation(.easeInOut(duration: 0.2), value: isSearching)
            
            if showSuggestions && !suggestions.isEmpty {
                suggestionsView
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var suggestionsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(filteredSuggestions, id: \.self) { suggestion in
                Button(action: {
                    text = suggestion
                    onSuggestionSelected?(suggestion)
                    showSuggestions = false
                    isFocused = false
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(style.suggestionIconColor)
                            .font(.system(size: 14, weight: .medium))
                        
                        Text(suggestion)
                            .foregroundColor(style.suggestionTextColor)
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(style.suggestionBackgroundColor(for: colorScheme))
                }
                .buttonStyle(PlainButtonStyle())
                
                if suggestion != filteredSuggestions.last {
                    Divider()
                        .padding(.leading, 48)
                }
            }
        }
        .background(style.suggestionsBackgroundColor(for: colorScheme))
        .cornerRadius(style.cornerRadius)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding(.top, 4)
    }
    
    private var filteredSuggestions: [String] {
        guard !text.isEmpty else { return suggestions }
        return suggestions.filter { $0.localizedCaseInsensitiveContains(text) }
    }
}

public struct DSSearchFieldStyle {
    public let backgroundColor: (ColorScheme) -> Color
    public let borderColor: Color
    public let focusedBorderColor: Color
    public let cornerRadius: CGFloat
    public let iconColor: Color
    public let clearButtonColor: Color
    public let suggestionBackgroundColor: (ColorScheme) -> Color
    public let suggestionsBackgroundColor: (ColorScheme) -> Color
    public let suggestionTextColor: Color
    public let suggestionIconColor: Color
    
    public init(
        backgroundColor: @escaping (ColorScheme) -> Color,
        borderColor: Color,
        focusedBorderColor: Color,
        cornerRadius: CGFloat,
        iconColor: Color,
        clearButtonColor: Color,
        suggestionBackgroundColor: @escaping (ColorScheme) -> Color,
        suggestionsBackgroundColor: @escaping (ColorScheme) -> Color,
        suggestionTextColor: Color,
        suggestionIconColor: Color
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.focusedBorderColor = focusedBorderColor
        self.cornerRadius = cornerRadius
        self.iconColor = iconColor
        self.clearButtonColor = clearButtonColor
        self.suggestionBackgroundColor = suggestionBackgroundColor
        self.suggestionsBackgroundColor = suggestionsBackgroundColor
        self.suggestionTextColor = suggestionTextColor
        self.suggestionIconColor = suggestionIconColor
    }
    
    public static let primary = DSSearchFieldStyle(
        backgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        borderColor: Color(.systemGray4),
        focusedBorderColor: .blue,
        cornerRadius: 12,
        iconColor: Color(.systemGray),
        clearButtonColor: Color(.systemGray),
        suggestionBackgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        suggestionsBackgroundColor: { colorScheme in
            colorScheme == .dark ? Color(.systemGray6) : .white
        },
        suggestionTextColor: .primary,
        suggestionIconColor: Color(.systemGray)
    )
}

public enum DSSearchFieldSize {
    case small, medium, large
    
    public var height: CGFloat {
        switch self {
        case .small: return 36
        case .medium: return 44
        case .large: return 52
        }
    }
} 
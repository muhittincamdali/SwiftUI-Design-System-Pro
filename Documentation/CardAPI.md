# 🃏 Card API

<!-- TOC START -->
## Table of Contents
- [🃏 Card API](#-card-api)
- [📋 Table of Contents](#-table-of-contents)
- [🎯 Overview](#-overview)
  - [Key Features](#key-features)
- [🃏 Card Types](#-card-types)
  - [Basic Card](#basic-card)
  - [Elevated Card](#elevated-card)
  - [Interactive Card](#interactive-card)
  - [Media Card](#media-card)
  - [Action Card](#action-card)
- [🎨 Card Styles](#-card-styles)
  - [Card Elevation](#card-elevation)
  - [Card Border Radius](#card-border-radius)
  - [Card Padding](#card-padding)
- [⚙️ Configuration](#-configuration)
  - [Custom Card Style](#custom-card-style)
  - [Card Configuration](#card-configuration)
- [♿ Accessibility](#-accessibility)
  - [VoiceOver Support](#voiceover-support)
  - [Custom Accessibility](#custom-accessibility)
  - [Dynamic Type Support](#dynamic-type-support)
- [🎯 Usage Examples](#-usage-examples)
  - [Product Card](#product-card)
  - [Profile Card](#profile-card)
  - [Statistics Card](#statistics-card)
  - [News Card](#news-card)
  - [Settings Card](#settings-card)
- [🔧 Advanced Usage](#-advanced-usage)
  - [Animated Card](#animated-card)
  - [Card with Loading State](#card-with-loading-state)
<!-- TOC END -->


**SwiftUI Design System Pro** - Complete Card API Documentation

## 📋 Table of Contents

- [🎯 Overview](#-overview)
- [🃏 Card Types](#-card-types)
- [🎨 Card Styles](#-card-styles)
- [⚙️ Configuration](#️-configuration)
- [♿ Accessibility](#-accessibility)
- [🎯 Usage Examples](#-usage-examples)

---

## 🎯 Overview

The Card API provides a comprehensive collection of card components for displaying content in organized, visually appealing containers. Cards are essential for modern UI design and provide excellent content organization.

### Key Features

- **Multiple Card Types**: Basic, elevated, interactive, and specialized cards
- **Flexible Layout**: Support for various content arrangements
- **Elevation System**: Built-in shadow and depth management
- **Interactive States**: Hover, press, and selection states
- **Accessibility**: Full VoiceOver and accessibility support
- **Customization**: Extensive styling and layout options

---

## 🃏 Card Types

### Basic Card

The basic card provides a simple container for content with consistent padding and styling.

```swift
Card(
    padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
    @ViewBuilder content: () -> Content
)
```

**Parameters:**
- `padding`: Custom padding for the card content
- `content`: The content to display inside the card

**Usage:**
```swift
Card {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Card Title")
            .font(AppTypography.headlineMedium)
        
        Text("This is the card content with some description text.")
            .font(AppTypography.bodyMedium)
            .foregroundColor(AppColors.textSecondary)
    }
}
```

### Elevated Card

The elevated card adds depth and shadow to create visual hierarchy.

```swift
ElevatedCard(
    elevation: CardElevation = .medium,
    padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
    @ViewBuilder content: () -> Content
)
```

**CardElevation Options:**
- `.low`: Subtle elevation with minimal shadow
- `.medium`: Standard elevation with balanced shadow
- `.high`: High elevation with prominent shadow

**Usage:**
```swift
ElevatedCard(elevation: .high) {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Elevated Card")
            .font(AppTypography.headlineMedium)
        
        Text("This card has high elevation for emphasis.")
            .font(AppTypography.bodyMedium)
            .foregroundColor(AppColors.textSecondary)
    }
}
```

### Interactive Card

The interactive card responds to user interactions with visual feedback.

```swift
InteractiveCard(
    isSelected: Bool = false,
    isPressed: Bool = false,
    onTap: @escaping () -> Void,
    @ViewBuilder content: () -> Content
)
```

**Parameters:**
- `isSelected`: Whether the card is in selected state
- `isPressed`: Whether the card is being pressed
- `onTap`: Closure executed when card is tapped
- `content`: The content to display inside the card

**Usage:**
```swift
@State private var selectedCard = 0

InteractiveCard(
    isSelected: selectedCard == 1,
    onTap: { selectedCard = 1 }
) {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Interactive Card")
            .font(AppTypography.headlineMedium)
        
        Text("Tap to select this card.")
            .font(AppTypography.bodyMedium)
            .foregroundColor(AppColors.textSecondary)
    }
}
```

### Media Card

The media card is designed for content with images or media.

```swift
MediaCard(
    image: Image? = nil,
    imageURL: URL? = nil,
    aspectRatio: CGFloat = 16/9,
    padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
    @ViewBuilder content: () -> Content
)
```

**Usage:**
```swift
MediaCard(
    image: Image("sample-image"),
    aspectRatio: 4/3
) {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Media Card")
            .font(AppTypography.headlineMedium)
        
        Text("This card contains an image with content below.")
            .font(AppTypography.bodyMedium)
            .foregroundColor(AppColors.textSecondary)
    }
}
```

### Action Card

The action card includes built-in action buttons.

```swift
ActionCard(
    primaryAction: CardAction? = nil,
    secondaryAction: CardAction? = nil,
    padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
    @ViewBuilder content: () -> Content
)
```

**CardAction Structure:**
```swift
struct CardAction {
    let title: String
    let icon: String?
    let style: ButtonStyle
    let action: () -> Void
}
```

**Usage:**
```swift
ActionCard(
    primaryAction: CardAction(
        title: "Save",
        icon: "checkmark",
        style: .primary
    ) {
        saveContent()
    },
    secondaryAction: CardAction(
        title: "Cancel",
        icon: nil,
        style: .secondary
    ) {
        cancelAction()
    }
) {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Action Card")
            .font(AppTypography.headlineMedium)
        
        Text("This card has built-in action buttons.")
            .font(AppTypography.bodyMedium)
            .foregroundColor(AppColors.textSecondary)
    }
}
```

---

## 🎨 Card Styles

### Card Elevation

```swift
enum CardElevation {
    case low
    case medium
    case high
}
```

**Elevation Specifications:**
- **Low**: Shadow radius 2pt, opacity 0.1
- **Medium**: Shadow radius 4pt, opacity 0.15
- **High**: Shadow radius 8pt, opacity 0.2

### Card Border Radius

```swift
enum CardBorderRadius {
    case small    // 4pt
    case medium   // 8pt
    case large    // 12pt
    case custom(CGFloat)
}
```

### Card Padding

```swift
enum CardPadding {
    case none
    case small    // 8pt
    case medium   // 16pt
    case large    // 24pt
    case custom(EdgeInsets)
}
```

---

## ⚙️ Configuration

### Custom Card Style

```swift
struct CustomCardStyle: CardStyle {
    let backgroundColor: Color
    let borderColor: Color?
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let shadowOpacity: Double
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor ?? Color.clear, lineWidth: borderWidth)
            )
            .cornerRadius(cornerRadius)
            .shadow(
                color: Color.black.opacity(shadowOpacity),
                radius: shadowRadius,
                x: 0,
                y: 2
            )
    }
}
```

**Usage:**
```swift
Card {
    Text("Custom styled card")
        .font(AppTypography.bodyMedium)
}
.cardStyle(CustomCardStyle(
    backgroundColor: AppColors.surface,
    borderColor: AppColors.border,
    borderWidth: 1,
    cornerRadius: 12,
    shadowRadius: 4,
    shadowOpacity: 0.1
))
```

### Card Configuration

```swift
struct CardConfiguration {
    let defaultPadding: EdgeInsets
    let defaultCornerRadius: CGFloat
    let defaultElevation: CardElevation
    let animationEnabled: Bool
}

// Default configuration
let defaultCardConfig = CardConfiguration(
    defaultPadding: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
    defaultCornerRadius: 8,
    defaultElevation: .medium,
    animationEnabled: true
)
```

---

## ♿ Accessibility

### VoiceOver Support

All cards automatically include VoiceOver support:

```swift
Card {
    Text("Accessible Card")
        .font(AppTypography.headlineMedium)
}
.accessibilityLabel("Card containing important information")
.accessibilityHint("Double tap to view details")
```

### Custom Accessibility

```swift
InteractiveCard(
    isSelected: selectedCard == 1,
    onTap: { selectedCard = 1 }
) {
    VStack {
        Text("Selectable Card")
        Text("Tap to select")
    }
}
.accessibilityLabel("Selectable card option")
.accessibilityValue(selectedCard == 1 ? "Selected" : "Not selected")
.accessibilityAddTraits(.isButton)
```

### Dynamic Type Support

All cards automatically scale with Dynamic Type:

```swift
Card {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        Text("Dynamic Type Card")
            .font(AppTypography.headlineMedium)
        
        Text("This text scales with user preferences")
            .font(AppTypography.bodyMedium)
    }
}
// Automatically scales with user's text size preference
```

---

## 🎯 Usage Examples

### Product Card

```swift
struct ProductCard: View {
    let product: Product
    
    var body: some View {
        MediaCard(
            image: Image(product.imageName),
            aspectRatio: 1
        ) {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                Text(product.name)
                    .font(AppTypography.headlineMedium)
                    .foregroundColor(AppColors.textPrimary)
                
                Text(product.description)
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(2)
                
                HStack {
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(AppTypography.titleMedium)
                        .foregroundColor(AppColors.primary)
                    
                    Spacer()
                    
                    PrimaryButton(title: "Add to Cart") {
                        addToCart(product)
                    }
                }
            }
        }
    }
    
    private func addToCart(_ product: Product) {
        // Add to cart logic
    }
}
```

### Profile Card

```swift
struct ProfileCard: View {
    let profile: UserProfile
    
    var body: some View {
        ElevatedCard(elevation: .medium) {
            HStack(spacing: AppSpacing.md) {
                // Avatar
                Circle()
                    .fill(AppColors.primary)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(String(profile.name.prefix(1)))
                            .font(AppTypography.headlineMedium)
                            .foregroundColor(AppColors.textInverse)
                    )
                
                // Profile Info
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text(profile.name)
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(profile.email)
                        .font(AppTypography.bodyMedium)
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(profile.role)
                        .font(AppTypography.labelMedium)
                        .foregroundColor(AppColors.primary)
                }
                
                Spacer()
                
                // Action Button
                IconButton(icon: "ellipsis") {
                    showProfileOptions()
                }
            }
        }
    }
    
    private func showProfileOptions() {
        // Show profile options
    }
}
```

### Statistics Card

```swift
struct StatisticsCard: View {
    let title: String
    let value: String
    let change: Double
    let icon: String
    
    var body: some View {
        Card {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                // Header
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(AppColors.primary)
                        .font(.title2)
                    
                    Spacer()
                    
                    // Change indicator
                    HStack(spacing: AppSpacing.xs) {
                        Image(systemName: change >= 0 ? "arrow.up" : "arrow.down")
                            .foregroundColor(change >= 0 ? AppColors.success : AppColors.error)
                            .font(.caption)
                        
                        Text("\(abs(change), specifier: "%.1f")%")
                            .font(AppTypography.labelSmall)
                            .foregroundColor(change >= 0 ? AppColors.success : AppColors.error)
                    }
                }
                
                // Value
                Text(value)
                    .font(AppTypography.displaySmall)
                    .foregroundColor(AppColors.textPrimary)
                
                // Title
                Text(title)
                    .font(AppTypography.bodyMedium)
                    .foregroundColor(AppColors.textSecondary)
            }
        }
    }
}
```

### News Card

```swift
struct NewsCard: View {
    let article: NewsArticle
    
    var body: some View {
        InteractiveCard(
            onTap: { openArticle(article) }
        ) {
            VStack(alignment: .leading, spacing: AppSpacing.md) {
                // Image
                if let imageURL = article.imageURL {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(AppColors.backgroundSecondary)
                    }
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(8)
                }
                
                // Content
                VStack(alignment: .leading, spacing: AppSpacing.sm) {
                    Text(article.title)
                        .font(AppTypography.headlineMedium)
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(2)
                    
                    Text(article.excerpt)
                        .font(AppTypography.bodyMedium)
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(3)
                    
                    HStack {
                        Text(article.author)
                            .font(AppTypography.labelMedium)
                            .foregroundColor(AppColors.textTertiary)
                        
                        Spacer()
                        
                        Text(article.publishedDate, style: .relative)
                            .font(AppTypography.labelSmall)
                            .foregroundColor(AppColors.textTertiary)
                    }
                }
            }
        }
    }
    
    private func openArticle(_ article: NewsArticle) {
        // Open article logic
    }
}
```

### Settings Card

```swift
struct SettingsCard: View {
    let settings: [SettingItem]
    
    var body: some View {
        Card {
            VStack(spacing: 0) {
                ForEach(settings) { setting in
                    HStack(spacing: AppSpacing.md) {
                        // Icon
                        Image(systemName: setting.icon)
                            .foregroundColor(AppColors.primary)
                            .frame(width: 24, height: 24)
                        
                        // Content
                        VStack(alignment: .leading, spacing: AppSpacing.xs) {
                            Text(setting.title)
                                .font(AppTypography.bodyMedium)
                                .foregroundColor(AppColors.textPrimary)
                            
                            if let subtitle = setting.subtitle {
                                Text(subtitle)
                                    .font(AppTypography.labelSmall)
                                    .foregroundColor(AppColors.textSecondary)
                            }
                        }
                        
                        Spacer()
                        
                        // Action
                        if setting.hasToggle {
                            Toggle("", isOn: setting.toggleBinding)
                                .labelsHidden()
                        } else {
                            Image(systemName: "chevron.right")
                                .foregroundColor(AppColors.textTertiary)
                                .font(.caption)
                        }
                    }
                    .padding(AppSpacing.md)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        setting.action()
                    }
                    
                    if setting != settings.last {
                        Divider()
                            .padding(.leading, 56)
                    }
                }
            }
        }
    }
}
```

---

## 🔧 Advanced Usage

### Animated Card

```swift
struct AnimatedCard: View {
    @State private var isPressed = false
    @State private var isHovered = false
    
    var body: some View {
        Card {
            Text("Animated Card")
                .font(AppTypography.headlineMedium)
        }
        .scaleEffect(isPressed ? 0.95 : isHovered ? 1.02 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isPressed)
        .animation(.easeInOut(duration: 0.2), value: isHovered)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
            }
        }
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
```

### Card with Loading State

```swift
struct LoadingCard: View {
    @State private var isLoading = false
    
    var body: some View {
        Card {
            VStack(spacing: AppSpacing.md) {
                if isLoading {
                    LoadingSpinner(size: .medium)
                        .frame(height: 100)
                } else {
                    VStack(alignment: .leading, spacing: AppSpacing.md) {
                        Text("Content Card")
                            .font(AppTypography.headlineMedium)
                        
                        Text("This card shows loading state.")
                            .font(AppTypography.bodyMedium)
                            .foregroundColor(AppColors.textSecondary)
                    }
                }
            }
        }
        .onAppear {
            isLoading = true
            // Simulate loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
            }
        }
    }
}
```

---

Bu API dokümantasyonu, SwiftUI Design System Pro'nun tüm kart bileşenlerini kapsamlı bir şekilde açıklamaktadır. Her kart türünün nasıl kullanılacağı, özelleştirme seçenekleri ve pratik örnekler dahil edilmiştir.

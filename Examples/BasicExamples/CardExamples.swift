import SwiftUI

struct CardExamples: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Basic Cards
                basicCardsSection
                
                // Card Styles
                cardStylesSection
                
                // Card Sizes
                cardSizesSection
                
                // Card with Images
                cardWithImagesSection
                
                // Card with Actions
                cardWithActionsSection
            }
            .padding()
        }
        .navigationTitle("Card Examples")
    }
    
    // MARK: - Basic Cards
    private var basicCardsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Basic Cards")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSCard(
                    title: "Simple Card",
                    subtitle: "This is a basic card with title and subtitle"
                )
                
                DSCard(
                    title: "Card with Image",
                    subtitle: "This card includes an icon",
                    image: "star.fill"
                )
                
                DSCard(
                    title: "Interactive Card",
                    subtitle: "Tap to perform an action"
                ) {
                    print("Card tapped!")
                }
            }
        }
    }
    
    // MARK: - Card Styles
    private var cardStylesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Card Styles")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSCard(
                    title: "Primary Style",
                    subtitle: "Default card style",
                    style: .primary
                )
                
                DSCard(
                    title: "Secondary Style",
                    subtitle: "Alternative card style",
                    style: .secondary
                )
            }
        }
    }
    
    // MARK: - Card Sizes
    private var cardSizesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Card Sizes")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSCard(
                    title: "Small Card",
                    subtitle: "Compact card design",
                    size: .small
                )
                
                DSCard(
                    title: "Medium Card",
                    subtitle: "Standard card size",
                    size: .medium
                )
                
                DSCard(
                    title: "Large Card",
                    subtitle: "Spacious card layout",
                    size: .large
                )
            }
        }
    }
    
    // MARK: - Card with Images
    private var cardWithImagesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Card with Images")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSCard(
                    title: "Success Card",
                    subtitle: "Operation completed successfully",
                    image: "checkmark.circle.fill"
                )
                
                DSCard(
                    title: "Info Card",
                    subtitle: "Important information",
                    image: "info.circle.fill"
                )
                
                DSCard(
                    title: "Warning Card",
                    subtitle: "Please review this item",
                    image: "exclamationmark.triangle.fill"
                )
            }
        }
    }
    
    // MARK: - Card with Actions
    private var cardWithActionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Card with Actions")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                DSCard(
                    title: "Action Card",
                    subtitle: "Tap to view details"
                ) {
                    print("View details tapped")
                }
                
                DSCard(
                    title: "Settings Card",
                    subtitle: "Configure your preferences",
                    image: "gear"
                ) {
                    print("Settings tapped")
                }
                
                DSCard(
                    title: "Profile Card",
                    subtitle: "View your profile information",
                    image: "person.circle.fill"
                ) {
                    print("Profile tapped")
                }
            }
        }
    }
}

struct CardExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardExamples()
        }
    }
} 
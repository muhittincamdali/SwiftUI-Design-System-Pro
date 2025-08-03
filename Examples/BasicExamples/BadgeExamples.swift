import SwiftUI

struct BadgeExamples: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Badge Types
                badgeTypesSection
                
                // Badge Styles
                badgeStylesSection
                
                // Badge Sizes
                badgeSizesSection
                
                // Badge with Text
                badgeWithTextSection
                
                // Badge with Numbers
                badgeWithNumbersSection
                
                // Badge with Dots
                badgeWithDotsSection
            }
            .padding()
        }
        .navigationTitle("Badge Examples")
    }
    
    // MARK: - Badge Types
    private var badgeTypesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Badge Types")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    DSBadge(text: "New")
                    DSBadge(number: 5)
                    DSBadge(showDot: true)
                }
                
                HStack(spacing: 12) {
                    DSBadge(text: "Sale", style: .success)
                    DSBadge(number: 12, style: .warning)
                    DSBadge(showDot: true, style: .error)
                }
            }
        }
    }
    
    // MARK: - Badge Styles
    private var badgeStylesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Badge Styles")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    DSBadge(text: "Primary", style: .primary)
                    DSBadge(text: "Secondary", style: .secondary)
                    DSBadge(text: "Success", style: .success)
                }
                
                HStack(spacing: 12) {
                    DSBadge(text: "Warning", style: .warning)
                    DSBadge(text: "Error", style: .error)
                    DSBadge(text: "Info", style: .info)
                }
            }
        }
    }
    
    // MARK: - Badge Sizes
    private var badgeSizesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Badge Sizes")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    DSBadge(text: "Small", size: .small)
                    DSBadge(text: "Medium", size: .medium)
                    DSBadge(text: "Large", size: .large)
                }
                
                HStack(spacing: 12) {
                    DSBadge(number: 1, size: .small)
                    DSBadge(number: 5, size: .medium)
                    DSBadge(number: 99, size: .large)
                }
            }
        }
    }
    
    // MARK: - Badge with Text
    private var badgeWithTextSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Badge with Text")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    DSBadge(text: "New", style: .primary)
                    DSBadge(text: "Sale", style: .success)
                    DSBadge(text: "Limited", style: .warning)
                }
                
                HStack(spacing: 12) {
                    DSBadge(text: "Featured", style: .info)
                    DSBadge(text: "Popular", style: .primary)
                    DSBadge(text: "Trending", style: .success)
                }
                
                HStack(spacing: 12) {
                    DSBadge(text: "Hot", style: .error)
                    DSBadge(text: "Best", style: .warning)
                    DSBadge(text: "Top", style: .info)
                }
            }
        }
    }
    
    // MARK: - Badge with Numbers
    private var badgeWithNumbersSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Badge with Numbers")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    DSBadge(number: 1, style: .primary)
                    DSBadge(number: 5, style: .secondary)
                    DSBadge(number: 10, style: .success)
                }
                
                HStack(spacing: 12) {
                    DSBadge(number: 25, style: .warning)
                    DSBadge(number: 50, style: .error)
                    DSBadge(number: 100, style: .info)
                }
                
                HStack(spacing: 12) {
                    DSBadge(number: 999, style: .primary)
                    DSBadge(number: 1000, style: .success)
                    DSBadge(number: 9999, style: .warning)
                }
            }
        }
    }
    
    // MARK: - Badge with Dots
    private var badgeWithDotsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Badge with Dots")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    DSBadge(showDot: true, style: .primary)
                    DSBadge(showDot: true, style: .success)
                    DSBadge(showDot: true, style: .warning)
                }
                
                HStack(spacing: 12) {
                    DSBadge(showDot: true, style: .error)
                    DSBadge(showDot: true, style: .info)
                    DSBadge(showDot: true, style: .secondary)
                }
                
                HStack(spacing: 12) {
                    DSBadge(showDot: true, size: .small)
                    DSBadge(showDot: true, size: .medium)
                    DSBadge(showDot: true, size: .large)
                }
            }
        }
    }
}

struct BadgeExamples_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BadgeExamples()
        }
    }
} 
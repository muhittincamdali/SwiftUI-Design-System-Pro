import SwiftUI

/**
 * DSCard - Design System Card Component
 * 
 * A versatile card component for displaying content in a structured layout.
 * Supports various card types and customization options.
 * 
 * - Parameters:
 *   - title: Card title
 *   - subtitle: Card subtitle (optional)
 *   - image: Card image (optional)
 *   - action: Card tap action (optional)
 * 
 * - Returns: SwiftUI View
 * 
 * - Example:
 * ```swift
 * DSCard(
 *     title: "Welcome",
 *     subtitle: "Start building amazing apps",
 *     image: "star.fill"
 * )
 * ```
 */
public struct DSCard: View {
    public let title: String
    public let subtitle: String?
    public let image: String?
    public let action: (() -> Void)?
    
    @Environment(\.colorScheme) private var colorScheme
    
    public init(
        title: String,
        subtitle: String? = nil,
        image: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.action = action
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image
            if let image = image {
                HStack {
                    Image(systemName: image)
                        .font(.title2)
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? .gray : .secondary)
                        .lineLimit(2)
                }
            }
        }
        .padding(16)
        .background(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            action?()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title), \(subtitle ?? "")")
        .accessibilityHint(action != nil ? "Double tap to activate" : nil)
    }
}

// MARK: - Product Card
public struct DSProductCard: View {
    public let title: String
    public let price: String
    public let image: String
    public let rating: Double
    public let action: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme
    
    public init(
        title: String,
        price: String,
        image: String,
        rating: Double,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.price = price
        self.image = image
        self.rating = rating
        self.action = action
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Product Image
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .background(colorScheme == .dark ? Color(.systemGray6) : Color(.systemGray6))
                .cornerRadius(8)
            
            // Product Info
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .lineLimit(2)
                
                HStack {
                    Text(price)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                            .foregroundColor(colorScheme == .dark ? .gray : .secondary)
                    }
                }
            }
        }
        .padding(16)
        .background(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            action()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title), \(price), Rating: \(rating)")
        .accessibilityHint("Double tap to view product")
    }
}

// MARK: - Profile Card
public struct DSProfileCard: View {
    public let name: String
    public let role: String
    public let avatar: String
    public let action: () -> Void
    
    @Environment(\.colorScheme) private var colorScheme
    
    public init(
        name: String,
        role: String,
        avatar: String,
        action: @escaping () -> Void
    ) {
        self.name = name
        self.role = role
        self.avatar = avatar
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            // Avatar
            Image(systemName: avatar)
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .background(colorScheme == .dark ? Color(.systemGray5) : Color(.systemGray6))
                .clipShape(Circle())
            
            // Profile Info
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Text(role)
                    .font(.subheadline)
                    .foregroundColor(colorScheme == .dark ? .gray : .secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(colorScheme == .dark ? .gray : .secondary)
        }
        .padding(16)
        .background(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .onTapGesture {
            action()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(name), \(role)")
        .accessibilityHint("Double tap to view profile")
    }
}

// MARK: - Stats Card
public struct DSStatsCard: View {
    public let title: String
    public let value: String
    public let change: String
    public let trend: TrendDirection
    
    @Environment(\.colorScheme) private var colorScheme
    
    public enum TrendDirection {
        case up
        case down
        case neutral
    }
    
    public init(
        title: String,
        value: String,
        change: String,
        trend: TrendDirection
    ) {
        self.title = title
        self.value = value
        self.change = change
        self.trend = trend
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(colorScheme == .dark ? .gray : .secondary)
            
            HStack {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: trendIcon)
                        .font(.caption)
                        .foregroundColor(trendColor)
                    Text(change)
                        .font(.caption)
                        .foregroundColor(trendColor)
                }
            }
        }
        .padding(16)
        .background(colorScheme == .dark ? Color(.systemGray6) : Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray5), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value), \(change)")
    }
    
    private var trendIcon: String {
        switch trend {
        case .up: return "arrow.up"
        case .down: return "arrow.down"
        case .neutral: return "minus"
        }
    }
    
    private var trendColor: Color {
        switch trend {
        case .up: return .green
        case .down: return .red
        case .neutral: return colorScheme == .dark ? .gray : .secondary
        }
    }
}

// MARK: - Previews
struct DSCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            DSCard(
                title: "Welcome",
                subtitle: "Start building amazing apps",
                image: "star.fill"
            )
            
            DSProductCard(
                title: "iPhone 15 Pro",
                price: "$999",
                image: "iphone",
                rating: 4.5
            ) {
                print("Product tapped")
            }
            
            DSProfileCard(
                name: "John Doe",
                role: "iOS Developer",
                avatar: "person.circle.fill"
            ) {
                print("Profile tapped")
            }
            
            DSStatsCard(
                title: "Revenue",
                value: "$50,000",
                change: "+12%",
                trend: .up
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
} 
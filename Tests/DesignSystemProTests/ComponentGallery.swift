import SwiftUI
@testable import DesignSystemPro

/// Static component showcases used by the rendering tests and by
/// `scripts/render-screenshots.sh` to produce the README images.
enum GallerySection: String, CaseIterable, Sendable {
    case buttons
    case badges
    case cards
    case selection
    case feedback

    @MainActor @ViewBuilder
    var view: some View {
        switch self {
        case .buttons: ButtonsGallery()
        case .badges: BadgesGallery()
        case .cards: CardsGallery()
        case .selection: SelectionGallery()
        case .feedback: FeedbackGallery()
        }
    }
}

/// Wraps a section in the primary background for a given color scheme.
struct GalleryFrame<Content: View>: View {
    let colorScheme: ColorScheme
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(SpacingScale.xl.rawValue)
            .frame(width: 420, alignment: .leading)
            .background(ColorTokens.Background.primary.resolved(for: colorScheme))
            .environment(\.colorScheme, colorScheme)
    }
}

private struct ButtonsGallery: View {
    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            HStack(spacing: SpacingScale.sm.rawValue) {
                DSButton("Primary", variant: .primary) {}
                DSButton("Secondary", variant: .secondary) {}
                DSButton("Ghost", variant: .ghost) {}
            }
            HStack(spacing: SpacingScale.sm.rawValue) {
                DSButton("Delete", variant: .destructive, leadingIcon: Image(systemName: "trash")) {}
                DSButton("Confirm", variant: .success, isPill: true) {}
                DSButton("Saving", variant: .primary) {}.loading(true)
            }
            HStack(spacing: SpacingScale.sm.rawValue) {
                ForEach(DSButtonSize.allCases, id: \.self) { size in
                    DSButton(size.rawValue.uppercased(), size: size) {}
                }
            }
            DSButton("Continue", isFullWidth: true, trailingIcon: Image(systemName: "arrow.right")) {}
        }
    }
}

private struct BadgesGallery: View {
    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            HStack(spacing: SpacingScale.sm.rawValue) {
                ForEach(DSBadgeVariant.allCases, id: \.self) { variant in
                    DSBadge(variant.rawValue.capitalized, variant: variant, size: .sm)
                }
            }
            HStack(spacing: SpacingScale.lg.rawValue) {
                DSCounterBadge(count: 7)
                DSCounterBadge(count: 120)
                DSStatusBadge("Online", variant: .success)
                DSTag("SwiftUI")
            }
            HStack(spacing: SpacingScale.md.rawValue) {
                DSAvatar(name: "Ada Lovelace", size: .lg, status: .online)
                DSAvatar(name: "Grace Hopper", size: .lg, status: .busy)
                DSAvatar(size: .lg)
                DSAvatarGroup(avatars: [
                    AvatarData(name: "Alan Turing"),
                    AvatarData(name: "Edsger Dijkstra"),
                    AvatarData(name: "Barbara Liskov"),
                    AvatarData(name: "Donald Knuth"),
                    AvatarData(name: "Margaret Hamilton")
                ], size: .md, maxVisible: 3)
            }
        }
    }
}

private struct CardsGallery: View {
    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            HStack(spacing: SpacingScale.md.rawValue) {
                DSStatCard(title: "Revenue", value: "$12.4k", change: "+8.2%", icon: Image(systemName: "chart.line.uptrend.xyaxis"))
                DSStatCard(title: "Churn", value: "2.1%", change: "-0.4%", isPositive: false)
            }
            DSCard(variant: .outlined) {
                VStack(alignment: .leading, spacing: SpacingScale.sm.rawValue) {
                    DSCardHeader(title: "Release notes", subtitle: "Version 2.0", leadingIcon: Image(systemName: "doc.text"))
                    Text("Tokens, theme engine and components restored and tested.")
                        .dsTypography(TypographyTokens.Body.small)
                        .dsForegroundColor(ColorTokens.Foreground.secondary)
                }
            }
        }
    }
}

private struct SelectionGallery: View {
    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            DSToggle(isOn: .constant(true), label: "Notifications")
            DSToggle(isOn: .constant(false), label: "Weekly digest")
            DSCheckbox(isChecked: .constant(true), label: "Accept terms")
            DSCheckbox(isChecked: .constant(false), label: "Partially selected", isIndeterminate: true)
            DSRadio(isSelected: .constant(true), label: "Monthly billing")
            DSRadio(isSelected: .constant(false), label: "Yearly billing")
        }
    }
}

private struct FeedbackGallery: View {
    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            DSToastView(toast: DSToastData(title: "Profile saved", message: "Changes are live.", variant: .success)) {}
            DSToastView(toast: DSToastData(title: "Upload failed", message: "Check your connection.", variant: .error)) {}
            DSSkeletonListItem(hasAvatar: true, lines: 2)
        }
    }
}

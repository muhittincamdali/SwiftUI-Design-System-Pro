import DesignSystemPro
import SwiftUI

/// One interactive example per component family.
struct ComponentsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SpacingTokens.Content.spacious) {
                DemoSection("Buttons") { ButtonsDemo() }
                DemoSection("Text input") { TextInputDemo() }
                DemoSection("Selection") { SelectionDemo() }
                DemoSection("Cards, badges and avatars") { ContentDemo() }
                DemoSection("Feedback and loading") { FeedbackDemo() }
            }
            .padding(SpacingTokens.Layout.screenEdge)
        }
        .dsBackgroundColor(ColorTokens.Background.primary)
    }
}

private struct DemoSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: SpacingTokens.Content.comfortable) {
            Text(title).dsTypography(TypographyTokens.Heading.h4)
            content
        }
    }
}

private struct ButtonsDemo: View {
    @State private var isSaving = false

    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.sm.rawValue) {
            HStack(spacing: SpacingScale.sm.rawValue) {
                DSButton("Primary") {}
                DSButton("Secondary", variant: .secondary) {}
                DSButton("Ghost", variant: .ghost) {}
            }
            DSButton("Delete", variant: .destructive, leadingIcon: Image(systemName: "trash")) {}
            DSButton(isSaving ? "Saving" : "Save", isFullWidth: true) {
                isSaving.toggle()
            }
            .loading(isSaving)
        }
    }
}

private struct TextInputDemo: View {
    @State private var name = ""
    @State private var query = ""

    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            DSTextField(
                "Name",
                text: $name,
                placeholder: "At least two characters",
                state: name.count == 1 ? .error("Too short") : .default
            )
            DSSearchField(text: $query)
        }
    }
}

private struct SelectionDemo: View {
    @State private var notifications = true
    @State private var darkIcons = false
    @State private var acceptedTerms = false
    @State private var plan = "Monthly"

    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            DSToggle(isOn: $notifications, label: "Notifications")
            DSSwitch(isOn: $darkIcons, label: "Dark app icon")
            DSCheckbox(isChecked: $acceptedTerms, label: "Accept terms")
            DSRadioGroup(selection: $plan, options: ["Monthly", "Yearly"])
        }
    }
}

private struct ContentDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            DSStatCard(title: "Revenue", value: "$12.4k", change: "+8.2%", icon: Image(systemName: "chart.line.uptrend.xyaxis"))
            DSCard(variant: .outlined) {
                DSCardHeader(title: "Release notes", subtitle: "Version 2.0", leadingIcon: Image(systemName: "doc.text"))
            }
            HStack(spacing: SpacingScale.sm.rawValue) {
                DSBadge("New", variant: .primary, size: .sm)
                DSCounterBadge(count: 7)
                DSStatusBadge("Online", variant: .success)
                DSTag("SwiftUI")
            }
            HStack(spacing: SpacingScale.md.rawValue) {
                DSAvatar(name: "Ada Lovelace", status: .online)
                DSAvatar(name: "Grace Hopper", status: .busy)
                DSAvatarGroup(avatars: [
                    AvatarData(name: "Alan Turing"),
                    AvatarData(name: "Barbara Liskov"),
                    AvatarData(name: "Donald Knuth")
                ], maxVisible: 2)
            }
        }
    }
}

private struct FeedbackDemo: View {
    @State private var isLoading = true

    var body: some View {
        VStack(alignment: .leading, spacing: SpacingScale.md.rawValue) {
            HStack(spacing: SpacingScale.sm.rawValue) {
                DSButton("Success toast", variant: .success, size: .sm) {
                    DSToastManager.shared.success("Profile saved", message: "Changes are live.")
                }
                DSButton("Error toast", variant: .destructive, size: .sm) {
                    DSToastManager.shared.error("Upload failed", message: "Check your connection.")
                }
            }
            DSToggle(isOn: $isLoading, label: "Show skeleton")
            DSConditionalSkeleton(isLoading: isLoading) {
                DSCardListItem(title: "Ada Lovelace", subtitle: "Analytical Engine notes")
            } skeleton: {
                DSSkeletonListItem(hasAvatar: true, lines: 2)
            }
        }
    }
}

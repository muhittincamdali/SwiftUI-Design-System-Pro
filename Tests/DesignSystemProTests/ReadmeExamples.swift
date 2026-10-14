// Code from README.md and the DocC articles, kept verbatim so that the
// documentation fails to build when the API changes. Update both together.

import DesignSystemPro
import SwiftUI
import Testing

// MARK: - README: Usage

private struct ContentView: View {
    var body: some View { SignInView() }
}

// `@main` is omitted because a test bundle cannot declare an entry point.
private struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            DSApp { ContentView() }
        }
    }
}

private struct SignInView: View {
    @State private var email = ""
    @State private var isSubmitting = false

    var body: some View {
        VStack(spacing: SpacingTokens.Content.comfortable) {
            Text("Welcome back").dsTypography(TypographyTokens.Heading.h2)

            DSTextField("Email", text: $email, placeholder: "you@example.com")

            DSButton("Sign in", isFullWidth: true) {
                isSubmitting = true
                DSToastManager.shared.success("Signed in")
            }
            .loading(isSubmitting)

            HStack {
                DSAvatar(name: "Ada Lovelace", status: .online)
                DSStatusBadge("Verified", variant: .success)
            }
        }
        .padding(SpacingTokens.Layout.screenEdge)
        .dsBackgroundColor(ColorTokens.Background.primary)
    }
}

// MARK: - DocC: Using Design Tokens

private struct SavedLabel: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Text("Saved")
            .foregroundStyle(ColorTokens.Status.success.resolved(for: colorScheme))
    }
}

private struct PulsingDot: View {
    let isActive: Bool

    var body: some View {
        Circle()
            .scaleEffect(isActive ? 1.2 : 1)
            .dsSpring(.bouncy, value: isActive)
    }
}

// MARK: - DocC: Theming

private struct ProfileHeader: View {
    @Environment(\.dsTheme) private var theme

    var body: some View {
        Text("Profile")
            .foregroundStyle(theme.colors.accent)
    }
}

@Suite("Documentation examples")
@MainActor
struct ReadmeExamplesTests {
    @Test func usageViewsRender() {
        #expect(ImageRenderer(content: DSApp { ContentView() }).cgImage != nil)
        #expect(ImageRenderer(content: SavedLabel()).cgImage != nil)
        #expect(ImageRenderer(content: PulsingDot(isActive: true).frame(width: 20, height: 20)).cgImage != nil)
        #expect(ImageRenderer(content: DSThemeProvider { ProfileHeader() }).cgImage != nil)
        _ = MyApp()
    }

    @Test func themingSnippet() {
        // Follow the system light/dark setting (the default) ...
        DesignSystemPro.configure()

        // ... or force a preset or a generated brand theme.
        ThemeManager.shared.setTheme(PresetThemes.ocean)

        let brand = BrandConfiguration(primaryColor: .purple, secondaryColor: .pink, borderRadius: 12)
        ThemeManager.shared.setTheme(WhiteLabelConfiguration(brand: brand, appName: "Acme").darkTheme)

        #expect(ThemeManager.shared.resolvedTheme(for: .light).id == "acme-dark")
        DesignSystemPro.configure()
    }

    @Test func contrastSnippet() {
        let ratio = ColorContrastUtility.contrastRatio(.white, Color(hex: "#2563EB")) // about 5.2
        let passes = ColorContrastUtility.meetsWCAG_AA(.white, Color(hex: "#2563EB")) // true

        #expect(abs(ratio - 5.2) < 0.05)
        #expect(passes)
    }
}

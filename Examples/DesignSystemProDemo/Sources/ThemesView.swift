import DesignSystemPro
import SwiftUI

/// Switches the shared theme and shows the values your own views read from
/// `@Environment(\.dsTheme)`. The built-in components keep their token colors.
struct ThemesView: View {
    private enum Choice: String, CaseIterable, Identifiable {
        case system = "Follow the system"
        case light = "Light"
        case dark = "Dark"
        case ocean = "Ocean"
        case forest = "Forest"
        case sunset = "Sunset"
        case lavender = "Lavender"
        case brand = "Brand (purple and pink)"

        var id: String { rawValue }

        var theme: (any DSTheme)? {
            switch self {
            case .system: nil
            case .light: LightTheme()
            case .dark: DarkTheme()
            case .ocean: PresetThemes.ocean
            case .forest: PresetThemes.forest
            case .sunset: PresetThemes.sunset
            case .lavender: PresetThemes.lavender
            case .brand:
                WhiteLabelConfiguration(
                    brand: BrandConfiguration(primaryColor: .purple, secondaryColor: .pink, borderRadius: 12),
                    appName: "Acme"
                ).lightTheme
            }
        }
    }

    @State private var choice = Choice.system

    var body: some View {
        Form {
            Picker("Theme", selection: $choice) {
                ForEach(Choice.allCases) { Text($0.rawValue).tag($0) }
            }
            Section("Read from the environment") {
                ThemeSummary()
            }
        }
        .onAppear { choice = Self.currentChoice() }
        .onChange(of: choice) { _, newValue in
            if let theme = newValue.theme {
                ThemeManager.shared.setTheme(theme)
            } else {
                ThemeManager.shared.followSystem = true
            }
        }
    }

    /// The picker entry for the theme the shared manager applies right now.
    private static func currentChoice() -> Choice {
        let manager = ThemeManager.shared
        guard !manager.followSystem else { return .system }
        return Choice.allCases.first { $0.theme?.id == manager.currentTheme.id } ?? .system
    }
}

/// What a custom view sees through `@Environment(\.dsTheme)`.
private struct ThemeSummary: View {
    @Environment(\.dsTheme) private var theme

    var body: some View {
        LabeledContent("Name", value: theme.name)
        LabeledContent("Identifier", value: theme.id)
        HStack(spacing: SpacingScale.sm.rawValue) {
            swatch(theme.colors.accent, "Accent")
            swatch(theme.colors.accentSecondary, "Secondary")
            swatch(theme.colors.backgroundPrimary, "Background")
            swatch(theme.colors.foregroundPrimary, "Text")
        }
    }

    private func swatch(_ color: Color, _ label: String) -> some View {
        VStack(spacing: SpacingScale.xs.rawValue) {
            RoundedRectangle(cornerRadius: BorderTokens.Radius.md)
                .fill(color)
                .overlay(RoundedRectangle(cornerRadius: BorderTokens.Radius.md).strokeBorder(.secondary.opacity(0.4)))
                .frame(width: 44, height: 44)
            Text(label).font(.caption2)
        }
        .accessibilityElement(children: .combine)
    }
}

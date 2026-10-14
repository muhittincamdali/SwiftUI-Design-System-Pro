import DesignSystemPro
import SwiftUI

@main
struct DesignSystemProDemoApp: App {
    var body: some Scene {
        WindowGroup {
            // DSApp installs the theme provider and the toast overlay.
            DSApp { DemoHomeView() }
        }
    }
}

enum DemoScreen: String, CaseIterable, Hashable {
    case quickStart
    case signIn
    case components
    case themes

    var title: String {
        switch self {
        case .quickStart: "Quick start"
        case .signIn: "Sign-in form"
        case .components: "Components"
        case .themes: "Themes"
        }
    }
}

/// The list of demo screens.
struct DemoHomeView: View {
    // `-DemoScreen components` on launch opens a screen directly, so
    // screenshots can be taken without tapping through the list.
    @State private var path = UserDefaults.standard.string(forKey: "DemoScreen")
        .flatMap(DemoScreen.init(rawValue:))
        .map { [$0] } ?? []

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Start here") {
                    NavigationLink(DemoScreen.quickStart.title, value: DemoScreen.quickStart)
                    NavigationLink(DemoScreen.signIn.title, value: DemoScreen.signIn)
                }
                Section("Explore") {
                    NavigationLink(DemoScreen.components.title, value: DemoScreen.components)
                    NavigationLink(DemoScreen.themes.title, value: DemoScreen.themes)
                }
            }
            .navigationTitle("DesignSystemPro")
            .navigationDestination(for: DemoScreen.self) { screen in
                destination(for: screen).navigationTitle(screen.title)
            }
        }
    }

    @ViewBuilder
    private func destination(for screen: DemoScreen) -> some View {
        switch screen {
        case .quickStart: ContentView()
        case .signIn: SignInView()
        case .components: ComponentsView()
        case .themes: ThemesView()
        }
    }
}

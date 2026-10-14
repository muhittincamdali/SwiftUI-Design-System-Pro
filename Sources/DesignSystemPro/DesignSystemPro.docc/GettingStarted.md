# Getting Started

Add the package, wrap your root view and use the first components.

## Add the package

In Xcode choose **File > Add Package Dependencies…** and enter
`https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git`, or add it to
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git", from: "2.0.0")
],
targets: [
    .target(name: "MyApp", dependencies: [
        .product(name: "DesignSystemPro", package: "SwiftUI-Design-System-Pro")
    ])
]
```

> Note: 2.0.0 is the first release with this API. Versions before it have the
> older 1.x API that this documentation does not describe.

## Wrap the root view

``DSApp`` installs ``DSThemeProvider`` and the toast overlay used by
``DSToastManager``:

```swift
import DesignSystemPro
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            DSApp { ContentView() }
        }
    }
}
```

Without ``DSApp`` the components still work; you only lose the shared toast
overlay and the `dsTheme` environment value.

## Use components

```swift
struct SignInView: View {
    @State private var email = ""
    @State private var isSubmitting = false

    var body: some View {
        VStack(spacing: SpacingTokens.Content.comfortable) {
            DSTextField("Email", text: $email, placeholder: "you@example.com")
            DSButton("Sign in", isFullWidth: true) {
                isSubmitting = true
                DSToastManager.shared.success("Signed in")
            }
            .loading(isSubmitting)
        }
        .padding(SpacingTokens.Layout.screenEdge)
    }
}
```

## Next steps

- <doc:BuildingAForm> combines these components into a validated form.
- <doc:UsingDesignTokens> explains the token families.
- <doc:Theming> covers presets, brand themes and the theme manager.

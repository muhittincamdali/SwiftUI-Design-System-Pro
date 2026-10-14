// The quick start example from README.md, step 3, unchanged.
import DesignSystemPro
import SwiftUI

struct ContentView: View {
    @State private var notificationsOn = true

    var body: some View {
        VStack(spacing: SpacingTokens.Content.comfortable) {
            Text("Hello, DesignSystemPro")
                .dsTypography(TypographyTokens.Heading.h2)

            DSStatusBadge("Ready", variant: .success)

            DSToggle(isOn: $notificationsOn, label: "Notifications")

            DSButton("Continue", isFullWidth: true) {
                notificationsOn.toggle()
            }
        }
        .padding(SpacingTokens.Layout.screenEdge)
    }
}

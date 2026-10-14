# Building a Form

Combine text input, validation, a loading button and a toast into one screen.

## Overview

Most screens built with DesignSystemPro follow the same pattern: tokens for
layout and type, components for the controls, ``DSInputState`` for
validation and ``DSToastManager`` for the result. This article builds a
newsletter sign-up card step by step. The finished view is at the end.

## Install the toast overlay once

Toasts are drawn by an overlay at the root of the app. Wrap the root view in
``DSApp`` (or add `.dsToastContainer()` yourself) as shown in
<doc:GettingStarted>. Without the overlay, ``DSToastManager`` still queues
toasts, but nothing appears on screen.

## Lay out with tokens

Use the spacing tokens instead of numbers so every screen has the same rhythm:
``SpacingTokens/Content/comfortable`` between controls and
``SpacingTokens/Layout/screenEdge`` around the screen. A ``DSCard`` with a
``DSCardHeader`` gives the form a title and a container that adapts to light
and dark mode.

## Validate as the user types

``DSTextField`` takes a ``DSInputState``. Compute it from the text, so the
field shows the error message or the valid style as soon as the input
changes:

```swift
private var emailState: DSInputState {
    if email.isEmpty { return .default }
    return email.contains("@") ? .valid : .error("Enter an email address")
}
```

## Show progress and the result

``DSButton`` shows a spinner and ignores taps while
``DSButton/loading(_:)`` is `true`, and it follows SwiftUI's `disabled(_:)`.
Report the outcome with ``DSToastManager``; the toast dismisses itself after
four seconds, the default ``DSToastData/duration``.

## The complete view

```swift
struct NewsletterSignUp: View {
    @State private var email = ""
    @State private var isSubmitting = false

    private var emailState: DSInputState {
        if email.isEmpty { return .default }
        return email.contains("@") ? .valid : .error("Enter an email address")
    }

    var body: some View {
        DSCard(variant: .outlined) {
            VStack(alignment: .leading, spacing: SpacingTokens.Content.comfortable) {
                DSCardHeader(title: "Newsletter", subtitle: "One email a month")

                DSTextField("Email", text: $email, placeholder: "you@example.com", state: emailState)

                DSButton("Subscribe", isFullWidth: true) {
                    isSubmitting = true
                    DSToastManager.shared.success("Subscribed", message: email)
                }
                .loading(isSubmitting)
                .disabled(!email.contains("@"))
            }
        }
        .padding(SpacingTokens.Layout.screenEdge)
    }
}
```

Check the view in both color schemes: add two Xcode previews, one of them
with `.environment(\.colorScheme, .dark)`. The components resolve their
colors from the environment, so no extra code is needed for dark mode.

## Next steps

- <doc:Theming> shows how to give your own views a preset or brand theme.
- The example app in `Examples/DesignSystemProDemo` has an interactive
  version of every component family.

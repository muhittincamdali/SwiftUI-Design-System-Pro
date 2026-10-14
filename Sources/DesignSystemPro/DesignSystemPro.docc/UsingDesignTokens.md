# Design Tokens

Named values for color, type, spacing, borders, shadows and motion.

## Colors

Colors come in two layers. ``PrimitiveColors`` holds the raw palette
(`PrimitiveColors.Blue.blue600`). ``ColorTokens`` maps it to roles such as
`ColorTokens.Background.primary`, `ColorTokens.Foreground.secondary` or
`ColorTokens.Status.error`. Each role is a ``SemanticColorToken`` with a light,
dark and high-contrast value:

```swift
@Environment(\.colorScheme) private var colorScheme

var body: some View {
    Text("Saved")
        .foregroundStyle(ColorTokens.Status.success.resolved(for: colorScheme))
}
```

The `dsForegroundColor(_:)` and `dsBackgroundColor(_:)` modifiers resolve a
token for the current color scheme and the `colorSchemeContrast` setting.

``ColorContrastUtility`` computes WCAG 2 contrast ratios. The test suite uses
it to check that body text and filled-button labels reach AA (4.5:1) in light
and dark mode.

## Typography

``TypographyTokens`` groups ``TypographyToken`` values into `Display`,
`Heading`, `Body`, `UI` and `Code`. Apply one with `dsTypography(_:)`:

```swift
Text("Settings").dsTypography(TypographyTokens.Heading.h2)
```

The modifier scales the point size and line spacing with the environment's
Dynamic Type size, using the ratios of the system body style. Use
``TypographyToken/scaledSize(for:)`` when you need the number yourself.

## Spacing, borders and shadows

- ``SpacingScale`` is a 2-point-based scale from `none` (0) to
  `astronomical` (96); ``SpacingTokens`` names common uses such as
  `SpacingTokens.Layout.screenEdge`.
- ``BorderTokens`` provides corner radii and border widths.
- ``ShadowTokens`` defines multi-layer shadows; ``Elevation`` maps levels 0–5
  to them. `dsShadow(_:)` applies a shadow and strengthens it in dark mode.

## Motion

``AnimationTokens`` and ``SpringConfig`` provide durations, curves and spring
presets. The view helpers always take the value that drives the animation:

```swift
Circle()
    .scaleEffect(isActive ? 1.2 : 1)
    .dsSpring(.bouncy, value: isActive)
```

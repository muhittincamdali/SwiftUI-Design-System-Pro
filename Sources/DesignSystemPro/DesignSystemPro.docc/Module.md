# ``DesignSystemPro``

Design tokens, a theme engine and a set of SwiftUI components built on them.

## Overview

DesignSystemPro has three layers:

- **Tokens** define colors, typography, spacing, borders, shadows and animation
  timing. Color tokens carry a light, dark and high-contrast value.
- **Theme engine** groups token values into themes (light, dark, presets or
  generated from a brand color) and exposes the active theme through the
  SwiftUI environment.
- **Components** such as ``DSButton``, ``DSTextField`` and ``DSCard`` are
  built from the tokens and resolve their colors from the current
  `colorScheme`.

Components read color tokens directly; they do not read the active theme. Use
the theme (`@Environment(\.dsTheme)`) for your own views.

## Topics

### Essentials

- <doc:GettingStarted>
- <doc:UsingDesignTokens>
- <doc:Theming>

### Setup

- ``DesignSystemPro/DesignSystemPro``
- ``DSApp``

### Color

- ``ColorTokens``
- ``PrimitiveColors``
- ``SemanticColorToken``
- ``ColorToken``
- ``ColorContrastUtility``

### Typography

- ``TypographyTokens``
- ``TypographyToken``
- ``TypeScale``
- ``FluidTypography``

### Spacing, borders and elevation

- ``SpacingScale``
- ``SpacingTokens``
- ``BorderTokens``
- ``ShadowTokens``
- ``Elevation``

### Motion

- ``AnimationTokens``
- ``SpringConfig``
- ``TransitionTokens``

### Theming

- ``DSTheme``
- ``ThemeManager``
- ``DSThemeProvider``
- ``LightTheme``
- ``DarkTheme``
- ``CustomTheme``
- ``PresetThemes``
- ``BrandConfiguration``
- ``WhiteLabelConfiguration``

### Buttons

- ``DSButton``
- ``DSIconButton``
- ``DSButtonGroup``

### Text input

- ``DSTextField``
- ``DSTextArea``
- ``DSSearchField``
- ``DSOTPField``

### Selection

- ``DSToggle``
- ``DSSwitch``
- ``DSCheckbox``
- ``DSCheckboxGroup``
- ``DSRadio``
- ``DSRadioGroup``

### Content

- ``DSCard``
- ``DSCardHeader``
- ``DSStatCard``
- ``DSMediaCard``
- ``DSListCard``
- ``DSBadge``
- ``DSCounterBadge``
- ``DSStatusBadge``
- ``DSTag``
- ``DSAvatar``
- ``DSAvatarGroup``

### Feedback and loading

- ``DSToastManager``
- ``DSToastData``
- ``DSToastContainer``
- ``DSSnackbar``
- ``DSSkeleton``
- ``DSSkeletonText``
- ``DSConditionalSkeleton``

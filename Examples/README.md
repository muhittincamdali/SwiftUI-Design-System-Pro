# Examples

## DesignSystemProDemo

An iOS and macOS app that uses the package from this checkout (`../..`), so it always builds
against the current sources.

| Screen       | What it shows                                                                                                               |
| ------------ | --------------------------------------------------------------------------------------------------------------------------- |
| Quick start  | The `ContentView` from the README quick start, unchanged                                                                    |
| Sign-in form | The README usage example: text field, loading button, toast, avatar and badge                                               |
| Components   | One interactive example per component family, including toasts and skeleton loading                                         |
| Themes       | Switches `ThemeManager.shared` between the system, preset and brand themes and shows what `@Environment(\.dsTheme)` returns |

### Run it

1. Open `Examples/DesignSystemProDemo/DesignSystemProDemo.xcodeproj` in Xcode 26 or later.
2. Choose the **DesignSystemProDemo** scheme and an iPhone simulator (or **My Mac**).
3. Press **Run** (⌘R).

From the command line:

```sh
xcodebuild build -project Examples/DesignSystemProDemo/DesignSystemProDemo.xcodeproj \
  -scheme DesignSystemProDemo -destination 'generic/platform=iOS Simulator'
```

The project file is generated from `project.yml` with [XcodeGen](https://github.com/yonaskolb/XcodeGen).
It is committed, so you only need XcodeGen after changing `project.yml`.

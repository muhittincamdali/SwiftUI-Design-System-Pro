# Contributing

Bug reports and pull requests are welcome.

## Development setup

Requirements: Xcode 26 or later (the package uses swift-tools-version 6.0).
The package is developed with Xcode 27. CI runs on GitHub's `macos-26` runner
with the image's default Xcode, through the shared workflows in
[muhittincamdali/.github](https://github.com/muhittincamdali/.github):

- `ci.yml`: `swift build` and `swift test` on macOS, the tests on an iOS
  simulator, and builds for iOS, macOS, tvOS, watchOS and visionOS.
- `docs.yml`: builds the DocC catalog and publishes it to GitHub Pages.
- `quality.yml`: link check, wording check and README translation check.
- `examples.yml`: builds `Examples/DesignSystemProDemo` for iOS and macOS.

```bash
git clone https://github.com/muhittincamdali/SwiftUI-Design-System-Pro.git
cd SwiftUI-Design-System-Pro
swift build
swift test
```

To run the tests on an iOS simulator:

```bash
xcodebuild test -scheme SwiftUI-Design-System-Pro \
  -destination 'platform=iOS Simulator,name=<simulator name>'
```

The rendering tests compare every gallery section against a coarse
fingerprint (size and an 8x8 grid of average colors) in
`Tests/RenderingReferences/<platform>`. If you change how a component looks,
record new references on macOS and iOS and commit them together with the
change:

```bash
DSP_RECORD_FINGERPRINTS=1 swift test --filter RenderingTests
TEST_RUNNER_DSP_RECORD_FINGERPRINTS=1 xcodebuild test -scheme SwiftUI-Design-System-Pro \
  -destination 'platform=iOS Simulator,name=<simulator name>' \
  -only-testing:DesignSystemProTests/RenderingTests
```

Then regenerate the README screenshots with `scripts/render-screenshots.sh`
and commit the updated files in `docs/images`.

## Pull requests

1. Create a branch from `main`.
2. Add or update tests for behaviour changes (`Tests/DesignSystemProTests`).
3. Make sure `swift test` passes; CI also builds for iOS, tvOS, watchOS and visionOS
   and builds the example app.
   If you have [SwiftLint](https://github.com/realm/SwiftLint) installed, run
   `swiftlint lint` (configuration in `.swiftlint.yml`); it should report no
   violations.
4. Use [Conventional Commits](https://www.conventionalcommits.org/) for commit
   messages (`feat:`, `fix:`, `docs:`, `test:`, `ci:`, `chore:`).
5. Add a line to the `Unreleased` section of `CHANGELOG.md`.

## README translations

`README.md` is the source; `README.<lang>.md` are translations. Each starts
with a marker naming the `README.md` version it follows, and `quality.yml`
fails while a translation is behind. If you change `README.md` you do not
have to update the translations yourself; say so in the pull request. If you
do update one, keep code blocks and links identical to the English file.

## Code of conduct and security

This project follows the shared
[code of conduct](https://github.com/muhittincamdali/.github/blob/main/CODE_OF_CONDUCT.md).
Report security issues privately as described in the
[security policy](https://github.com/muhittincamdali/.github/blob/main/SECURITY.md).

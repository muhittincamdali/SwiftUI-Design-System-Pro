# Contributing

Bug reports and pull requests are welcome.

## Development setup

Requirements: an Xcode version with a Swift 6 toolchain (the package uses
swift-tools-version 6.0). Local development uses Xcode 27; CI uses the
default Xcode of the GitHub `macos-26` runner.

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
3. Make sure `swift test` passes; CI also builds for iOS, tvOS, watchOS and visionOS.
4. Use [Conventional Commits](https://www.conventionalcommits.org/) for commit
   messages (`feat:`, `fix:`, `docs:`, `test:`, `ci:`, `chore:`).
5. Add a line to the `Unreleased` section of `CHANGELOG.md`.

## Code of conduct

This project follows the [Code of Conduct](CODE_OF_CONDUCT.md).

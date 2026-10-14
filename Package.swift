// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftUI-Design-System-Pro",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "DesignSystemPro", targets: ["DesignSystemPro"])
    ],
    dependencies: [
        // Only used by `swift package generate-documentation`; not linked into the library.
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.0")
    ],
    targets: [
        .target(
            name: "DesignSystemPro",
            path: "Sources/DesignSystemPro"
        ),
        .testTarget(
            name: "DesignSystemProTests",
            dependencies: ["DesignSystemPro"],
            path: "Tests/DesignSystemProTests"
        )
    ]
)

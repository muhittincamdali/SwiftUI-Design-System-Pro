// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SwiftUI-Design-System-Pro",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "DesignSystemPro", targets: ["DesignSystemPro"]),
    ],
    targets: [
        .target(
            name: "DesignSystemPro",
            path: "Sources/DesignSystemPro",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "DesignSystemProTests",
            dependencies: ["DesignSystemPro"]
        )
    ]
)

// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUI-Design-System-Pro",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "DesignSystemPro",
            targets: ["DesignSystemPro"]
        ),
        .library(
            name: "DesignSystemProCore",
            targets: ["DesignSystemProCore"]
        ),
        .library(
            name: "DesignSystemProComponents",
            targets: ["DesignSystemProComponents"]
        ),
        .library(
            name: "DesignSystemProTheme",
            targets: ["DesignSystemProTheme"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "DesignSystemPro",
            dependencies: [
                "DesignSystemProCore",
                "DesignSystemProComponents",
                "DesignSystemProTheme"
            ],
            path: "Sources/DesignSystemPro"
        ),
        .target(
            name: "DesignSystemProCore",
            dependencies: [
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Algorithms", package: "swift-algorithms")
            ],
            path: "Sources/Core"
        ),
        .target(
            name: "DesignSystemProComponents",
            dependencies: ["DesignSystemProCore"],
            path: "Sources/Components"
        ),
        .target(
            name: "DesignSystemProTheme",
            dependencies: ["DesignSystemProCore"],
            path: "Sources/Theme"
        ),
        .testTarget(
            name: "DesignSystemProTests",
            dependencies: ["DesignSystemPro"],
            path: "Tests/UnitTests"
        ),
        .testTarget(
            name: "DesignSystemProUITests",
            dependencies: ["DesignSystemPro"],
            path: "Tests/UITests"
        ),
        .testTarget(
            name: "DesignSystemProPerformanceTests",
            dependencies: ["DesignSystemPro"],
            path: "Tests/PerformanceTests"
        )
    ]
) 
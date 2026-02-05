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
        // Complete design system
        .library(
            name: "DesignSystemPro",
            targets: ["DesignSystemPro"]
        ),
        // Core tokens only (for custom implementations)
        .library(
            name: "DesignSystemProCore",
            targets: ["DesignSystemProCore"]
        ),
        // Components only (requires Core)
        .library(
            name: "DesignSystemProComponents",
            targets: ["DesignSystemProComponents"]
        ),
        // Theme engine only (requires Core)
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
        // Main target - exports everything
        .target(
            name: "DesignSystemPro",
            dependencies: [
                "DesignSystemProCore",
                "DesignSystemProComponents",
                "DesignSystemProTheme"
            ],
            path: "Sources/DesignSystemPro"
        ),
        
        // Core tokens and utilities
        .target(
            name: "DesignSystemProCore",
            dependencies: [
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Algorithms", package: "swift-algorithms")
            ],
            path: "Sources/Core"
        ),
        
        // UI Components
        .target(
            name: "DesignSystemProComponents",
            dependencies: ["DesignSystemProCore"],
            path: "Sources/Components"
        ),
        
        // Theme engine
        .target(
            name: "DesignSystemProTheme",
            dependencies: ["DesignSystemProCore"],
            path: "Sources/Theme"
        ),
        
        // Unit Tests
        .testTarget(
            name: "DesignSystemProTests",
            dependencies: ["DesignSystemPro"],
            path: "Tests/UnitTests"
        ),
        
        // UI Tests
        .testTarget(
            name: "DesignSystemProUITests",
            dependencies: ["DesignSystemPro"],
            path: "Tests/UITests"
        ),
        
        // Performance Tests
        .testTarget(
            name: "DesignSystemProPerformanceTests",
            dependencies: ["DesignSystemPro"],
            path: "Tests/PerformanceTests"
        )
    ]
)

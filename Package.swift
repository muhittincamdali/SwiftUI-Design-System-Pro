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

// swift-tools-version:6.4

import PackageDescription

let package = Package(
    name: "ProgressionKit",
    platforms: [
        .iOS(.v27),
        .macOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27)
    ],
    products: [
        .library(
            name: "ProgressionKit",
            targets: ["ProgressionKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.5.0")
    ],
    targets: [
        .target(
            name: "ProgressionKit"
        ),
        .testTarget(
            name: "ProgressionKitTests",
            dependencies: ["ProgressionKit"]
        )
    ]
)

// swift-tools-version:6.4

import PackageDescription

let package = Package(
    name: "ProgressionKit",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
    ],
    products: [
        .library(
            name: "ProgressionKit",
            targets: ["ProgressionKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/thatfactory/applogger", from: "1.1.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.5.0"),
    ],
    targets: [
        .target(
            name: "ProgressionKit",
            dependencies: [
                .product(
                    name: "AppLogger",
                    package: "applogger"
                )
            ]
        ),
        .testTarget(
            name: "ProgressionKitTests",
            dependencies: [
                "ProgressionKit",
                .product(
                    name: "AppLogger",
                    package: "applogger"
                ),
            ]
        ),
    ]
)

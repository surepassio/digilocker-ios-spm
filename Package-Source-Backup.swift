// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DigilockerSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "DigilockerSDK",
            targets: ["DigilockerSDK"]
        ),
    ],
    dependencies: [
        // Add external dependencies here if needed
    ],
    targets: [
        // Source target for development
        .target(
            name: "DigilockerSDK",
            dependencies: [],
            path: "Sources/DigilockerSDK",
            resources: [
                .process("Resources")
            ]
        ),
        
        .testTarget(
            name: "DigilockerSDKTests",
            dependencies: ["DigilockerSDK"],
            path: "Tests/DigilockerSDKTests"
        ),
    ]
)

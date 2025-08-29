// swift-tools-version: 5.7
// Binary distribution Package.swift for production use

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
    targets: [
        .binaryTarget(
            name: "DigilockerSDK",
            path: "DigilockerSDK.xcframework"
        ),
    ]
)
// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sassci",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.1"),
        .package(url: "https://github.com/koher/swift-image.git", from: "0.7.1"),
    ],
    targets: [
        .executableTarget(name: "Sassci", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .product(name: "SwiftImage", package: "swift-image"),
        ]),
    ]
)

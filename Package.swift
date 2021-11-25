// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TSKit.Core",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "TSKit.Core",
            targets: ["TSKit.Core"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TSKit.Core",
            dependencies: ["TSKit.Core.ObjC"]),
        .target(
            name: "TSKit.Core.ObjC",
            dependencies: []),
        .testTarget(
            name: "TSKit.CoreTests",
            dependencies: ["TSKit.Core"]),
    ]
)

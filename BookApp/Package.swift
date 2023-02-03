// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookApp",
    defaultLocalization: "en",
    products: [
        .library(
            name: "AppFeature", targets: ["AppFeature"]),
        .library(
            name: "Common", targets: ["Common"]),
        .library(
            name: "UI", targets: ["UI"]),
        .library(
            name: "CategoryFeature",
            targets: ["CategoryFeature"]),
    ],
    dependencies: [
       
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: ["Common",  "UI", "CategoryFeature"]),
        .target(
            name: "CategoryFeature",
            dependencies: ["Common",  "UI"]),
        .target(
            name: "Common",
            dependencies: []),
        .target(
            name: "UI",
            dependencies: [
                "Common",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)

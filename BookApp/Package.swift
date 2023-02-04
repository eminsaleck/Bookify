// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookApp",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
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
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]),
        .library(
            name: "CollectionFeature",
            targets: ["CollectionFeature"]),
        .library(
            name: "CollectionFeatureInterface",
            targets: ["CollectionFeatureInterface"]),
        
    ],
    dependencies: [
       
    ],
    targets: [
        .target(
            name: "CollectionFeature",
            dependencies: [
              "Common",
              "CollectionFeatureInterface",
              "UI"
            ]),
        .target(
            name: "CollectionFeatureInterface",
            dependencies: [
                "Network",
                "Common"
            ]),
        .target(
            name: "NetworkManager",
            dependencies: [
                "Network"
            ]),
        .target(
            name: "Network",
            dependencies: []),
        .target(
            name: "AppFeature",
            dependencies: [
                "Common",
                "UI",
                "CategoryFeature",
                "Network",
                "NetworkManager",
                "CollectionFeatureInterface",
                "CollectionFeature",
            ]),
        .target(
            name: "CategoryFeature",
            dependencies: [
                "CollectionFeatureInterface",
                "Common",
                "UI",
                "NetworkManager",
                "Network",
            ]),
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

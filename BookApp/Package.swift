// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookApp",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
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
            name: "Persistance",
            targets: ["Persistance"]),
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
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.6.1"),
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.35.1"),
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
            name: "Persistance",
            dependencies: [
                "Network",
                .product(name: "RealmSwift", package: "realm-swift"),
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
                "Persistance",
                "Common",
                "UI",
                "CategoryFeature",
                "Network",
                "NetworkManager",
                "CollectionFeatureInterface",
                "CollectionFeature",
            ]
        ),
        .target(
            name: "CategoryFeature",
            dependencies: [
                "CollectionFeatureInterface",
                "Persistance",
                "Common",
                "UI",
                "NetworkManager",
                "Network",
                .product(name: "RealmSwift", package: "realm-swift"),
            ]),
        .target(
            name: "Common",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
            ]),
        .target(
            name: "UI",
            dependencies: [
                "Common",
                "Kingfisher",
            ],
            resources: [
                .process("Resources"),
            ]
        )
    ]
)

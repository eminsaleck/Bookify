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
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.50.3/SwiftLintBinary-macos.artifactbundle.zip",
            checksum: "abe7c0bb505d26c232b565c3b1b4a01a8d1a38d86846e788c4d02f0b1042a904"
        ),
        .plugin(
            name: "SwiftLintXcode",
            capability: .buildTool(),
            dependencies: ["SwiftLintBinary"]
        ),
        .target(
            name: "CollectionFeature",
            dependencies: [
                "Common",
                "Persistance",
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
            dependencies: [],
            plugins: ["SwiftLintXcode"]
        ),
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
                "Persistance",
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

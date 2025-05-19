// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-collection-advance",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "CollectionAdvance",
            targets: ["CollectionAdvance"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CollectionAdvance",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "CollectionAdvanceTests",
            dependencies: ["CollectionAdvance"],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)

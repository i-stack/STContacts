// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "STContacts",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "STContacts",
            targets: ["STContacts"]
        ),
    ],
    targets: [
        .target(
            name: "STContacts",
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

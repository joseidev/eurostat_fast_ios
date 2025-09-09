// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EurostatFastApp",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "EurostatFastApp",
            targets: ["Data", "Domain", "UI"]
        ),
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: ["Domain"]
        ),
        .target(
            name: "Domain"
        ),
        .target(
            name: "UI"
        ),
    ]
)

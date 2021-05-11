// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ActionTest",
    products: [
        .library(
            name: "ActionTest",
            targets: ["ActionTest"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/ShellOut", .branch("master"))
    ],
    targets: [
        .target(
            name: "ActionTest",
            dependencies: [
                .product(name: "ShellOut", package: "ShellOut")
            ]
        ),
        .testTarget(name: "ActionTestTests",
                    dependencies: ["ActionTest"])
    ]
)

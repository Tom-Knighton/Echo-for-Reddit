// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Posts",
    platforms: [.iOS(.v26)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Posts",
            targets: ["Posts"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "1.0.0"
        ),
        .package(url: "https://github.com/pzmudzinski/OpenGraphReader.git", .upToNextMajor(from: "1.0.0")),
        .package(path: "API"),
        .package(path: "Env"),
        .package(path: "Design"),
        .package(path: "Models"),
        .package(url: "https://github.com/Tom-Knighton/RedditMarkdownView.git", .upToNextMajor(from: "0.1.4"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Posts",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),
                .product(name: "OpenGraphReader", package: "OpenGraphReader"),
                "API",
                "Env",
                "Design",
                "Models",
                "RedditMarkdownView"
            ]),
        
    ]
)

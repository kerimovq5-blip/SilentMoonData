// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SilentMoonData",
    platforms: [
        .iOS(.v16)]
    ,
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SilentMoonData",
            targets: ["SilentMoonData"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kerimovq5-blip/SilentMoonNetwork",
                 revision: "f626055bbd7490a28829b5e50901180ace7f11d1"
                ),
        .package(
            url: "https://github.com/kerimovq5-blip/SilentMoonDomain" ,
            revision: "11ac3bab78ed7551482ab46f6463af6d18c21892"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SilentMoonData" ,
            dependencies: [
                .product(name: "SilentMoonNetwork", package: "SilentMoonNetwork") ,
                .product(name: "SilentMoonDomain", package: "SilentMoonDomain")
            ]
        ),

    ],
    swiftLanguageModes: [.version("6.0")]
)

// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Capable",
    platforms: [
        .macOS(.v10_13), .iOS(.v12), .tvOS(.v12), .watchOS(.v4),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Capable",
            targets: ["Capable"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.2.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Capable",
            dependencies: []
        ),
        .testTarget(
            name: "CapableTests",
            dependencies: ["Capable", "Quick", "Nimble"],
            linkerSettings: [.linkedFramework("Foundation")]
        ),
    ]
)

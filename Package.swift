// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Capable",
    platforms: [
        .macOS(.v10_12), .iOS(.v10), .tvOS(.v10), .watchOS(.v4),
    ],
    products: [
        .library(
            name: "Capable",
            targets: ["Capable"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "2.2.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.4"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.40.13"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.34.0"),
        .package(url: "https://github.com/orta/Komondor", from: "1.0.4"),
        .package(url: "https://github.com/eneko/SourceDocs.git", from: "0.5.1"),
    ],
    targets: [
        .target(
            name: "Capable",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "CapableTests",
            dependencies: ["Capable", "Quick", "Nimble"],
            path: "Example/Tests"
        ),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfig([
        "komondor": [
            "pre-commit": [
                "swift run swiftformat .",
                "swift run swiftlint autocorrect --path SheetyColors/",
                "swift run sourcedocs generate -- -workspace Example/SheetyColors.xcworkspace -scheme SheetyColors",
                "git add .",
            ],
        ],
    ])
#endif

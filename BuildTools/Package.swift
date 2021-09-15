// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v10_11)],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.48.11"),
        .package(url: "https://github.com/Realm/SwiftLint", from: "0.43.1"),
        .package(url: "https://github.com/orta/Komondor", from: "1.1.0"),
        .package(url: "https://github.com/eneko/SourceDocs.git", from: "1.2.1"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-commit": [
                // "swift run swiftlint ../ --config ../.swiftlint",
                "swift run swiftformat ../ --config ../.swiftformat",
                // "swift run sourcedocs generate --input-folder ../ --spm-module Capable",
            ],
        ],
    ]).write()
#endif

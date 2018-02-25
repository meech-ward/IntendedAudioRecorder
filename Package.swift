// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IntendedAudioRecorder",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "IntendedAudioRecorder",
            targets: ["IntendedAudioRecorder"]),
    ],
    dependencies: [
      .package(url: "https://github.com/meech-ward/ObserveFocusCleanReporter", from: "0.1.2"),
      .package(url: "https://github.com/meech-ward/Observe", from: "0.5.1"),
      .package(url: "https://github.com/meech-ward/Focus", from: "0.6.2"),
      .package(url: "../../Entities/AudioIO", .branch("develop")),
      .package(url: "../../Entities/AudioProcessor", from: "0.3.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "IntendedAudioRecorder",
            dependencies: ["AudioIO", "AudioProcessor"]),
        .testTarget(
            name: "IntendedAudioRecorderTests",
            dependencies: ["IntendedAudioRecorder", "CleanReporter", "Observe", "Focus", "AudioIO", "AudioProcessor"]),
    ]
)

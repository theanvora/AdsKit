// swift-tools-version: 6.2
import PackageDescription

let concurrencyBaseline: [SwiftSetting] = [
    .swiftLanguageMode(.v6),
    .defaultIsolation(nil),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("InferIsolatedConformances"),
]

let package = Package(
    name: "AdsKit",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AnvyxAdsCore", targets: ["AnvyxAdsCore"]),
    ],
    targets: [
        .target(name: "AnvyxAdsCore", swiftSettings: concurrencyBaseline),
        .testTarget(name: "AnvyxAdsCoreTests", dependencies: ["AnvyxAdsCore"], swiftSettings: concurrencyBaseline),
    ]
)

// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AdsKit",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AnvyxAdsCore", targets: ["AnvyxAdsCore"]),
    ],
    targets: [
        .target(name: "AnvyxAdsCore"),
        .testTarget(name: "AnvyxAdsCoreTests", dependencies: ["AnvyxAdsCore"]),
    ]
)

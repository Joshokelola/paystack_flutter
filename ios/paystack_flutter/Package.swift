// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "paystack_flutter",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(name: "paystack-flutter", targets: ["paystack_flutter"])
    ],
    dependencies: [
        .package(url: "https://github.com/PaystackHQ/paystack-sdk-ios.git", .upToNextMajor(from: "0.0.4")),
    ],
    targets: [
        .target(
            name: "paystack_flutter",
            dependencies: [
                .product(name: "PaystackCore", package: "paystack-sdk-ios"),
                .product(name: "PaystackUI", package: "paystack-sdk-ios")
            ],
            resources: []
        )
    ]
)

// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "chat-kit",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(name: "TeamsKit", targets: ["TeamsKit"]),
        .library(name: "SlackKit", targets: ["SlackKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", from: "1.1.0")
    ],
    targets: [
        .target(name: "SlackKit", dependencies: [
            
        ]),
        .target(name: "TeamsKit", dependencies: [
            .product(name: "Crypto", package: "swift-crypto")
        ]),
        .testTarget(name: "SlackKitTests", dependencies: [
            .target(name: "SlackKit")
        ]),
        .testTarget(name: "TeamsKitTests", dependencies: [
            .target(name: "TeamsKit")
        ])
    ]
)

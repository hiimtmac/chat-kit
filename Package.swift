// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "chat-kit",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "TeamsKit", targets: ["TeamsKit"]),
        .library(name: "SlackKit", targets: ["SlackKit", "BlockKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", from: "4.1.0")
    ],
    targets: [
        .target(name: "BlockKit", dependencies: [
            
        ]),
        .target(name: "SlackKit", dependencies: [
            .target(name: "BlockKit")
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

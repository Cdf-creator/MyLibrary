// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import Foundation
import PackageDescription

let SCADE_SDK = ProcessInfo.processInfo.environment["SCADE_SDK"] ?? ""

let swiftSettings: [SwiftSetting] = [
  .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS])),
  .unsafeFlags(["-I", "\(SCADE_SDK)/include"], .when(platforms: [.android])),
]

let linkerSettings: [LinkerSetting] = [
  .unsafeFlags(["-F", SCADE_SDK], .when(platforms: [.macOS, .iOS]))
]

let package = Package(
  name: "EuropeanCountries",
  platforms: [
    .macOS(.v10_14), .iOS(.v12),
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "EuropeanCountries",
      targets: ["EuropeanCountries"])
  ],
  dependencies: [
    .package(
      name: "ScadeExtensions", url: "https://github.com/scade-platform/ScadeExtensions",
      .branch("main"))
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "EuropeanCountries",
      dependencies: ["ScadeExtensions"],
      swiftSettings: swiftSettings,
      linkerSettings: linkerSettings)
  ]
)

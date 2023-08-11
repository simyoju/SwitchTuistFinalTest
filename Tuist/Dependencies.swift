// Dependencies.swift
import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        .remote(url: "https://github.com/ReactiveX/RxSwift.git",
                requirement: .exact("5.1.1")),
    ]),
    platforms: [.iOS]
)

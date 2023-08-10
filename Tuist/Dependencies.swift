// Dependencies.swift
import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies([
        .remote(url: "https://github.com/ReactiveX/RxSwift.git",
                requirement: .exact("5.1.1")),
//        .remote(url: "https://github.com/MatthewYork/DateTools",
//                requirement: .upToNextMajor(from: "1.0.0")),
    ]),
    platforms: [.iOS]
)

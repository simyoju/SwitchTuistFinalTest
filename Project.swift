// Project.swift
// swift-tools-version:5.8

import ProjectDescription

let project = Project(
    name: "SwitchTuistFinalTest",
    organizationName: "hyoju sim",
    packages: [
        .remote(url: "https://github.com/DragonCherry/AssetsPickerViewController",
                requirement: .upToNextMajor(from: "2.9.3")),
    ],
    settings: baseSettings(),
    targets: [
        Target(
            name: "SwitchTuistFinalTest",
            platform: .iOS,
            product: .app,
            bundleId: "switchTuistFinalTest.simyo.com",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: [.iphone, .ipad]),
            infoPlist: "SwitchTuistFinalTest/Info.plist",
            sources: ["SwitchTuistFinalTest/**"],
            resources: [
                "SwitchTuistFinalTest/Assets.xcassets",
                "SwitchTuistFinalTest/Base.lproj/**",
                "SwitchTuistFinalTest/Objc/**",
            ],
            dependencies: setupDependencies()
        )
    ]
)

private func baseSettings() -> Settings {
    var settings = SettingsDictionary()
    return Settings.settings(base: settings,
                             configurations: [
                                .debug(name: "Debug", xcconfig: .relativeToRoot("SwitchTuistFinalTest.xcconfig"))
                             ],
                             defaultSettings: .recommended(excluding: ["ASSETCATALOG_COMPILER_APPICON_NAME"])
    )
}

private func setupDependencies() -> [TargetDependency] {
    return [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .package(product: "AssetsPickerViewController"),
        .xcframework(path: "Xcframework/DateToolsSwift.xcframework")
    ]
}

    ]
}

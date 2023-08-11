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
//            infoPlist: "SwitchTuistFinalTest/Info.plist",
            infoPlist: setupInfoPlist(),
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

private func setupInfoPlist(merging other: [String: InfoPlist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: InfoPlist.Value] = [
        "UIApplicationSceneManifest": [
            "UIAppliactionSupportsMultipleScenes": true,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
                        "UISceneStoryboardFile": "Main"
                    ],
                ]
            ]
        ],
        "UILaunchScreen": [],
        "UISupportedInterfaceOrientations":
            [
                "UIInterfaceOrientationPortrait",
            ],
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleVersion": "1",
        "CFBundleDisplayName": "simyo",
    ]
    
    other.forEach { (key: String, value: InfoPlist.Value) in
        extendedPlist[key] = value
    }
    
    return InfoPlist.extendingDefault(with: extendedPlist)
}

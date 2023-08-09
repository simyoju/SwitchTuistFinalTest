// Project.swift


import ProjectDescription

let project = Project(
    name: "SwitchTuistFinalTest",
    organizationName: "hyoju sim",
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
            ],
            dependencies: []
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

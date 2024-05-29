import ProjectDescription

let project = Project(
    name: "UIPractice",
    targets: [
        .target(
            name: "UIPractice",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.UIPractice",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["UIPractice/Sources/**"],
            resources: ["UIPractice/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "UIPracticeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.UIPracticeTests",
            infoPlist: .default,
            sources: ["UIPractice/Tests/**"],
            resources: [],
            dependencies: [.target(name: "UIPractice")]
        ),
    ]
)

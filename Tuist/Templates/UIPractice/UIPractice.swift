//
//  UIPractice.swift
//  Packages
//
//  Created by 이숭인 on 5/30/24.
//

import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "ui practice",
    attributes: [nameAttribute, .optional("platform", default: "iOS")],
    items: [
        .file(path: "UIPractice/Sources/AppDelegate.swift",
              templatePath: "AppDelegate.stencil"),
        .file(path: "UIPractice/Sources/LaunchScreen.storyboard",
              templatePath: "LaunchScreen.stencil"),
    ]
)


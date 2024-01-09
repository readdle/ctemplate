// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let target: String
#if TARGET_ANDROID
target = "android"
#else
target = "apple"
#endif

let package = Package(
    name: "ctemplate",
    products: [
        .library(name: "ctemplate", type: .static, targets: ["ctemplate"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ctemplate",
            path: ".",
            sources: [
                "src/htmlparser/htmlparser.cc",
                "src/htmlparser/jsparser.cc",
                "src/htmlparser/statemachine.cc",
                "src/base/arena.cc",
                "src/per_expand_data.cc",
                "src/template.cc",
                "src/template_dictionary.cc",
                "src/template_pathops.cc",
                "src/template_annotator.cc",
                "src/template_modifiers.cc",
                "src/template_string.cc",
                "src/template_cache.cc",
                "src/template_namelist.cc",
            ],
            publicHeadersPath: "include/\(target)",
            cSettings: [
                .headerSearchPath("config/\(target)"),
                .headerSearchPath("src")
            ]
        )
    ]
)
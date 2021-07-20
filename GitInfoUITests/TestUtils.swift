//
//  TestUtils.swift
//  GitInfoUITests
//
//  Created by Sergey Kovalchyk on 20.07.2021.
//

import UIKit
import SnapshotTesting

let timeout = 60.0
private let configs: [(ViewImageConfig, String)] = [
    (.iPhone8, "iPhone8"),
    (.iPhoneX, "iPhoneX"),
    (.iPhoneXr, "iPhoneXR"),
]

func assertSnapshot(viewController: UIViewController,
                    testSuffix: String? = nil,
                    file: StaticString = #file,
                    isRecording: Bool = false) {
    UIView.setAnimationsEnabled(false)
    for (config, name) in configs {
        var testName = "\(viewController.className)_\(name)"
        if let testSuffix = testSuffix {
            testName += "_\(testSuffix)"
        }
        assertSnapshot(
            matching: viewController,
            as: .image(on: config, precision: 1.0),
            record: isRecording,
            file: file,
            testName: testName
        )
    }
    UIView.setAnimationsEnabled(true)
}


//
//  Lab10_2024_WatchApp_Watch_AppUITestsLaunchTests.swift
//  Lab10_2024 WatchApp Watch AppUITests
//
//  Created by IMD 224 on 2024-04-03.
//

import XCTest

final class Lab10_2024_WatchApp_Watch_AppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

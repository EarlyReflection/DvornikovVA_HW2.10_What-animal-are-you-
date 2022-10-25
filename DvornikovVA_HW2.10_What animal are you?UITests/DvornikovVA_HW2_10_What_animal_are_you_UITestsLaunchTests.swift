//
//  DvornikovVA_HW2_10_What_animal_are_you_UITestsLaunchTests.swift
//  DvornikovVA_HW2.10_What animal are you?UITests
//
//  Created by Vladimir Dvornikov on 25.10.2022.
//

import XCTest

class DvornikovVA_HW2_10_What_animal_are_you_UITestsLaunchTests: XCTestCase {

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

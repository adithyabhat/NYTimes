//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Adithya Bhat on 13/01/2022.
//

import XCTest

class NYTimesUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAppFlow() {
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Melatonin Isn’t a Sleeping Pill. Here’s How to Use It."]/*[[".cells.staticTexts[\"Melatonin Isn’t a Sleeping Pill. Here’s How to Use It.\"]",".staticTexts[\"Melatonin Isn’t a Sleeping Pill. Here’s How to Use It.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Melatonin Isn’t a Sleeping Pill. Here’s How to Use It."].buttons["NY Times Most Popular"].tap()
    }
}

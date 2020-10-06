//
//  MemoryCardUITests.swift
//  MemoryCardUITests
//
//  Created by Oscar A on 27/05/20.
//  Copyright © 2020 Oscar A. All rights reserved.
//

import XCTest

class MemoryCardUITests: XCTestCase {

    override func setUpWithError() throws {
        XCUIApplication().terminate()
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        XCUIApplication().terminate()
    }

    func testExample() throws {
        let app = XCUIApplication()
        XCTAssert(app.staticTexts["Remember the cards and find the pairs"].exists)
        XCTAssert(app.buttons["Random"].exists)
        XCTAssert(app.buttons["Halloween"].exists)
        XCTAssert(app/*@START_MENU_TOKEN@*/.staticTexts["Animals"]/*[[".buttons[\"Animals\"].staticTexts[\"Animals\"]",".staticTexts[\"Animals\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

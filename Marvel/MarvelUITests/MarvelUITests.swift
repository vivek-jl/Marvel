//
//  MarvelUITestsLaunchTests.swift
//  MarvelUITests
//
//  Created by Vivek Jayakumar on 3/2/22.
//

import XCTest

class MarvelUITestsLaunchTests: XCTestCase {

    var app: XCUIApplication!

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("UITesting")
        app.launch()
        sleep(1)
    }
    
    func testLaunch() throws {
        let label = app.staticTexts["3-D Man"]
        XCTAssertTrue(label.waitForExistence(timeout: 10))
        label.tap()
        
        let expectation = expectation(
            for: NSPredicate(format: "exists == true"),
               evaluatedWith: app.staticTexts["comic description"],
            handler: .none
        )

        let result = XCTWaiter.wait(for: [expectation], timeout: 10)

        XCTAssertEqual(result, .completed)
    }
    
}



//
//  KiliaroUITests.swift
//  KiliaroUITests
//
//  Created by Sajjad Najafi on 7/14/22.
//

import XCTest

class KiliaroUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testShowAlbums() {
        XCTAssertTrue(app.cells.firstMatch.waitForExistence(timeout: 5.0), "Album should load!")
        XCTAssertEqual(app.cells.firstMatch.staticTexts.firstMatch.label, "djlCbGusTJamg_ca4axEVw", "Album name is incorrect.")
    }

    
}

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

    func testShowShareList() {
        XCTAssertTrue(app.cells.firstMatch.waitForExistence(timeout: 5.0), "Share List should load!")
        XCTAssertEqual(app.cells.firstMatch.staticTexts.firstMatch.label, "djlCbGusTJamg_ca4axEVw", "Share list name is incorrect.")
    }

    func testPresentAlbum() {
        testShowShareList()
        app.cells.firstMatch.tap()
        XCTAssertTrue(app.images.firstMatch.waitForExistence(timeout: 10.0), "Album cells should load")
    }
    
    func testPresentMedia() {
        testPresentAlbum()
        app.cells.firstMatch.tap()
        XCTAssertTrue(app.images.firstMatch.waitForExistence(timeout: 15.0), "Album cells should load")
    }
    
    func testAlbumReloadExist() {
        testPresentAlbum()
        wait(for: [], timeout: 10.0)
        XCTAssertTrue(app.navigationBars.firstMatch.buttons.element(boundBy: 1).exists, "Album reload button not found.")
        app.navigationBars.firstMatch.buttons.element(boundBy: 1).tap()
    }
}

//
//  Memory_Game_AppUITests.swift
//  Memory Game AppUITests
//
//  Created by Moulya on 3/5/25.
//

import XCTest

class Memory_Game_AppUITests: XCTestCase {
    func testGameStart() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["New Game"].exists)
    }
}

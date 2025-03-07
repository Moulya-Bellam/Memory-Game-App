//
//  Memory_Game_AppUITestsLaunchTests.swift
//  Memory Game AppUITests
//
//  Created by Moulya on 3/5/25.
//

import XCTest

class Memory_Game_AppUITestsLaunchTests: XCTestCase {
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

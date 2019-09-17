//
//  MovieAppUITests.swift
//  MovieAppUITests
//
//  Created by YASH COMPUTERS on 30/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import XCTest

class MovieAppUITests: XCTestCase {
    var app : XCUIApplication!
    override func setUp() {

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
         app = XCUIApplication()

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app.launchArguments.append("--uitesting")

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
                                        
    }
    func testScrollTableViewWithPagination(){
        //XCTAssertTrue(app.isDisplayingTableScroll)
        let tableView = app.tables["tableViewIdentifier"]
        tableView.swipeUp()
        tableView.swipeUp()
        tableView.swipeUp()
        tableView.swipeUp()
        tableView.swipeUp()
        tableView.swipeUp()
        tableView.swipeUp()
        tableView.swipeUp()
        tableView.swipeUp()
        XCTAssertFalse(app.isDisplayingTableScroll)

    }
}
extension XCUIApplication {
    var isDisplayingTableScroll : Bool {
        return otherElements["tableViewIdentifier"].exists
    }
}

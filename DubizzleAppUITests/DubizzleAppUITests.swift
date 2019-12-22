//
//  DubizzleAppUITests.swift
//  DubizzleAppUITests
//
//  Created by Vineet Sansare on 12/19/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import XCTest

class DubizzleAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        // sending a command line argument to our app, to enable it to reset its state
        app.launchArguments.append("--uitesting")
        
        app.launch()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testForOneCollectionView() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.launch()
        // Make sure we're displaying only one collectionView
        XCTAssertTrue(app.collectionViews.count == 1)
    }
}

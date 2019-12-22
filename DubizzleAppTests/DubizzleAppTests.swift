//
//  DubizzleAppTests.swift
//  DubizzleAppTests
//
//  Created by Vineet Sansare on 12/19/19.
//  Copyright © 2019 dubizzle. All rights reserved.
//

import XCTest
@testable import DubizzleApp

class DubizzleAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: Tests
    
    func testGetProductsAPI() {
        if(Reachability.isConnectedToNetwork()) {
            // Setting expectation
            let promise = expectation(description: "Expecting data in products & error to be nil")
            let productNetworkAdapter = ProductNetworkAdapter()
            productNetworkAdapter.getProducts { (products, error) in
                guard error == nil else {
                    // if error is not nil it means there is some server error, thus the test for server error succeeds
                    // it should ideally fail
                    XCTAssertNotNil(error)
                    XCTFail("error: \(String(describing: error!.localizedDescription))")
                    return
                }
                // if error is nil it means, we've received response successfully & our expectation (promise) is fulfilled
                // it should ideally succeed
                XCTAssertNotNil(products)
                promise.fulfill()
            }
            
            // Keeping timeout to 10 considering slow internet connections on mobile devices too
            
            waitForExpectations(timeout: 10) { (error) in
                if let error = error {
                    // if asynchronous wait failed i.e. exceeds 5 secs then our expectation (promise) doesn't get fullfilled
                    // & we get failed - error: The operation couldn’t be completed.
                    XCTFail("error: \(error.localizedDescription)")
                }
            }            
        } else {
            XCTFail("error: No internet connection.")
        }
    }
}

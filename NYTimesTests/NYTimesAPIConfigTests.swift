//
//  NYTimesAPIConfigTests.swift
//  NYTimesTests
//
//  Created by Adithya Bhat on 13/01/2022.
//

import XCTest
@testable import NYTimes

class NYTimesAPIConfigTests: XCTestCase {

    var appConfig: AppConfig? = nil
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        appConfig = AppConfig.current
    }

    override func tearDownWithError() throws {
        appConfig = nil
    }

    func testAPI() throws {
        XCTAssert(API.baseURL == "", <#T##message: String##String#>)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  NYTimesAPIConfigTests.swift
//  NYTimesTests
//
//  Created by Adithya Bhat on 13/01/2022.
//

import XCTest
@testable import NYTimes

class AppConfigTest: XCTestCase {
    
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testAppConfigLoad() throws {
        let appConfig = AppConfig.current
        
        //Check for environment set
        XCTAssert(appConfig.environment == .sit, "App environment not set correctly")
        
        //Checking if server data loaded correctly from the plist file
        XCTAssert(appConfig.server.host.absoluteString == "https://api.nytimes.com",
                  "Host url did not load as expected")
        XCTAssert(appConfig.server.suffix == "svc", "suffix not loading as expected")
        XCTAssert(appConfig.server.apiKey == "sMgtEzTAw9Tggbrd4qIAZm2lpGxTCjze", "apiKey not loading as expected")
    }

    func testAPI() throws {
        let expectedBaseURL = "https://api.nytimes.com/svc"
        //Check baseURL loading correctly
        XCTAssert(API.baseURL.absoluteString == expectedBaseURL,
                  "baseURL did not load as expected")
        
        //Check the Endpoint url loading correctly
        let mostPopularUrl = API.baseURL.appending(endpoint: API.Endpoint.mostPopular)
        let expectedPath = "\(expectedBaseURL)/mostpopular/v2/emailed"
        XCTAssert(mostPopularUrl.absoluteString == expectedPath, "Enpoint formation not happening as expected")
    }

}

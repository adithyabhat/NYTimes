//
//  APITest.swift
//  NYTimesTests
//
//  Created by Adithya Bhat on 16/01/2022.
//

import XCTest

class APITest: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testMostPopularArticlesAPI() throws {
        let expectation1Day = expectation(description: "Loaded articles for 1 day successfully")
        let expectation7Days = expectation(description: "Loaded articles for 7 days successfully")
        let expectation30Days = expectation(description: "Loaded articles for 30 days successfully")

        //Fetching 1 day articles
        APIManager.fetchArticles(period: .oneDay) { result in
            switch result {
            case .success(_):
                expectation1Day.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        //Fetching 7 day articles
        APIManager.fetchArticles(period: .sevenDays) { result in
            switch result {
            case .success(_):
                expectation7Days.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        //Fetching 30 day articles
        APIManager.fetchArticles(period: .thirtyDays) { result in
            switch result {
            case .success(_):
                expectation30Days.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation1Day, expectation7Days, expectation30Days], timeout: 5)
    }

}

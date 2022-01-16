//
//  ViewModelDataSetupTest.swift
//  NYTimesTests
//
//  Created by Adithya Bhat on 16/01/2022.
//

import XCTest

class ViewModelDataSetupTest: XCTestCase {

    var viewModel: MainListViewModel?
    var loadedArticles: [Article]?
    var fetchArticlesResponse: ArticleResponse?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MainListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        loadedArticles = nil
        fetchArticlesResponse = nil
        try super.tearDownWithError()
    }

    func testArticleListCreation() throws {
        let promise = expectation(description: "All the articles loaded successfully")
        
        APIManager.fetchArticles(period: .sevenDays) { result in
            switch result {
            case .success(let articleResponse):
                self.loadedArticles = self.viewModel?.articles(from: articleResponse)
                if self.loadedArticles?.count ?? -1 == articleResponse.numResults {
                    promise.fulfill()
                } else {
                    XCTFail("Error: Articles load failed")
                }
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [promise], timeout: 5)
    }

    func testArticleModelCreation() throws {
        //Compare data of first Article and Article response result object
        guard
            let articleToCheck = self.loadedArticles?.first,
            let articleResponseResult = fetchArticlesResponse?.results.first else {
            return
        }
        XCTAssert(articleToCheck.title == articleResponseResult.title, "Title load failed")
        XCTAssert(articleToCheck.byLine == articleResponseResult.byline, "Subtitle load failed")
        XCTAssert(articleToCheck.url == articleResponseResult.url, "URL load failed")
    }

}

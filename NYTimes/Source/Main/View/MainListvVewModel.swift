//
//  MainListvVewModel.swift
//  NYTimes
//
//  Created by Adithya Bhat on 14/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class MainListViewModel {
    
    //MARK: - Properties
    private var articles = [Article]()
    private lazy var dateFormatter: DateFormatter = makeDateFormatter()
    
    var screenTitle: String { "NY Times Most Popular" }
    let reloadData = PublishSubject<Void>()
    let onError = PublishSubject<Error>()
    let loadingIndicator = PublishSubject<Bool>()

    //MARK: - Public methods
        
    func loadArticles() {
        loadingIndicator.onNext(true)
        APIManager.fetchArticles { [weak self] result in
            self?.loadingIndicator.onNext(false)
            guard let self = self else { return }
            switch result {
            case .success(let articleResponse):
                self.articles = self.articles(from: articleResponse)
                self.reloadData.onNext(())
            case .failure(let error):
                self.onError.onNext(error)
            }
        }
    }
    
    //MARK : Table view helper methods
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return articles.count
    }
    
    func item(for index: Int) -> Article {
        guard index >= 0 && index < articles.count else {
            fatalError("Invalid index")
        }
        return articles[index]
    }
    
    //MARK: Model creation method
    
    public func articles(from respose: ArticleResponse) -> [Article] {
        var articles = [Article]()
        for result in respose.results {
            let publishDate = dateFormatter.date(from: result.publishedDate) ?? Date()
            let imageURL = result.thumbnailImageURLString()
            let article = Article(title: result.title,
                                  byLine: result.byline,
                                  publishDate: publishDate,
                                  url: result.url,
                                  imageURL: imageURL)
            articles.append(article)
        }
        return articles
    }
    
    //MARK: - Private helper method
    
    private func makeDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }
}

//
//  Article.swift
//  NYTimes
//
//  Created by Adithya Bhat on 14/01/2022.
//

import Foundation

class Article {
    var title: String
    var byLine: String
    var publishDate: Date
    var url: String
    var imageURL: String
    
    init(title: String, byLine: String, publishDate: Date, url: String, imageURL: String) {
        self.title = title
        self.byLine = byLine
        self.publishDate = publishDate
        self.url = url
        self.imageURL = imageURL
    }
}

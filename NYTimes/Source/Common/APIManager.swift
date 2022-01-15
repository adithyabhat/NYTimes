//
//  APIManager.swift
//  NYTimes
//
//  Created by Adithya Bhat on 15/01/2022.
//

import Foundation
import Alamofire

class APIManager {}

//Articles fetch
extension APIManager {
    
    enum Period {
        case oneDay
        case sevenDays
        case thirtyDays
        
        func parameter() -> String {
            switch self {
            case .oneDay:       return "1.json"
            case .sevenDays:    return "7.json"
            case .thirtyDays:   return "30.json"
            }
        }
    }
    
    static func fetchArticles(period: Period = .sevenDays,
                              completionHandler: @escaping ((Swift.Result<ArticleResponse, AFError>) -> Void)) {
        let url = API.baseURL
            .appending(endpoint: .mostPopular)
            .appendingPathComponent(period.parameter())
        let parameters = ["api-key" : AppConfig.current.server.apiKey]
        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        AF.request(url,parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder(destination: .queryString),
                   headers: headers)
            .validate()
            .responseDecodable(of: ArticleResponse.self) { response in
                completionHandler(response.result)
            }
    }
    
}

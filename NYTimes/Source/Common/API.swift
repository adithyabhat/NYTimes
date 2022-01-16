//
//  API.swift
//  NYTimes
//
//  Created by Adithya Bhat on 15/01/2022.
//

import Foundation

public struct API {
    
    static var baseURL: URL {
        let apiDetails = AppConfig.current.server
        return apiDetails.host.appendingPathComponent(apiDetails.suffix)
    }
    
}

extension URL {
    
    func appending(endpoint: API.Endpoint) -> URL {
        return self.appendingPathComponent(endpoint.rawValue)
    }
}

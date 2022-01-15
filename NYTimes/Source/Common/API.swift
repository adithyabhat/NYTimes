//
//  API.swift
//  NYTimes
//
//  Created by Adithya Bhat on 15/01/2022.
//

import Foundation

struct API {
    
    static var baseURL: URL = AppConfig.current.server.host.appendingPathComponent("svc")
    
}

extension URL {
    
    func appending(endpoint: API.Endpoint) -> URL {
        return self.appendingPathComponent(endpoint.rawValue)
    }
}

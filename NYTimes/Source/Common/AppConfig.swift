//
//  AppConfig.swift
//  NYTimes
//
//  Created by Adithya Bhat on 15/01/2022.
//

import Foundation

struct AppConfig {
    
    static var current = AppConfig()
    
    var environment: Environment
    var server: Server
    
    private init() {
        #if DEBUG
            self.environment = .sit
        #else
            self.environment = .prod
        #endif
        
        self.server = Server.for(self.environment)
    }
}

extension AppConfig {
    
    enum Environment {
        case sit
        case prod
    }
    
    struct Server {
        var host: URL
        var apiKey: String
        
        static func `for`(_ environtment: Environment) -> Server {
            let urlFor: ((String) -> URL) = { urlString in
                guard let url = URL(string: urlString) else {
                    fatalError("Invalid host URL")
                }
                return url
            }
            switch environtment {
            case .sit:
                return Server(host: urlFor("https://api.nytimes.com/"),
                              apiKey: "sMgtEzTAw9Tggbrd4qIAZm2lpGxTCjze")
            case .prod:
                return Server(host: urlFor(""), apiKey: "")
            }
        }
    }
    
}

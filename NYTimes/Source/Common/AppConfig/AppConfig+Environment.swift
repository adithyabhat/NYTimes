//
//  AppConfig+Environment.swift
//  NYTimes
//
//  Created by Adithya Bhat on 16/01/2022.
//

import Foundation

public extension AppConfig {
    
    enum Environment {
        case sit
        case prod
        
        func plistKey() -> String {
            switch self {
            case .sit: return "debug"
            case .prod: return "release"
            }
        }
    }
    
}

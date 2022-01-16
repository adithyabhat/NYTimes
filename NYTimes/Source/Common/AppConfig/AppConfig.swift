//
//  AppConfig.swift
//  NYTimes
//
//  Created by Adithya Bhat on 15/01/2022.
//

import Foundation

public struct AppConfig {
    
    //MARK: - Properties

    //Singleton instance
    public static var current = AppConfig()

    public var environment: Environment
    public var server: Server
    
    //MARK: - Init
    
    private init() {
        //Load app config data from the plist
        guard let path = Bundle.main.path(forResource: "AppConfig", ofType: "plist") else {
            fatalError("Missing config file")
        }
        let configFileURL = URL(fileURLWithPath: path)
        guard let configData = try? NSDictionary(contentsOf: configFileURL, error: ()) as? Dictionary<String, AnyObject> else {
            fatalError("Counld not read config file data")
        }
        
        #if DEBUG
            self.environment = .sit
        #else
            self.environment = .prod
        #endif
        
        //Set server details from the config data
        self.server = Server.for(self.environment, from: configData)
    }
    
}

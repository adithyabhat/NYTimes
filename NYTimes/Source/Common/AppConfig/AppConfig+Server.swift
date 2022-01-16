//
//  AppConfig+Server.swift
//  NYTimes
//
//  Created by Adithya Bhat on 16/01/2022.
//

import Foundation

public extension AppConfig {
    
    struct Server: Codable {
        
        //MARK: - Properties
        
        private static let plistKey = "server"
        
        var host: URL
        var suffix: String = ""
        var apiKey: String
        
        enum CodingKeys: CodingKey {
            case host, suffix, apiKey
        }
        
        //MARK: - Methods
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            guard let host = try? container.decode(String.self, forKey: .host),
                  let url = URL(string: host) else {
                fatalError("Host url incorrect / missing")
            }
            self.host = url
            self.suffix = try container.decode(String.self, forKey: .suffix)
            self.apiKey = try container.decode(String.self, forKey: .apiKey)
        }
        
        static func `for`(_ environtment: Environment,
                          from configData: [String: AnyObject]) -> Server {
            //Retrieve server data from the config data
            guard let serverDetails = configData[Server.plistKey] else {
                fatalError("Missing server details")
            }
            
            //Retrieve environment specific server data
            guard let envSpecificServerDetails = serverDetails[environtment.plistKey()] else {
                fatalError("Missing server details for \(environtment) environment")
            }
            
            //Decode the dictionary data to Codable Server object
            var server: Server!
            let decoder = JSONDecoder()
            do {
                let data = try JSONSerialization.data(withJSONObject: envSpecificServerDetails ?? [],
                                                       options: .prettyPrinted)
                server = try decoder.decode(Server.self, from: data)
            } catch {
                fatalError("Missing / incorrect server data")
            }
            
            return server
        }
    }
    
}

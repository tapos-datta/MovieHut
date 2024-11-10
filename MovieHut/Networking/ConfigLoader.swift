//
//  ConfigLoader.swift
//  MovieHut
//
//  Created by Optimus Prime on 8/11/24.
//

import Foundation

final class ConfigLoader {
    static let shared = ConfigLoader()
    
    private var config: [String : Any]?
    
    private init() {
        loadConfig()
    }
    
    private func loadConfig() {
        if let url = Bundle.main.url(forResource: "APIConfig", withExtension: "plist"),
           let data = try? Data(contentsOf: url),
           let configData = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String : Any] {
            self.config = configData
        }
    }
    
    func getAPIKey() -> String? {
        return config?["API_KEY"] as? String
    }
    
    func getBaseURL() -> String? {
        return config?["BASE_URL"] as? String
    }
    
    func getAccessKey() -> String? {
        return config?["ACCESS_TOKEN"] as? String
    }
    
}

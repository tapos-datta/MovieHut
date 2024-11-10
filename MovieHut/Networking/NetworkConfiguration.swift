//
//  NetworkConfiguration.swift
//  MovieHut
//
//  Created by Optimus Prime on 8/11/24.
//

import Foundation

struct NetworkConfiguration {
    
    static var baseUrlPath: String {
        guard let url = ConfigLoader.shared.getBaseURL() else {
            fatalError("Base URL not found in configuration file.")
        }
        return url
    }
        
    static var apiKey: String {
        guard let key = ConfigLoader.shared.getAPIKey() else {
            fatalError("API Key not found in configuration file.")
        }
        return key
    }
    
    static var accessKey: String {
        guard let key = ConfigLoader.shared.getAccessKey() else {
            fatalError("Header: Access Key not found in configuration file.")
        }
        return key
    }
    
    static func buildURL(for endpoint : String, with params: [String: String]? = nil) -> URL? {
        var components = URLComponents(string: baseUrlPath)
        components?.path += "/" + endpoint
        
        var queryItems : [URLQueryItem] = []
        if let params {
            queryItems.append(contentsOf: params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            })
        }
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        components?.queryItems = queryItems
        return components?.url
    }
}

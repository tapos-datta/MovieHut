//
//  ImageFetcher.swift
//  MovieHut
//
//  Created by Optimus Prime on 11/11/24.
//
import Foundation

final class ImageUrlBuilder {
    
    static func getImageUrl(for fileName: String, isOriginal: Bool = false) -> URL {
        let path : String = NetworkConfiguration.imageHostingPath
                + (!isOriginal ? "/w500" : "/original")
                + fileName
        let url = URL(string: path)
        
        guard let url = url else {
            fatalError("Invalid image url: \(path)")
        }
        return url
    }
}

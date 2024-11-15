//
//  ImageLoader.swift
//  MovieHut
//
//  Created by Optimus Prime on 11/11/24.
//

import SwiftUI
import UIKit

private let _imageCache = NSCache<NSString, AnyObject>()


class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    private var imageCache: NSCache<NSString, AnyObject> { _imageCache }
    
    init() {
        self.imageCache.removeAllObjects()
    }
    
    func loadImage(from url: URL) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = image
            return
        }
        
        Task {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                await MainActor.run {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

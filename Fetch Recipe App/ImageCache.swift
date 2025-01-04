//
//  ImageCache.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/3/25.
//

import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
            .appendingPathComponent("ImageCache")

        // Create the directory if it doesn't exist
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }

    // Retrives images from cache
    func getImage(forKey key: String) -> UIImage? {
        if let image = cache.object(forKey: key as NSString) {
            return image
        }

        // Check disk cache if not in memory
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let image = UIImage(contentsOfFile: fileURL.path) {
            cache.setObject(image, forKey: key as NSString)
            return image
        }

        return nil
    }

    // Save an image to cache
    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        }
    }
}

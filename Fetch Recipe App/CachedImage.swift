//
//  CachedImage.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/3/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: String
    let placeholder: Image
    
    @State private var image: UIImage?
    
    var body: some View {
        ZStack {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                placeholder
                    .resizable()
                    .scaledToFill()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        // Is imaged Cached
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: url) {
            image = cachedImage
            return
        }
        
        // Downloads image if not cached
        guard let url = URL(string: url) else { return }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let downloadedImage = UIImage(data: data) {
                    ImageCacheManager.shared.saveImage(downloadedImage, forKey: self.url)
                    DispatchQueue.main.async {
                        image = downloadedImage
                    }
                }
            } catch {
                print("Failed to load image: \(error.localizedDescription)")
            }
        }
    }
}

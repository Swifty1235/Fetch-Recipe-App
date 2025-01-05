//
//  CacheTest.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/5/25.
//
//  This test verifies the functionality of the ImageCacheManager, ensuring that
//  images are correctly saved to and retrieved from the cache, both in memory and on disk.
//

import XCTest
@testable import Fetch_Recipe_App

final class ImageCacheManagerTests: XCTestCase {
    let cacheManager = ImageCacheManager.shared
    let testKey = "testImageKey"
    let testImage = UIImage(systemName: "photo")!

    func testSaveAndRetrieveImage() {
        cacheManager.saveImage(testImage, forKey: testKey)
        let cachedImage = cacheManager.getImage(forKey: testKey)
        XCTAssertNotNil(cachedImage, "Cached image should not be nil.")
        XCTAssertEqual(cachedImage?.pngData(), testImage.pngData(), "Cached image data should match original image data.")
    }
}

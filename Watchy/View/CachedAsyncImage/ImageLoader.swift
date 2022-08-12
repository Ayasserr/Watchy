//
//  ImageLoader.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation
import SwiftUI

protocol ImageCache {
	func getImage(from url: URL?) async throws -> Void
	func downloadImage(from url: URL) async throws -> Void
}

@MainActor
class ImageLoader: ObservableObject, ImageCache {
	@Published var image: UIImage?
	
	
	static private let cache: NSCache<NSURL, UIImage> = {
		let cache = NSCache<NSURL, UIImage>()
		cache.countLimit = 100
		cache.totalCostLimit = 1024 * 1024 * 512 // 512MB
		return cache
	}()
	
	public func getImage(from url: URL?) async throws {
		guard let url = url else { throw RequestError.invalidURL }
		
		guard let cachedImage = Self.cache.object(forKey: url as NSURL) else {
			try await self.downloadImage(from: url)
			return
		}
		
		self.image = cachedImage
	}
	
	func downloadImage(from url: URL) async throws {
		let request = URLRequest(url: url)
		let (data, response) = try await URLSession.shared.data(for: request)
		
		guard let response = response as? HTTPURLResponse else { throw RequestError.noResponse }
		guard (200 ..< 300) ~= response.statusCode else { throw RequestError.invalidResponse }
		guard let uiImage = UIImage(data: data) else { throw RequestError.invalidDecoding }
		
		Self.cache.setObject(uiImage, forKey: url as NSURL)
		self.image = uiImage
	}
}

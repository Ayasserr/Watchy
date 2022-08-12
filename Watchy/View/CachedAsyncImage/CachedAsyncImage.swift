//
//  CachedAsyncImage.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

struct CachedAsyncImage<Content, Placeholder>: View where Content: View, Placeholder: View {
	private let url: URL?
	private let scale: CGFloat
	private let transaction: Transaction
	private let content: (Image) -> Content
	private let placeholder: () -> Placeholder
	
	@StateObject private var imageLoader: ImageLoader
	
	init(
		url: URL?,
		scale: CGFloat = 1,
		transaction: Transaction = Transaction(),
		@ViewBuilder content: @escaping (Image) -> Content,
		@ViewBuilder placeholder: @escaping () -> Placeholder
	) {
		self.url = url
		self.scale = scale
		self.transaction = transaction
		self.content = content
		self.placeholder = placeholder
		
		self._imageLoader = StateObject(wrappedValue: ImageLoader())
	}
	
	var body: some View {
		VStack {
			if let image = imageLoader.image { content(Image(uiImage: image)) }
			else { placeholder() }
		}
		.task {
			try? await getImage()
		}
	}
	
	private func getImage() async throws {
		do {
			try await imageLoader.getImage(from: url)
		} catch RequestError.invalidURL {
			print("URL is not correct")
		} catch RequestError.invalidResponse {
			print("Response is not correct")
		} catch RequestError.noResponse {
			print("No response returned from server")
		} catch RequestError.invalidDecoding {
			print("Could't decode the image")
		} catch {
			print(error.localizedDescription)
		}
	}
}

struct CachedAsyncImage_Previews: PreviewProvider {
	static var previews: some View {
		CachedAsyncImage(url: URL(string: "\(API.imagesURL)w500/zuW6fOiusv4X9nnW3paHGfXcSll.jpg")) { image in
			image.resizable()
				.aspectRatio(contentMode: .fit)
				.transition(.opacity)
		} placeholder: {
			RoundedRectangle(cornerRadius: 15)
				.foregroundColor(.gray.opacity(0.3))
				.overlay {
					Text("Toy Story")
						.font(.title2)
						.fontWeight(.semibold)
						.foregroundColor(.black)
						.multilineTextAlignment(.center)
				}
		}
		.frame(width: 120, height: 180)
		.cornerRadius(15)
	}
}
struct CachedAsyncImage<Content, Placeholder>: View where Content: View, Placeholder: View {
	private let url: URL?
	private let scale: CGFloat
	private let transaction: Transaction
	private let content: (Image) -> Content
	private let placeholder: () -> Placeholder
	
	@StateObject private var imageLoader: ImageLoader
	
	init(
		url: URL?,
		scale: CGFloat = 1,
		transaction: Transaction = Transaction(),
		@ViewBuilder content: @escaping (Image) -> Content,
		@ViewBuilder placeholder: @escaping () -> Placeholder
	) {
		self.url = url
		self.scale = scale
		self.transaction = transaction
		self.content = content
		self.placeholder = placeholder
		
		self._imageLoader = StateObject(wrappedValue: ImageLoader())
	}
	
	var body: some View {
		VStack {
			if let image = imageLoader.image { content(Image(uiImage: image)) }
			else { placeholder() }
		}
		.task {
			try? await getImage()
		}
	}
	
	private func getImage() async throws {
		do {
			try await imageLoader.getImage(from: url)
		} catch RequestError.invalidURL {
			print("URL is not correct")
		} catch RequestError.invalidResponse {
			print("Response is not correct")
		} catch RequestError.noResponse {
			print("No response returned from server")
		} catch RequestError.invalidDecoding {
			print("Could't decode the image")
		} catch {
			print(error.localizedDescription)
		}
	}
}

struct CachedAsyncImage_Previews: PreviewProvider {
	static var previews: some View {
		CachedAsyncImage(url: URL(string: "\(API.imagesURL)w500/zuW6fOiusv4X9nnW3paHGfXcSll.jpg")) { image in
			image.resizable()
				.aspectRatio(contentMode: .fit)
				.transition(.opacity)
		} placeholder: {
			RoundedRectangle(cornerRadius: 15)
				.foregroundColor(.gray.opacity(0.3))
				.overlay {
					Text("Toy Story")
						.font(.title2)
						.fontWeight(.semibold)
						.foregroundColor(.black)
						.multilineTextAlignment(.center)
				}
		}
		.frame(width: 120, height: 180)
		.cornerRadius(15)
	}
}


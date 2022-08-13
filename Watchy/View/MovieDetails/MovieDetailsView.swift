//
//  MovieDetailsView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

struct MovieDetailsView: View {
	@StateObject private var movieVM: MovieViewModel
	
	init(movieID: Int) {
		self._movieVM = StateObject(wrappedValue: MovieViewModel(movieID: movieID))
		
		UINavigationBar.appearance().backIndicatorImage = UIImage(named: "chevron.left.circle.fill")
	}
	
	var body: some View {
		ZStack(alignment: .top) {
			// MARK: - Background Image
			imageView(for: movieVM.movie?.posterPath, width: "w300")
				.blur(radius: 70)
				.ignoresSafeArea()
			
			ScrollView(showsIndicators: false) {
				LazyVStack {
					ZStack(alignment: .top) {
						// MARK: - Movie Backdrop Image
						imageView(for: movieVM.movie?.backdropPath, width: "w1280")
							.frame(height: 300)
							.opacity(0.6)
						
						// MARK: - Movie Poster Image
						imageView(for: movieVM.movie?.posterPath, width: "w500")
							.frame(width: 200, height: 300)
							.cornerRadius(20)
							.shadow(radius: 20)
							.padding(.top, 150)
					} //: ZStack - Backdrop and Poster Images
					
					
				}
			}
		}
		.edgesIgnoringSafeArea(.top)
		.task { try? await movieVM.getMovieDetails() }
	}
	
	// MARK: - Movie Images
	@ViewBuilder
	private func imageView(for path: String?, width: String) -> some View {
		if let path = path {
			CachedAsyncImage(url: URL(string: "\(API.imagesURL)\(width)\(path)")) { image in
				image.resizable(resizingMode: .stretch)
			} placeholder: {
				Rectangle()
					.foregroundColor(.gray.opacity(0.4))
					.overlay { Text(movieVM.movie?.title ?? "") }
					.cornerRadius(20)
			}
		} else {
			Rectangle()
				.foregroundColor(.gray.opacity(0.4))
				.overlay { Text(movieVM.movie?.title ?? "") }
				.cornerRadius(20)
		}
	}
}

struct MovieDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		MovieDetailsView(movieID: 675)
			.previewDevice("iPhone 13 Pro Max")
	}
}

// 585511 Luck
// 862 Toy Story
// 24428 The Avengers
// 671 Harry Potter 1

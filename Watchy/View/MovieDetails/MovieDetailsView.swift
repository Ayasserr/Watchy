//
//  MovieDetailsView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

struct MovieDetailsView: View {
	@StateObject private var movieVM: MovieViewModel
	@Environment(\.dismiss) private var dismiss
	
	init(movieID: Int) {
		self._movieVM = StateObject(wrappedValue: MovieViewModel(movieID: movieID))
		
		UINavigationBar.appearance().backIndicatorImage = UIImage(named: "chevron.left.circle.fill")
	}
	
	var body: some View {
		ZStack(alignment: .top) {
			// MARK: - Background Image
			imageView(for: movieVM.movie?.posterPath, width: "w300")
				.blur(radius: 70, opaque: true)
				.ignoresSafeArea()
			
			ScrollView(showsIndicators: false) {
				LazyVStack {
					movieHeader
					
					LazyVStack(spacing: 10) {
						Text(movieVM.movie?.title ?? "No Title")
							.font(.system(.title, design: .rounded))
							.fontWeight(.medium)
							.multilineTextAlignment(.center)
						
						// MARK: - Release Date and Rate
						HStack(spacing: 10) {
							Text(movieVM.movie?.releaseYear ?? "")
							Text("•")
							Text(movieVM.movie?.runtimeFormatted ?? "")
						}
						.foregroundColor(.textColor)
						
						movieGenres
						movieOverview
					}
					.padding(.horizontal, 15)
					
					movieCast
				}
			}
		}
		.overlay(alignment: .topLeading) {
			Button(action: { dismiss() }) {
				Image(systemName: "chevron.left.circle.fill")
					.imageScale(.large)
					.font(.title2)
					.padding(.leading, 32)
					.padding(.top, 50)
			}
		} //: .overlay modifier
		.foregroundColor(.textColor)
		.edgesIgnoringSafeArea(.top)
		.navigationBarHidden(true)
		.task { try? await movieVM.getMovieDetails() }
	}
	
	// MARK: - Movie Images
	@ViewBuilder
	private func imageView(for path: String?, width: String, type: ImagePlaceholder = .movie) -> some View {
		if let path = path {
			CachedAsyncImage(url: URL(string: "\(API.imagesURL)\(width)\(path)")) { image in
				image.resizable()
			} placeholder: {
				Rectangle()
					.foregroundColor(.gray.opacity(0.4))
					.overlay { Text(movieVM.movie?.title ?? "") }
					.cornerRadius(20)
			}
		} else {
			Rectangle()
				.foregroundColor(.gray.opacity(0.4))
				.overlay {
					switch type {
						case .movie: Text(movieVM.movie?.title ?? "")
						case .cast(let name): Text(name)
					}
				}
				.cornerRadius(20)
				.multilineTextAlignment(.center)
		}
	}
	
	// MARK: - Movie Header
	private var movieHeader: some View {
		ZStack(alignment: .top) {
			// MARK: - Movie Backdrop Image
			imageView(for: movieVM.movie?.backdropPath, width: "w1280")
				.frame(height: 250)
				.opacity(0.6)
			
			// MARK: - Movie Poster Image
			imageView(for: movieVM.movie?.posterPath, width: "w500")
				.frame(width: 200, height: 300)
				.cornerRadius(20)
				.shadow(radius: 20)
				.padding(.top, 150)
		} //: ZStack - Backdrop and Poster Images
	}
	
	// MARK: - Movie Overview
	private var movieOverview: some View {
		Text(movieVM.movie?.overview ?? "No Overview")
			.multilineTextAlignment(.leading)
			.padding()
			.background(.gray.opacity(0.35))
			.cornerRadius(20)
			.padding(.top)
	}
	
	// MARK: - Movie Genres
	private var movieGenres: some View {
		FlexibleView(data: movieVM.movie?.genres ?? []) { genre in
			HStack {
				Text(genre.name)
				if movieVM.movie?.genres.last != genre {
					Text("•")
				}
			}
		}
	}
	
	// MARK: - Movie Cast
	private var movieCast: some View {
		VStack(alignment: .leading) {
			Text("Cast")
				.font(.title2)
				.fontWeight(.semibold)
				.padding(.leading, 20)
			
			ScrollView(.horizontal, showsIndicators: false) {
				LazyHStack(alignment: .top, spacing: 20) {
					ForEach(movieVM.cast) { cast in
						imageView(for: cast.profilePath, width: "w185", type: .cast(cast.name))
							.frame(width: 150, height: 220)
							.shadow(radius: 5)
							.cornerRadius(15)
							.transition(.opacity)
							.padding(.leading, movieVM.cast.first == cast ? 20 : 0)
							
					}
				}
			}
		}
		.padding(.vertical)
	}
	
	// MARK: - Image Type enum
	private enum ImagePlaceholder {
		case movie
		case cast(String)
	}
	
}

struct MovieDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		MovieDetailsView(movieID: 671)
			.previewDevice("iPhone 13 Pro Max")
	}
}

// 585511 Luck
// 862 Toy Story
// 24428 The Avengers
// 671 Harry Potter 1

//								.frame(width: 130, height: 200)
//								.transition(.opacity)
//								.scaledToFill()
//								.cornerRadius(15)
//
//								(Text(cast.name).italic() + Text("\n") + Text(cast.character))
//								.bold()
//								.font(.caption)
//								.foregroundColor(.white)
//								.frame(width: 100)
//								.fixedSize(horizontal: false, vertical: true)
//							}
//						}
//					}
//				}
//			}
//		}


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
			imageView(for: movieVM.movie.posterPath, width: "w300")
				.blur(radius: 150, opaque: true)
				.ignoresSafeArea()
			
			ScrollView(showsIndicators: false) {
				LazyVStack {
					movieHeader
					
					LazyVStack(spacing: 15) {
						movieTitle
						movieRate
						movieSummaryInfo
						movieGenres
						movieOverview
					}
					.padding(.horizontal, 15)
					
					movieCast
					movieCollection
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
					.overlay { Text(movieVM.movie.title) }
					.cornerRadius(20)
			}
		} else {
			Rectangle()
				.foregroundColor(.gray.opacity(0.4))
				.overlay {
					switch type {
						case .movie: Text(movieVM.movie.title)
						case .cast(let name): Text(name).padding(.horizontal)
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
			GeometryReader { geometry in
				let global = geometry.frame(in: .global)
				imageView(for: movieVM.movie.backdropPath, width: "w1280")
					.offset(y: global.minY > 0 ? -global.minY : 0)
					.frame(
						height: global.minY > 0 ? 250 + global.minY : 250
					)
					.opacity(0.8)
			}
			
			// MARK: - Movie Poster Image
			imageView(for: movieVM.movie.posterPath, width: "w500")
				.frame(width: 200, height: 300)
				.cornerRadius(20)
				.shadow(radius: 20)
				.padding(.top, 150)
		} //: ZStack - Backdrop and Poster Images
	}
	
	// MARK: - Movie Title & Tagline
	private var movieTitle: some View {
		Group {
			Text(movieVM.movie.title)
				.font(.system(.title, design: .rounded))
				.fontWeight(.medium)
				.multilineTextAlignment(.center)
			
			if let tagline = movieVM.movie.tagline {
				Text(tagline).multilineTextAlignment(.center)
			}
		}
	}
	
	// MARK: - Movie Rate
	private var movieRate: some View {
		HStack {
			Image(systemName: "star.fill").foregroundColor(.yellow)
			HStack(alignment: .lastTextBaseline) {
				Text(String(format: "%0.2f", movieVM.movie.voteAverage)).fontWeight(.bold)
				+ Text(" / 10").fontWeight(.semibold)
				
				Text("\(movieVM.movie.voteCount)")
					.font(.subheadline)
			}
		}
	}
	
	// MARK: - Release Date and Runtime
	private var movieSummaryInfo: some View {
		HStack(spacing: 10) {
			Text(movieVM.movie.releaseYear)
			Text("•")
			Text(movieVM.movie.runtimeFormatted)
		}
		.foregroundColor(.textColor)
	}
	
	// MARK: - Movie Overview
	private var movieOverview: some View {
		Group {
			if let overview = movieVM.movie.overview {
				Text(overview)
					.multilineTextAlignment(.leading)
					.padding()
					.background(.gray.opacity(0.35))
					.cornerRadius(20)
					.padding(.top)
			}
		}
	}
	
	// MARK: - Movie Genres
	private var movieGenres: some View {
		FlexibleView(data: movieVM.movie.genres) { genre in
			HStack {
				Text(genre.name)
				if movieVM.movie.genres.last != genre {
					Text("•")
				}
			}
		}
		.padding(.horizontal, 15)
	}
	
	// MARK: - Movie Cast
	private var movieCast: some View {
		VStack(alignment: .leading) {
			Text("Cast")
				.font(.title2)
				.fontWeight(.semibold)
				.padding(.leading, 20)
			
			// FIXME: - Fix truncation in cast name and cast character
			ScrollView(.horizontal, showsIndicators: false) {
				LazyHStack(alignment: .top, spacing: 20) {
					ForEach(movieVM.cast) { cast in
						VStack(spacing: 5) {
							imageView(for: cast.profilePath, width: "w185", type: .cast(cast.name))
								.frame(width: 150, height: 220)
								.shadow(radius: 5)
								.cornerRadius(15)
								.transition(.opacity)
							
							Text(cast.name)
								.font(.title3)
								.fontWeight(.medium)
							
							Text(cast.character)
								.font(.subheadline)
						}
						.frame(width: 150, height: 300, alignment: .top)
						.padding(.leading, movieVM.cast.first == cast ? 20 : 0)
						.multilineTextAlignment(.center)
					}
				}
			}
		}
		.padding(.vertical)
	}
	
	// MARK: - Movie Collection
	private var movieCollection: some View {
		Group {
			if let collection = movieVM.movie.belongsToCollection {
				VStack(alignment: .leading) {
					Text("Collection")
						.font(.title2)
						.fontWeight(.semibold)
					
					NavigationLink(destination: Text("\(collection.id)")) {
						imageView(for: collection.backdropPath, width: "w780")
							.frame(width: 300, height: 180)
							.aspectRatio(contentMode: .fit)
							.cornerRadius(15)
					}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.leading, 20)
			}
		}
	}
	
	// MARK: - Image Type enum
	private enum ImagePlaceholder {
		case movie
		case cast(String)
	}
}

struct MovieDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			MovieDetailsView(movieID: 671)
		}
		.previewDevice("iPhone 13 mini")
	}
}

// 585511 Luck
// 862 Toy Story
// 24428 The Avengers
// 671 Harry Potter 1
// 438148 Minions

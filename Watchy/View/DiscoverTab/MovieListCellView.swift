//
//  MovieListCellView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

struct MovieListCellView: View {
	let movie: Movie
	
	var body: some View {
		HStack(alignment: .top, spacing: 20) {
			moviePoster()
				.frame(width: 120, height: 180)
				.cornerRadius(15)
			
			VStack(alignment: .leading, spacing: 20) {
				// MARK: - Movie Title
				Text(movie.title)
					.font(.title2)
					.fontWeight(.semibold)
				
				HStack(spacing: 15) {
					movieRate
					movieReleaseDate
				}
				
				// MARK: - Movie Overview
				Text(movie.overview ?? "No Overview")
					.font(.subheadline)
			}
		}
		.foregroundColor(.textColor)
	}
	
	// MARK: - Movie Poster
	@ViewBuilder
	private func moviePoster() -> some View {
		if let posterPath = movie.posterPath {
			CachedAsyncImage(url: URL(string: "\(API.imagesURL)w500\(posterPath)")) { image in
				image.resizable()
					.aspectRatio(contentMode: .fit)
					.transition(.opacity)
			} placeholder: {
				RoundedRectangle(cornerRadius: 15)
					.foregroundColor(.gray.opacity(0.3))
					.overlay {
						Text(movie.title)
							.font(.title2)
							.fontWeight(.semibold)
							.foregroundColor(.black)
							.multilineTextAlignment(.center)
					}
			}
		} else {
			RoundedRectangle(cornerRadius: 15)
				.foregroundColor(.gray.opacity(0.3))
				.overlay {
					Text(movie.title)
						.font(.title2)
						.fontWeight(.semibold)
						.foregroundColor(.black)
						.multilineTextAlignment(.center)
				}
		}
		
	}
	
	// MARK: - Movie Rate
	private var movieRate: some View {
		ZStack {
			Circle()
				.trim(from: 0, to: movie.voteAverage / 10)
				.stroke(.orange, lineWidth: 4)
				.rotationEffect(.degrees(-90))
			
			Circle()
				.stroke(.orange.opacity(0.3), lineWidth: 4)
			
			Text(String(format: "%0.2f", movie.voteAverage))
				.font(.subheadline)
		}
		.frame(width: 50, height: 50)
	}
	
	// MARK: - Movie Release Date
	private var movieReleaseDate: some View {
		Text(movie.releaseDateFormatted, style: .date)
			.font(.subheadline)
	}
}

struct MovieListCellView_Previews: PreviewProvider {
	static var previews: some View {
		MovieListCellView(movie: Bundle.main.decode("movie_response"))
			.previewLayout(.sizeThatFits)
			.padding()
			.background(Color.backgroundColor)
	}
}

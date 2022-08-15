//
//  MovieViewModel.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject, RequestDelegate {
	@Published var movie: MovieDetails = MovieDetails()
	@Published var cast: [Cast] = []
	@Published var recommendations: [Movie] = []
	
	let movieID: Int
	
	init(movieID: Int) {
		self.movieID = movieID
	}
	
	public func getMovieDetails() async throws {
		try await getMovie()
		try await getCast()
		try await getRecommendations()
	}
	
	private func getMovie() async throws {
		let result = try await sendRequest(from: MoviesServicesEndpoint.movie(id: self.movieID), model: MovieDetails.self)
		self.movie = result
	}
	
	private func getCast() async throws {
		let result = try await sendRequest(from: MoviesServicesEndpoint.cast(id: self.movieID), model: CastResponse.self)
		self.cast = result.cast
	}
	
	private func getRecommendations() async throws {
		let result = try await sendRequest(from: MoviesServicesEndpoint.movieRecommendations(id: movieID), model: MoviesResponse.self)
		self.recommendations = result.results
	}
}

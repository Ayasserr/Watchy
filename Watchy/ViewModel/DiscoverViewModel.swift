//
//  DiscoverViewModel.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject, RequestDelegate {
	@Published var movies: [Movie] = []
	
	public func getMovies(of type: MoviesTab) async throws {
		switch type {
			case .trending: try await self.getPopular()
			case .nowPlaying: try await self.getNowPlaying()
		}
	}
	
	private func getNowPlaying() async throws {
		guard let results = try? await sendMoviesRequest(of: .nowPlaying) else { return }
		self.movies = results.results
	}
	
	private func getPopular() async throws {
		guard let results = try? await sendMoviesRequest(of: .popular) else { return }
		self.movies = results.results
	}
	
	private func sendMoviesRequest(of type: MoviesServicesEndpoint, with quary: [String: String]? = nil) async throws -> MoviesResponse {
		if let quary = quary {
			return try await sendRequest(from: type, params: quary, model: MoviesResponse.self)
		} else {
			return try await sendRequest(from: type, model: MoviesResponse.self)
		}
	}
}

// MARK: - MoviesTab
enum MoviesTab: String, CaseIterable {
	case trending = "Trending"
	case nowPlaying = "Now Playing"
}

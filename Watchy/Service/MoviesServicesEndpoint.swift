//
//  MoviesServicesEndpoint.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

enum MoviesServicesEndpoint {
	case nowPlaying
	case popular
	case movie(id: Int)
	case cast(id: Int)
	case movieSimilar(id: Int)
	case movieRecommendations(id: Int)
}

extension MoviesServicesEndpoint: Endpoint {
	public var path: String {
		switch self {
			case .nowPlaying: return "/3/movie/now_playing"
			case .popular: return "/3/movie/popular"
			case .movie(let id): return "/3/movie/\(id)"
			case .cast(let id): return "/3/movie/\(id)/credits"
			case .movieSimilar(let id): return "/3/movie/\(id)/similar"
			case .movieRecommendations(let id): return "/3/movie/\(id)/recommendations"
		}
	}
}

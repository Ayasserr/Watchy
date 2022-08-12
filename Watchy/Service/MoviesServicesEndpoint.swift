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
	case upcoming
	case movie(id: Int)
	case cast(id: Int)
}

extension MoviesServicesEndpoint: Endpoint {
	public var path: String {
		switch self {
			case .nowPlaying: return "/3/movie/now_playing"
			case .popular: return "/3/movie/popular"
			case .upcoming: return "/3/movie/upcoming"
			case .movie(let id): return "/3/movie/\(id)"
			case .cast(let id): return "/3/movie/\(id)/credits"
		}
	}
}

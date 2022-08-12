//
//  MovieModel.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

struct MoviesResponse: Codable {
	let results: [Movie]
}

struct Movie: Codable, Identifiable {
	let id: Int
	let title: String
	let overview: String?
	let genreIDs: [Int]
	let posterPath: String?
	let backdropPath: String?
	let releaseDate: String
	let runtime: Int?
	let voteAverage: Double
	
	enum CodingKeys: String, CodingKey {
		case id
		case title
		case overview
		case genreIDs = "genre_ids"
		case posterPath = "poster_path"
		case backdropPath = "backdrop_path"
		case releaseDate = "release_date"
		case runtime
		case voteAverage = "vote_average"
	}
}

extension Movie {
	var releaseDateFormatted: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter.date(from: self.releaseDate) ?? Date()
	}
}

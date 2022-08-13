//
//  MovieDetailsModel.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

struct MovieDetails: Codable, Identifiable {
	let id: Int
	let title: String
	let overview: String?
	let genres: [MovieGenres]
	let posterPath: String?
	let backdropPath: String?
	let releaseDate: String
	let runtime: Int?
	let status: MovieStatus
	let voteAverage: Double
	
	enum CodingKeys: String, CodingKey {
		case id
		case title
		case overview
		case genres
		case posterPath = "poster_path"
		case backdropPath = "backdrop_path"
		case releaseDate = "release_date"
		case runtime
		case status
		case voteAverage = "vote_average"
	}
}

extension MovieDetails {
	enum MovieStatus: String, Codable {
		case rumored = "Rumored"
		case planned = "Planned"
		case inProduction = "In Production"
		case postProduction = "Post Production"
		case released = "Released"
		case canceled = "Canceled"
	}
}

extension MovieDetails {
	var releaseDateFormatted: Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter.date(from: self.releaseDate) ?? Date()
	}
}

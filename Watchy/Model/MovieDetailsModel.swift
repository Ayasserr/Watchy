//
//  MovieDetailsModel.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

struct MovieDetails: Decodable, Identifiable {
	let id: Int
	let title: String
	let overview: String?
	let tagline: String?
	let genres: [MovieGenres]
	let posterPath: String?
	let backdropPath: String?
	let releaseDate: String
	let runtime: Int?
	let status: MovieStatus
	let voteAverage: Double
	let voteCount: Int
	let adult: Bool
	let belongsToCollection: MovieCollection?
	let productionCompanies: [Companies]
	let productionCountries: [Countries]
	let spokenLanguages: [Languages]
	
	enum CodingKeys: String, CodingKey {
		case id
		case title
		case overview
		case tagline
		case genres
		case posterPath = "poster_path"
		case backdropPath = "backdrop_path"
		case releaseDate = "release_date"
		case runtime
		case status
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
		case adult
		case belongsToCollection = "belongs_to_collection"
		case productionCompanies = "production_companies"
		case productionCountries = "production_countries"
		case spokenLanguages = "spoken_languages"
	}
}

// MARK: - Empty Initalizer
extension MovieDetails {
	init() {
		self.id = 0
		self.title = ""
		self.overview = nil
		self.tagline = nil
		self.genres = []
		self.posterPath = nil
		self.backdropPath = nil
		self.releaseDate = ""
		self.runtime = nil
		self.status = .canceled
		self.voteAverage = 0.0
		self.voteCount = 0
		self.adult = false
		self.belongsToCollection = nil
		self.productionCompanies = []
		self.productionCountries = []
		self.spokenLanguages = []
	}
}

// MARK: - Formatted Properties
extension MovieDetails {
	var releaseYear: String {
		guard let date = Utilities.dateFormatter.date(from: self.releaseDate) else { return "N/A" }
		return Self.yearFormatter.string(from: date)
	}
	
	var releaseDateFormattered: String {
		guard let date = Utilities.dateFormatter.date(from: self.releaseDate) else { return "N/A" }
		return Self.fullFormatter.string(from: date)
	}
	
	var runtimeFormatted: String {
		guard let runtime = runtime else { return "N/A" }
		return Self.durationFormatter.string(from: Double(runtime) * 60) ?? "N/A"
	}
	
	var company: String {
		return productionCompanies.first?.name ?? ""
	}
	
	var countries: String {
		let strings = productionCountries.map { $0.name }
		return strings.joined(separator: ", ")
	}
	
	var languages: String {
		let strings = spokenLanguages.map { $0.name }
		return strings.joined(separator: ", ")
	}
}

// MARK: - Formatters
extension MovieDetails {
	static private let yearFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy"
		return formatter
	}()
	
	static private let fullFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .long
		return formatter
	}()
	
	static private let durationFormatter: DateComponentsFormatter = {
		let formatter = DateComponentsFormatter()
		formatter.unitsStyle = .brief
		formatter.allowedUnits = [.hour, .minute]
		return formatter
	}()
}

// MARK: - Movie Status
extension MovieDetails {
	enum MovieStatus: String, Decodable {
		case rumored = "Rumored"
		case planned = "Planned"
		case inProduction = "In Production"
		case postProduction = "Post Production"
		case released = "Released"
		case canceled = "Canceled"
	}
}

// MARK: - Companies Model
struct Companies: Identifiable, Decodable {
	let id: Int
	let name: String
}

// MARK: - Countries Model
struct Countries: Decodable {
	let name: String
}

// MARK: - Languages Model
struct Languages: Decodable {
	let name: String
	
	enum CodingKeys: String, CodingKey {
		case name = "english_name"
	}
}

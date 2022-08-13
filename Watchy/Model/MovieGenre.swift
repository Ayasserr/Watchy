//
//  MovieGenre.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

struct MovieGenres: Codable, Identifiable, Hashable {
	let id: Int
	let name: String
}

extension MovieGenres {
	var color: Color {
		switch name {
			case "Action": 			return .red
			case "Adventure": 		return .yellow
			case "Animation": 		return .orange
				
			case "Comedy":			return .green
			case "Crime":			return .brown
				
			case "Documentary":		return .brown
			case "Drama":			return .eggplant
				
			case "Family":			return .dodgerBlue
			case "Fantasy":			return .teal
				
			case "History":			return .blackCoffee
			case "Horror":			return .black
				
			case "Music":			return .cyan
			case "Mystery":			return .gray
				
			case "Romance":			return .pink
			case "Science Fiction":	return .emerald
				
			case "TV Movie":		return .indigo
			case "Thriller":		return .purple
				
			case "War":				return .black
			case "Western":			return .brown
				
			default:				return .gray.opacity(0.5)
		}
	}
}

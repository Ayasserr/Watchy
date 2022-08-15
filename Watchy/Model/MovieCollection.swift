//
//  MovieCollection.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 14/08/2022.
//

import Foundation

struct MovieCollection: Identifiable, Decodable {
	let id: Int
	let name: String
	let backdropPath: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case backdropPath = "backdrop_path"
	}
}

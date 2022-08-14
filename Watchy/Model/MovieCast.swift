//
//  MovieCast.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

struct CastResponse: Decodable {
	let cast: [Cast]
}

struct Cast: Identifiable, Codable {
	let id: Int
	let name: String
	let character: String
	let profilePath: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case character
		case profilePath = "profile_path"
	}
}

extension Cast: Equatable {
	public static func ==(lhs: Self, rhs: Self) -> Bool {
		return lhs.id == rhs.id
	}
}

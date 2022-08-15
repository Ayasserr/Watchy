//
//  MovieGenre.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation
import SwiftUI

struct MovieGenres: Decodable, Identifiable, Hashable {
	let id: Int
	let name: String
}

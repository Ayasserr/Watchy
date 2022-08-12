//
//  Endpoint.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

protocol Endpoint {
	var scheme: String { get }
	var host: String { get }
	var path: String { get }
}

extension Endpoint {
	var scheme: String { "https" }
	var host: String { "api.themoviedb.org" }
}

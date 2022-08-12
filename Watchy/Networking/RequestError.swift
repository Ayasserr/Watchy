//
//  RequestError.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

enum RequestError: Error {
	case invalidURL
	case noResponse
	case invalidResponse
	case invalidDecoding
	case unknownError
}

extension RequestError {
	public var errorMessage: String {
		switch self {
			case .invalidURL: return "Request URL is not correct."
			case .noResponse: return "No response returned from the request."
			case .invalidResponse: return "Returned response is not valid."
			case .invalidDecoding: return "Couldn't decode returned json file."
			case .unknownError: return "Unknown error occurred"
		}
	}
}

//
//  RequestDelegate.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

protocol RequestDelegate {
	func sendRequest<T>(from endpoint: Endpoint, params: [String: String]?, model: T.Type) async throws -> T where T: Decodable
}

extension RequestDelegate {
	public func sendRequest<T>(from endpoint: Endpoint, params: [String: String]? = nil, model: T.Type) async throws -> T where T: Decodable {
		var urlComponents = URLComponents()
		urlComponents.scheme = endpoint.scheme
		urlComponents.host = endpoint.host
		urlComponents.path = endpoint.path
		
		var quaryItems = [
			URLQueryItem(name: "api_key", value: API.apiKey),
			URLQueryItem(name: "language", value: "en-US")
		]
		
		if let params = params {
			quaryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
		}
		
		urlComponents.queryItems = quaryItems
		guard let url = urlComponents.url else { throw RequestError.invalidURL }
		
		// For debugging you may print url here to see what is url is going
		// out from the request.
		// print(url)
		
		// Retrieve data and response from calling url.
		let (data, response) = try await URLSession.shared.data(from: url)
		
		// Check over response if its okay or not.
		guard let response = response as? HTTPURLResponse else { throw RequestError.noResponse }
		guard (200 ..< 300) ~= response.statusCode else { throw RequestError.invalidResponse }
		
		// Decoding returne json file data from the response.
		do {
			let decodedData = try JSONDecoder().decode(model, from: data)
			return decodedData
		} catch DecodingError.keyNotFound(let key, let context) {
			fatalError("Failed to decode \(model) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
		} catch DecodingError.typeMismatch(let type, let context) {
			fatalError("Failed to decode \(model) from bundle due to type mismatch – \(context.debugDescription) -- \(type)")
		}
		catch DecodingError.valueNotFound(let type, let context) {
			fatalError("Failed to decode \(model) from bundle due to missing \(type) value – \(context.debugDescription)")
		} catch DecodingError.dataCorrupted(_) {
			fatalError("Failed to decode \(model) from bundle because it appears to be invalid JSON")
		} catch {
			fatalError("Failed to decode \(model) from bundle: \(error.localizedDescription)")
		}
	}
}

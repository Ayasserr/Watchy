//
//  DecoderJSON.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import Foundation

extension Bundle {
	func decode<T: Codable>(_ file: String) -> T {
		// 1. Locate JSON file.
		guard let url = self.url(forResource: file, withExtension: "json") else {
			fatalError("Failed to locate \(file) in bundle.")
		}
		
		// 2. Creates a property for the data.
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load \(file) from bundle.")
		}
		
		// 3. Create a decoder
		let decoder = JSONDecoder()
		
		// 4. Creates a property for decoded data.
		guard let decodedData = try? decoder.decode(T.self, from: data) else {
			fatalError("Failed to decode \(file) from bundle.")
		}
		
		// 5. Return decoded data
		return decodedData
	}
}

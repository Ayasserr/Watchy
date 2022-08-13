//
//  Color+Extension.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

// MARK: - Color HexCode Initalize
extension Color {
	/// Initialize a new Color from its hexadecimal code.
	///
	/// - Parameters:
	///   - colorSpace:
	///   - hecCode:
	///
	/// - Note: If you are going to use this color often in the project, better to add the color to the project assets.
	public init(
		_ colorSpace: Color.RGBColorSpace = .displayP3,
		hexCode: String
	) {
		let scanner = Scanner(string: hexCode)
		var rgbValues: UInt64 = 0
		scanner.scanHexInt64(&rgbValues)
		
		let r = (rgbValues & 0xff0000) >> 16
		let g = (rgbValues & 0xff00) >> 8
		let b = rgbValues & 0xff
		
		self.init(
			colorSpace,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue: Double(b) / 255
		)
	}
}

// MARK: - Main Colors
extension Color {
	/// The background color of discover screen.
	public static let backgroundColor: Color = Color("Background Color")
	
	/// The color of all texts and labels in the app.
	public static let textColor: Color = Color("Text Color")
}

// MARK: - Custom Genres Colors
extension Color {
	/// The background color for sci-fi genre.
	public static let emerald: Color = Color(hexCode: "0F8950")
	
	/// The background color for history genre.
	public static let blackCoffee: Color = Color(hexCode: "3C302F")
	
	/// The background color for drama genre.
	public static let eggplant: Color = Color(hexCode: "3E2D40")
	
	/// The background color for family genre.
	public static let dodgerBlue: Color = Color(hexCode: "1E90FF")
}

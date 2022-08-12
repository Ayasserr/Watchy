//
//  SegmentPicker.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

struct SegmentPicker: View {
	@Binding var pickerSelection: MoviesTab
	
	init(pickerSelection: Binding<MoviesTab>) {
		self._pickerSelection = pickerSelection
		
		UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.textColor)
		UISegmentedControl.appearance().setTitleTextAttributes([
			.font: UIFont.systemFont(ofSize: 15, weight: .semibold),
			.foregroundColor: UIColor(.backgroundColor)
		], for: .selected)
		UISegmentedControl.appearance().setTitleTextAttributes([
			.foregroundColor: UIColor(.textColor)
		], for: .normal)
	}
	
    var body: some View {
		Picker("", selection: $pickerSelection) {
			ForEach(MoviesTab.allCases, id: \.self) { tab in
				Text(tab.rawValue)
			}
		}
		.pickerStyle(.segmented)
    }
}

struct SegmentPicker_Previews: PreviewProvider {
    static var previews: some View {
		SegmentPicker(pickerSelection: .constant(.trending))
			.previewLayout(.sizeThatFits)
			.padding()
			.background (Color.backgroundColor)
	}
}

// MARK: - MoviesTab
enum MoviesTab: String, CaseIterable {
	case trending = "Trending"
	case nowPlaying = "Now Playing"
	case upComing = "Up Coming"
}

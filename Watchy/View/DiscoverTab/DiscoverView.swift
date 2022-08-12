//
//  DiscoverView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

struct DiscoverView: View {
	@State private var pickerSelection: MoviesTab = .trending
	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = [
			.foregroundColor: UIColor(.textColor)
		]
	}
	
    var body: some View {
		NavigationView {
			ZStack {
				Color.backgroundColor.ignoresSafeArea()
				
				VStack {
					SegmentPicker(pickerSelection: $pickerSelection)
						
				}
				.padding()
			} //: ZStack
			.navigationTitle("Discover")
			
		} //: NavigationView
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
		DiscoverView()
			.previewDevice("iPhone 13 Pro Max")
    }
}

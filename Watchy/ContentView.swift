//
//  ContentView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 12/08/2022.
//

import SwiftUI

struct ContentView: View {
	@State private var selectedTab: Tabs = .discover
	
	var body: some View {
		TabView(selection: $selectedTab) {
			DiscoverView()
				.tabItem { self.tabLabel(text: "Home", image: "house") }
			
			Text("Search")
				.tabItem { self.tabLabel(text: "Search", image: "magnifyingglass") }
		}
	}
	
	@ViewBuilder
	private func tabLabel(text: String, image: String) -> some View {
		VStack {
			Image(systemName: image).imageScale(.large)
			Text(text)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.previewDevice("iPhone 13 Pro Max")
	}
}

enum Tabs {
	case discover
	case search
}

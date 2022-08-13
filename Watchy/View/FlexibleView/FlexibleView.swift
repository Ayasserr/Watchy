//
//  FlexibleView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 03/08/2022.
//

import SwiftUI

struct FlexibleView<Data: Collection, Content: View>: View
where Data.Element: Hashable {
	@State private var availableWidth: CGFloat = 0.0
	@State private var elementsSize: [Data.Element: CGSize] = [:]
	
	let data: Data
	let content: (Data.Element) -> Content
	
	var body: some View {
		ZStack(alignment: .leading) {
			Color.clear
				.frame(height: 1)
				.readSize { size in self.availableWidth = size.width }
			
			_FlexibleView(
				availableWidth: self.availableWidth,
				data: self.data,
				content: content
			)
		}
	}
}

struct FlexibleView_Previews: PreviewProvider {
    static var previews: some View {
		FlexibleView(data: ["Animation", "Advventure", "Action", "Science Fiction", "Family", "Comedy"]) { element in
			Text(element)
				.padding(8)
				.background(.gray.opacity(0.2))
				.cornerRadius(8)
		}
		.previewDevice("iPhone 12 Pro")
		.padding(.horizontal, 50)
    }
}

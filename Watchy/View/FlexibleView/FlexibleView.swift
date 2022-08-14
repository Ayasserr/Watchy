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
	let alignment: HorizontalAlignment = .center
	let spacing: CGFloat? = nil
	
	var body: some View {
		ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
			Color.clear
				.frame(height: 1)
				.readSize { size in self.availableWidth = size.width }
			
			_FlexibleView(
				availableWidth: self.availableWidth,
				data: self.data,
				alignment: alignment,
				spacing: spacing,
				content: content
			)
		}
	}
}

struct FlexibleView_Previews: PreviewProvider {
    static var previews: some View {
		let data = ["Animation", "Advventure", "Action", "Science Fiction", "Family", "Comedy"]
		FlexibleView(data: data ) { element in
			HStack {
				Text(element)
				if data.last != element {
					Text("•")
				}
			}
		}
		.previewDevice("iPhone 13 Pro Max")
		.padding(.horizontal, 50)
    }
}

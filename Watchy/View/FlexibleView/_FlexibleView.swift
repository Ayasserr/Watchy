//
//  _FlexibleView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 04/08/2022.
//

import SwiftUI

struct _FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
	let availableWidth: CGFloat
	let data: Data
	let content: (Data.Element) -> Content
	
	@State private var elementsSize: [Data.Element: CGSize] = [:]
	
    var body: some View {
		VStack(alignment: .leading) {
			ForEach(self.computeRows(), id: \.self) { rowElements in
				HStack(spacing: 8) {
					ForEach(rowElements, id: \.self) { element in
						content(element)
							.fixedSize()
							.readSize { size in
								self.elementsSize[element] = size
							}
					}
				}
			}
		}
    }
	
	private func computeRows() -> [[Data.Element]] {
		var rows: [[Data.Element]] = [[]]
		var currentRow: Int = 0
		var remainingWidth = self.availableWidth
		
		for element in self.data {
			let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
			
			if (remainingWidth - elementSize.width) >= 0 {
				rows[currentRow].append(element)
			} else {
				currentRow += 1
				rows.append([element])
				remainingWidth = availableWidth
			}
			
			remainingWidth -= elementSize.width
		}
		
		return rows
	}
}

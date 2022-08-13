//
//  MovieDetailsView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

struct MovieDetailsView: View {
	init() {
		UINavigationBar.appearance().backIndicatorImage = UIImage(named: "chevron.left.circle.fill")
		
	}
	var body: some View {
		ZStack {
			
		}
	}
}

struct MovieDetailsView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			MovieDetailsView()
				.previewDevice("iPhone 13 Pro Max")
		}
	}
}

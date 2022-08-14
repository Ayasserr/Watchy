//
//  DiscoverView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 13/08/2022.
//

import SwiftUI

struct DiscoverView: View {
	@State private var pickerSelection: MoviesTab = .trending
	@StateObject private var discoverVM: DiscoverViewModel = DiscoverViewModel()
	
	init() {
		UITableView.appearance().showsVerticalScrollIndicator = false
		UINavigationBar.appearance().largeTitleTextAttributes = [
			.foregroundColor: UIColor(.textColor)
		]
	}
	
    var body: some View {
		NavigationView {
			ZStack {
				Color.backgroundColor.ignoresSafeArea()
				
				VStack {
					// MARK: - SegmentPicker
					SegmentPicker(pickerSelection: $pickerSelection)
						.onChange(of: pickerSelection) { newValue in
							Task { try await discoverVM.getMovies(of: newValue) }
						}
					
					// MARK: - Movies List
					List {
						ForEach(discoverVM.movies) { movie in
							ZStack {
								NavigationLink(destination: MovieDetailsView(movieID: movie.id)) {
									EmptyView()
								}
								.opacity(0)
								
								MovieListCellView(movie: movie)
							}
							.padding(.bottom)
						}
						.listRowSeparator(.hidden)
						.listRowBackground(Color.clear)
					}
					.listStyle(.plain)
				}
				.padding()
			} //: ZStack
			.navigationTitle("Discover")
			.onAppear {
				Task { try await discoverVM.getMovies(of: .trending) }
			}
		} //: NavigationView
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
		DiscoverView()
			.previewDevice("iPhone 13 Pro Max")
    }
}

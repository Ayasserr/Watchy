//
//  RateView.swift
//  Watchy
//
//  Created by Abdelrahman Abo Al Nasr on 14/08/2022.
//

import SwiftUI

struct RateView: View {
	let voteAverage: Double
	
    var body: some View {
		let stars = HStack(spacing: 10) {
			ForEach(0 ..< 5, id: \.self) { index in
				Image(systemName: "star.fill")
					.resizable()
					.aspectRatio(contentMode: .fit)
			}
		}
		
		stars.overlay {
			GeometryReader { gemoetry in
				let width = voteAverage / 5 * gemoetry.size.width
				ZStack(alignment: .center) {
					Rectangle()
						.frame(width: width)
						.foregroundColor(.yellow)
				}
			}
			.mask(stars)
		}
		.foregroundColor(.yellow.opacity(0.3))
	}
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
		RateView(voteAverage: 7.5 / 2)
			.previewLayout(.sizeThatFits)
			.padding()
    }
}

/*
 ZStack {
	 Circle()
		 .trim(from: 0, to: voteAverage / 10)
		 .stroke(rateColor, style: StrokeStyle(lineWidth: 4, lineCap: .round))
		 .rotationEffect(.degrees(-90))
	 
	 Circle()
		 .stroke(.white.opacity(0.3), lineWidth: 4)
		 
	 
	 Text(String(format: "%0.2f", voteAverage))
		 .font(.subheadline)
		 .fontWeight(.medium)
 }
 .frame(width: 50, height: 50)
 
 private var rateColor: Color {
	 switch voteAverage {
		 case 0 ..< 2.5: return .red
		 case 2.5 ..< 5: return .orange
		 case 5 ..< 7.5: return .yellow
		 case 7.5... : return .green
		 default: return .gray
	 }
 }
 */

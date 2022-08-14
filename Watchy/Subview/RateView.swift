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
		ZStack {
			Circle()
				.trim(from: 0, to: voteAverage / 10)
				.stroke(rateColor, style: StrokeStyle(lineWidth: 4, lineCap: .round))
				.rotationEffect(.degrees(-90))
			
			Circle()
				.stroke(.white.opacity(0.3), lineWidth: 4)
				
			
			Text(String(format: "%0.2f", voteAverage))
				.font(.subheadline)
		}
		.frame(width: 50, height: 50)
	}
	
	private var rateColor: Color {
		switch voteAverage {
			case 0 ..< 2.5: return .red
			case 2.5 ..< 5: return .orange
			case 5 ..< 7.5: return .yellow
			case 7.5... : return .green
			default: return .gray
		}
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
		RateView(voteAverage: 7.5)
			.previewLayout(.sizeThatFits)
			.padding()
			.background(.gray)
    }
}

//
//  RateCircle.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

enum CircleSize {
    case small
    case large
}

struct RateCircle: View {
    let rate: Double
    var size: CircleSize = .small

    var body: some View {
        Text(rate.formatted(.number.precision(.integerAndFractionLength(integer: 1, fraction: 1))))
            .foregroundColor(.black)
            .font(size == .small ? .caption : .title)
            .bold()
            .padding(size == .small ? 8 : 15)
            .background {
                Circle()
                    .trim(from: 0.0, to: rate / 5)
                    .stroke(style: StrokeStyle(lineWidth: size == .small ? 5 : 10, lineCap: .round))
                    .fill(rate < 8 ? Color.orange : Color.yellow)
                    .rotationEffect(.degrees(-90))
            }
            .background {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: size == .small ? 5 : 10, lineCap: .round))
                    .fill(Color.gray.opacity(0.5))
            }
            .background {
                Circle()
                    .fill(Color(white: 0.9))
            }
            .padding(.top, size == .small ? 5 : 20)
    }
}

struct RateCircle_Previews: PreviewProvider {
    static var previews: some View {
        RateCircle(rate: 4.5, size: .large)
    }
}

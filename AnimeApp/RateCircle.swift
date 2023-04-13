//
//  RateCircle.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

enum CircleSize: Int {
    case small = 40
    case large = 100
}

struct RateCircle: View {
    let rate: Double
    var size: CircleSize = .small
    let gradient = Gradient(colors: [.green, .yellow, .orange, .red])

    var body: some View {
        Gauge(value: rate, in: 0 ... 5)
            {}
            currentValueLabel: {
                Text(String(format: "%.1f", rate))
            }
            .gaugeStyle(SpeedometerGaugeStyle(size: size))
    }
}

struct RateCircle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                RateCircle(rate: 4.5, size: .small)
                RateCircle(rate: 4.5, size: .large)
                    .padding(.top, 20)
            }
        }
    }
}

struct SpeedometerGaugeStyle: GaugeStyle {
    let size: CircleSize
    let gradient = Gradient(colors: [.red, .orange, .yellow, .green])

    var purpleGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255)]), startPoint: .trailing, endPoint: .leading)

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color(.white))

            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color(red: 230/255, green: 230/255, blue: 230/255), lineWidth: size == .small ? 6 : 12)
                .rotationEffect(.degrees(-90))

            Circle()
                .trim(from: 0, to: configuration.value)
                .stroke(gradient, lineWidth: size == .small ? 6 : 12)
                .rotationEffect(.degrees(-90))

            configuration.currentValueLabel
                .font(.system(size: size == .small ? 12 : 20, weight: .bold, design: .rounded))
                .foregroundColor(.green)
        }
        .frame(width: size == .small ? 30 : 60, height: size == .small ? 30 : 60)
    }
}

//
//  AnimeCell.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

struct AnimeCell: View {
    let anime: Anime

    var body: some View {
        HStack {
            AnimeImage(url: anime.image)
            Spacer()
            VStack(alignment: .leading) {
                Text(anime.title)
                    .font(.headline)

                HStack {
                    Text(anime.type.rawValue)
                    Text("-")
                    Text(String(anime.year))
                }
                .font(.footnote)
                RateCircle(rate: anime.rateNumber)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct AnimeCell_Previews: PreviewProvider {
    static var previews: some View {
        AnimeCell(anime: .test)
    }
}

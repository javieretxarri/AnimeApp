//
//  AnimeGridCell.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 4/4/23.
//

import SwiftUI

struct AnimeGridCell: View {
    let anime: Anime

    var body: some View {
        VStack {
            AnimeImage(url: anime.image)
            HStack {
                Text(anime.type.rawValue)
                Text("-")
                Text(String(anime.year))
            }
            .font(.footnote)
            .bold()
        }
    }
}

struct AnimeGridCell_Previews: PreviewProvider {
    static var previews: some View {
        AnimeGridCell(anime: .test)
    }
}

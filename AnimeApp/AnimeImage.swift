//
//  AnimeImage.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

enum ImageSize: CGFloat {
    case large = 300
    case medium = 200
    case small = 100
}

struct AnimeImage: View {
    let url: URL
    var size: ImageSize = .small

    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: size.rawValue, height: size.rawValue * 1.5)
                .cornerRadius(10)
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .padding()
                .frame(width: size.rawValue, height: size.rawValue * 1.5)
                .background { Color(white: 0.95) }
                .cornerRadius(10)
        }
    }
}

struct AnimeImage_Previews: PreviewProvider {
    static var previews: some View {
        AnimeImage(url: Anime.test.image)
    }
}

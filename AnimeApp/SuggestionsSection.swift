//
//  SuggestionsSection.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 4/4/23.
//

import SwiftUI

struct SuggestionsSection: View {
    let columns: Int
    let suggestions: [Anime]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Suggestions for you")
                .font(.body)
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 5)

        let gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: columns)
        LazyVGrid(columns: gridItems) {
            ForEach(suggestions) { anime in
                NavigationLink(value: anime) {
                    AnimeGridCell(anime: anime)
                }
            }
        }
    }
}

struct SuggestionsSection_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsSection(columns: 3, suggestions: [.test])
    }
}

//
//  DetailView.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var vm: AnimesVM
    let anime: Anime

    @State var shared = false
    @State var suggestions: [Anime] = []

    let columnsToShow = UIDevice.current.userInterfaceIdiom == .pad ? 8 : 3

    var body: some View {
        ScrollView {
            LazyVStack {
                AnimeImage(url: anime.image, size: .large)
                    .overlay(alignment: .bottomLeading) {
                        RateCircle(rate: anime.rateNumber, size: .large)
                            .offset(x: -20, y: 20)
                    }

                Text(anime.title)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(.top, 25)

                HStack {
                    Text(String(anime.year))
                        .font(.footnote)
                        .bold()
                    Text("-")
                    Text(String(anime.status.rawValue))
                        .font(.footnote)
                        .bold()
                }

                if let description = anime.description {
                    Text(description)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .bold()
                        .padding(.top, 5)
                }

                VStack {
                    HStack {
                        Text("**\(Image(systemName: "film"))**: \(anime.type.rawValue)")
                            .padding(.top)
                        Spacer()
                        Text("**\(Image(systemName: "person.3.fill"))**: \(String(anime.followers))")
                    }
                    HStack {
                        Text("**Votes**: \(anime.votes)")
                        Spacer()
                        Text("**Episodes**: \(anime.episodes)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body)

                if suggestions.count > 0 {
                    SuggestionsSection(columns: columnsToShow, suggestions: suggestions)
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Anime detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: anime.urlAnime)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    Button {
                        if vm.isWatched(anime: anime) {
                            vm.removeFromWatched(anime: anime)
                        } else {
                            vm.addToWatched(anime: anime)
                        }
                    } label: {
                        Text(vm.isWatched(anime: anime) ? "Mark as not watched" : "Mark as watched")
                    }
                }
            }
        }
        .onAppear {
            suggestions = vm.getSuggestions(num: columnsToShow)
        }
        .onChange(of: anime) { _ in
            suggestions = vm.getSuggestions(num: columnsToShow)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(anime: .test)
            .environmentObject(AnimesVM.preview)
    }
}

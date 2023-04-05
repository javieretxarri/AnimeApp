//
//  Home.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var vm: AnimesVM

    var body: some View {
        TabView {
            Group {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    AnimeListViewIpad()
                        .tabItem {
                            Label("Anime", systemImage: "film.stack.fill")
                        }
                } else {
                    AnimeListView()
                        .tabItem {
                            Label("Anime", systemImage: "film.stack.fill")
                        }
                }

                WatchedAnimesGridView()
                    .tabItem {
                        Label("Whatched", systemImage: "eye.fill")
                    }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(AnimesVM.preview)
    }
}

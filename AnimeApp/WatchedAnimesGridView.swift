//
//  WatchedAnimesGridView.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 4/4/23.
//

import SwiftUI

struct WatchedAnimesGridView: View {
    @EnvironmentObject var vm: AnimesVM
    let gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: UIDevice.current.userInterfaceIdiom == .pad ? 6 : 3)

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems) {
                    ForEach(vm.watched) { anime in
                        NavigationLink(value: anime) {
                            AnimeGridCell(anime: anime)
                        }
                    }
                }
                .navigationTitle("Watched")
            }
            .navigationDestination(for: Anime.self) { anime in
                DetailView(anime: anime)
            }
        }
        .alert("Error en la pantalla", isPresented: $vm.showAlert) {
            Button {} label: { Text("OK") }
        } message: {
            Text(vm.errorMsg)
        }
    }
}

struct WatchedAnimesGridView_Previews: PreviewProvider {
    static var previews: some View {
        WatchedAnimesGridView()
            .environmentObject(AnimesVM.preview)
    }
}

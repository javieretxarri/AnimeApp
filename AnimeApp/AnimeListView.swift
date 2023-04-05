//
//  AnimeListView.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import SwiftUI

struct AnimeListView: View {
    @EnvironmentObject var vm: AnimesVM

    var body: some View {
        NavigationStack {
            List(vm.animessSearch) { anime in
                NavigationLink(value: anime) {
                    AnimeCell(anime: anime)
                        .swipeActions(edge: .leading) {
                            Button {
                                if vm.isWatched(anime: anime) {
                                    vm.removeFromWatched(anime: anime)
                                } else {
                                    vm.addToWatched(anime: anime)
                                }
                            } label: {
                                Label("Watched", systemImage: "eye")
                            }
                            .tint(vm.isWatched(anime: anime) ? Color(.red) : Color(.init(red: 0, green: 100, blue: 230, alpha: 1)))
                        }
                }
            }
            .navigationTitle("Animes")
            .navigationDestination(for: Anime.self) { anime in
                DetailView(anime: anime)
            }
            .searchable(text: $vm.search)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu("Sorted by") {
                        Picker(selection: $vm.sorted) {
                            ForEach(AnimesVM.SortedBy.allCases) { sorted in
                                Text(sorted.rawValue)
                            }
                        } label: {
                            Text("Sorted by")
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu("Filter by") {
                        Picker(selection: $vm.filtered) {
                            ForEach(vm.filteredTypes) { filtered in
                                Text(filtered.rawValue)
                            }
                        } label: {
                            Text("Filter by")
                        }
                    }
                }
            }
        }
        .alert("Error en la pantalla", isPresented: $vm.showAlert) {
            Button {} label: { Text("OK") }
        } message: {
            Text(vm.errorMsg)
        }
        .animation(.default, value: vm.search)
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListView()
            .environmentObject(AnimesVM.preview)
    }
}

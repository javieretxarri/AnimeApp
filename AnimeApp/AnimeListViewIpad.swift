//
//  AnimeListViewIpadIpad.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 5/4/23.
//

import SwiftUI

struct AnimeListViewIpad: View {
    @EnvironmentObject var vm: AnimesVM
    @State var visibility: NavigationSplitViewVisibility = .doubleColumn
    @State var selection: Anime.ID?

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(vm.animessSearch, selection: $selection) { anime in
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
            .navigationTitle("Animes")
            .navigationDestination(for: Anime.self) { anime in
                DetailView(anime: anime)
                    .searchable(text: $vm.search, placement: .toolbar)
            }
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
        } detail: {
            if let selection, let anime = vm.animeById(id: selection) {
                NavigationStack {
                    DetailView(anime: anime)
                        .searchable(text: $vm.search, placement: .toolbar)
                        .navigationDestination(for: Anime.self) { anime in
                            DetailView(anime: anime)
                                .searchable(text: $vm.search, placement: .toolbar)
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
        .onAppear {
            selection = vm.animessSearch.first?.id
        }
    }
}

struct AnimeListViewIpad_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListViewIpad()
            .environmentObject(AnimesVM.preview)
    }
}

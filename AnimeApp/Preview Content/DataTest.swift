//
//  DataTest.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import Foundation

final class AnimePreviewPersistence: AnimesPersistence {
    static let shared = AnimePreviewPersistence()
    let fileURL = Bundle.main.url(forResource: "animetest", withExtension: "json")!
    let fileWatchedDocument = Bundle.main.url(forResource: "watchedanimestest", withExtension: "json")!

    func loadAnimes() throws -> [Anime] {
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Anime].self, from: data)
    }

    func loadWatched() throws -> [Anime] {
        let data = try Data(contentsOf: fileWatchedDocument)
        return try JSONDecoder().decode([Anime].self, from: data)
    }

    func saveWatched(animes: [Anime]) throws {}
}

extension Anime {
    static let test = Anime(
        title: "Dragon Ball Z Pelicula 03: La batalla más grande del mundo esta por comenzar",
        description: "Una banda de desértores del ejército de Freezer capitaneada por el misterioso Tarles llega a la tierra con una semilla terrible. Una vez plantada, surge un árbol monstruoso que amenaza con absorver toda vida en el planeta...",
        year: 1990,
        type: .película,
        rateStart: "3.9",
        votes: 173,
        status: .finalizado,
        followers: 1090,
        episodes: 1,
        urlAnime: URL(string: "https://www3.animeflv.net/anime/dragon-ball-z-pelicula-3")!,
        image: URL(string: "https://www3.animeflv.net/uploads/animes/covers/1104.jpg")!,
        genres: "Aventuras,Ciencia Ficción,Comedia,Fantasía,Shounen")
}

extension AnimesVM {
    static let preview = AnimesVM(persistence: AnimePreviewPersistence())
}

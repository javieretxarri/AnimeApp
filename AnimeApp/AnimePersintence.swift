//
//  AnimePersintence.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import Foundation

protocol AnimesPersistence {
    func loadAnimes() throws -> [Anime]
    func loadWatched() throws -> [Anime]
    func saveWatched(animes: [Anime]) throws
}

final class AnimeProdPersistence: AnimesPersistence {
    static let shared = AnimeProdPersistence()
    let fileURL = Bundle.main.url(forResource: "anime", withExtension: "json")!
    let fileWatchedDocument = URL.documentsDirectory.appending(path: "watchedanimes.json")

    func loadAnimes() throws -> [Anime] {
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([Anime].self, from: data)
    }

    func loadWatched() throws -> [Anime] {
        if FileManager.default.fileExists(atPath: fileWatchedDocument.path()) {
            let data = try Data(contentsOf: fileWatchedDocument)
            return try JSONDecoder().decode([Anime].self, from: data)
        } else {
            return []
        }
    }

    func saveWatched(animes: [Anime]) throws {
        let data = try JSONEncoder().encode(animes)
        try data.write(to: fileWatchedDocument, options: .atomic)
    }
}

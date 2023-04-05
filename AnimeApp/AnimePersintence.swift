//
//  AnimePersintence.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import Foundation

protocol FileLocation {
    var fileURL: URL { get }
}

struct FileProduction: FileLocation {
    var fileURL: URL {
        Bundle.main.url(forResource: "anime", withExtension: "json")!
    }
}

final class AnimePersistence {
    static let shared = AnimePersistence()

    let watchedAnimesDocument = URL.documentsDirectory.appending(path: "watchedanimes.json")

    let fileLocation: FileLocation

    init(fileLocation: FileLocation = FileProduction()) {
        self.fileLocation = fileLocation
    }

    func loadAnimes() throws -> [Anime] {
        let data = try Data(contentsOf: fileLocation.fileURL)
        return try JSONDecoder().decode([Anime].self, from: data)
    }

    func loadWatched() throws -> [Anime] {
        if FileManager.default.fileExists(atPath: watchedAnimesDocument.path()) {
            let data = try Data(contentsOf: watchedAnimesDocument)
            return try JSONDecoder().decode([Anime].self, from: data)
        } else {
            return []
        }
    }

    func saveWatched(animes: [Anime]) throws {
        let data = try JSONEncoder().encode(animes)
        try data.write(to: watchedAnimesDocument, options: .atomic)
    }
}

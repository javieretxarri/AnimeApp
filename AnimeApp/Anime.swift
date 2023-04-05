//
//  Anime.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import Foundation

// MARK: - Anime

struct Anime: Codable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String?
    let year: Int
    let type: AnimeType
    let rateStart: String
    let votes: Int
    let status: Status
    let followers: Int
    let episodes: Int
    let urlAnime: URL
    let image: URL
    let genres: String?

    enum CodingKeys: String, CodingKey {
        case title, description, year, type
        case rateStart = "rate_start"
        case votes, status, followers, episodes
        case urlAnime = "url_anime"
        case image, genres
    }

    var rateNumber: Double {
        Double(rateStart) ?? 0.0
    }
}

enum Status: String, Codable {
    case enEmision = "En emision"
    case finalizado = "Finalizado"
    case proximamente = "Proximamente"
}

enum AnimeType: String, Codable, CaseIterable, Identifiable {
    var id: AnimeType { self }

    case anime = "Anime"
    case especial = "Especial"
    case ova = "OVA"
    case película = "Película"
    case none = "None"
}

extension Anime {
    static func == (l: Anime, r: Anime) -> Bool {
        l.title == r.title && l.description == r.description
            && l.year == r.year && l.type == r.type
            && l.rateStart == r.rateStart && l.votes == r.votes
            && l.status == r.status && l.followers == r.followers && l.episodes == r.episodes
            && l.urlAnime == r.urlAnime && l.image == r.image && l.genres == r.genres
    }
}

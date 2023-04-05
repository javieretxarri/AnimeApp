//
//  AnimesVM.swift
//  AnimeApp
//
//  Created by Javier Etxarri on 3/4/23.
//

import Foundation

final class AnimesVM: ObservableObject {
    enum SortedBy: String, CaseIterable, Identifiable {
        var id: SortedBy { self }

        case titleAscendent = "Title Ascendent"
        case titleDescendent = "Title Descendent"
        case yearAscendent = "Year Ascendent"
        case yearDescendent = "Year Descendent"
        case rateAscendent = "Rate Ascending"
        case rateDescendent = "Rate Descending"
        case none = "None"
    }

    let persistence: AnimePersistence
    let filteredTypes = AnimeType.allCases

    @Published var animes: [Anime]
    @Published var watched: [Anime] {
        didSet {
            try? persistence.saveWatched(animes: watched)
        }
    }

    @Published var search = ""
    @Published var sorted: SortedBy = .none
    @Published var filtered: AnimeType = .none
    @Published var welcomeDone = false

    var animessSearch: [Anime] {
        animes.filter { anime in
            if search.isEmpty {
                return true
            } else {
                return anime.title.lowercased().contains(search.lowercased())
            }
        }.filter { anime in
            if filtered == .none {
                return true
            } else {
                return anime.type == filtered
            }
        }
        .sorted { m1, m2 in
            switch sorted {
            case .titleAscendent:
                return m1.title < m2.title
            case .titleDescendent:
                return m1.title > m2.title
            case .yearAscendent:
                return m1.year < m2.year
            case .yearDescendent:
                return m1.year > m2.year
            case .rateAscendent:
                return m1.rateNumber < m2.rateNumber
            case .rateDescendent:
                return m1.rateNumber > m2.rateNumber
            case .none:
                return m1.year < m2.year
            }
        }
    }

    @Published var showAlert = false
    @Published var errorMsg = ""

    init(persistence: AnimePersistence = .shared) {
        self.persistence = persistence
        do {
            self.animes = try persistence.loadAnimes()
            self.watched = try persistence.loadWatched()
            self.welcomeDone = UserDefaults.standard.bool(forKey: "welcomedone")
        } catch {
            self.animes = []
            self.watched = []
            self.errorMsg = error.localizedDescription
            showAlert.toggle()
        }
    }

    func isWatched(anime: Anime) -> Bool {
        if let _ = (watched.first { watched in
            watched == anime
        }) {
            return true
        } else {
            return false
        }
    }

    func addToWatched(anime: Anime) {
        watched.append(anime)
    }

    func removeFromWatched(anime: Anime) {
        watched.removeAll { $0 == anime }
    }

    func getSuggestions(num: Int) -> [Anime] {
        var suggestions: [Anime] = []

        for _ in 0 ..< num {
            suggestions.append(animes.randomElement()!)
        }
        return suggestions
    }

    func setWelcomeDone(_ value: Bool) {
        UserDefaults.standard.set(true, forKey: "welcomedone")
        welcomeDone = true
    }

    func animeById(id: UUID) -> Anime? {
        animes.first(where: { $0.id == id })
    }
}

//
//  FavoritesManager.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation
import Combine

class FavoritesManager: ObservableObject {
    
    static let shared = FavoritesManager()
    
    @Published var favorites: [Movie] = []
    
    private let key = "favorites"
    
    init() {
        loadFavorites()
    }
    
    func addFavorite(_ movie: Movie) {
        guard !isFavorite(movie) else { return }
        favorites.append(movie)
        saveFavorites()
    }
    
    func removeFavorite(_ movie: Movie) {
        favorites.removeAll { $0.id == movie.id }
        saveFavorites()
    }
    
    func toggleFavorite(_ movie: Movie) {
        if isFavorite(movie) {
            removeFavorite(movie)
        } else {
            addFavorite(movie)
        }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains { $0.id == movie.id }
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    // ✅ Вчитај од UserDefaults
    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let saved = try? JSONDecoder().decode([Movie].self, from: data) else { return }
        favorites = saved
    }
}

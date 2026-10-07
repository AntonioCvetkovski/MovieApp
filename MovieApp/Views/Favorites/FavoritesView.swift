//
//  FavoritesView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import SwiftUI
import MovieCore

struct FavoritesView: View {
    
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @State private var selectedMovie: Movie?
    
    var body: some View {
        NavigationStack {
            UIKitFavoritesView(
                movies: favoritesManager.favorites,
                onMovieSelected: { movie in
                    selectedMovie = movie
                },
                onMovieRemoved: { movie in
                    favoritesManager.removeFavorite(movie)
                }
            )
            .navigationTitle("Favorites")
            .navigationDestination(item: $selectedMovie) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}

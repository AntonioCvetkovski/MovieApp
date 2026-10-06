//
//  FavoritesView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var favoritesManager = FavoritesManager.shared
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            Group {
                if favoritesManager.favorites.isEmpty {
                    // ✅ Empty State
                    VStack(spacing: 16) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No favorites yet")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.gray)
                        Text("Tap the heart icon on any movie to add it to your favorites")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favoritesManager.favorites) { movie in
                                NavigationLink(value: movie) {
                                    MovieCardView(movie: movie)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
    }
}

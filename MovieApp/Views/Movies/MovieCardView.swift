//
//  MovieCardView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import SwiftUI

struct MovieCardView: View {
    
    let movie: Movie
    @ObservedObject var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                
                // Poster Image
                MovieImageView(url: URL(string: movie.posterURL ?? ""))
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .clipped()
                
                // Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.displayTitle)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.yellow)
                        Text(movie.formattedRating)
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(movie.displayDate.prefix(4))
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(8)
                .background(Color(.systemBackground))
            }
            
            // Favorites button
            Button {
                favoritesManager.toggleFavorite(movie)
            } label: {
                Image(systemName: favoritesManager.isFavorite(movie) ? "heart.fill" : "heart")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(favoritesManager.isFavorite(movie) ? .red : .white)
                    .padding(6)
                    .background(.black.opacity(0.4))
                    .clipShape(Circle())
            }
            .padding(8)
        }
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4)
    }
}

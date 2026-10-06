//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    @StateObject var viewModel = MovieDetailViewModel()
    @ObservedObject var favoritesManager = FavoritesManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            let width = max(geometry.size.width, 1)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // ✅ Backdrop Image
                    AsyncImage(url: URL(string: movie.backdropURL ?? "")) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay { ProgressView().tint(.red) }
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay {
                                    Image(systemName: "film")
                                        .font(.largeTitle)
                                        .foregroundColor(.gray)
                                }
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: width, height: 250)
                    .clipped()
                    
                    // ✅ Content
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // Title + Rating
                        HStack(alignment: .top) {
                            Text(movie.displayTitle)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(movie.formattedRating)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(8)
                        }
                        
                        // Info Row
                        HStack(spacing: 12) {
                            Label(movie.displayDate.prefix(4).description, systemImage: "calendar")
                            if let detail = viewModel.movieDetail {
                                Label(detail.formattedRuntime, systemImage: "clock")
                                Label("\(detail.voteCount ?? 0) votes", systemImage: "person.2")
                            }
                        }
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        
                        // Genres
                        if let genres = viewModel.movieDetail?.genres, !genres.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(genres) { genre in
                                        Text(genre.name)
                                            .font(.system(size: 12, weight: .medium))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(Color.red.opacity(0.1))
                                            .foregroundColor(.red)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        
                        Divider()
                        
                        // Overview
                        Text("Overview")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text(movie.overview ?? "No overview available")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                        
                        // Extra Details
                        if let detail = viewModel.movieDetail {
                            Divider()
                            
                            if let tagline = detail.tagline, !tagline.isEmpty {
                                Text("\"\(tagline)\"")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                                    .italic()
                            }
                            
                            if let budget = detail.budget, budget > 0 {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Budget")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(detail.formattedBudget)
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("Status")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text(detail.status ?? "N/A")
                                            .font(.system(size: 14, weight: .semibold))
                                    }
                                }
                            }
                            
                            if let companies = detail.productionCompanies, !companies.isEmpty {
                                Divider()
                                Text("Production")
                                    .font(.system(size: 16, weight: .semibold))
                                
                                ForEach(companies.prefix(3)) { company in
                                    Text(company.name)
                                        .font(.system(size: 13))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.red)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(width: geometry.size.width > 0 ? geometry.size.width - 32 : 300)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favoritesManager.toggleFavorite(movie)
                } label: {
                    Image(systemName: favoritesManager.isFavorite(movie) ? "heart.fill" : "heart")
                        .foregroundColor(favoritesManager.isFavorite(movie) ? .red : .gray)
                }
            }
        }
        .onAppear {
            Task { await viewModel.fetchMovieDetail(id: movie.id) }
        }
    }
}

//
//  MoviesView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import SwiftUI
import MovieCore

struct MoviesView: View {
    
    @StateObject var viewModel = MoviesViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let columns = Array(
                repeating: GridItem(.flexible()),
                count: isLandscape ? 3 : 2
            )
            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .tint(.red)
                    } else if let error = viewModel.errorMessage {
                        // ✅ Error State
                        VStack(spacing: 16) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.system(size: 50))
                                .foregroundColor(.red)
                            Text(error)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                            Button("Retry") {
                                Task { await viewModel.fetchTrendingMovies() }
                            }
                            .foregroundColor(.red)
                        }
                        .padding()
                    } else {
                        // ✅ Grid
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(value: movie) {
                                        MovieCardView(movie: movie)
                                    }
                                    // ✅ Тука — после NavigationLink
                                    .onAppear {
                                        if movie.id == viewModel.movies.last?.id {
                                            Task { await viewModel.loadMoreMovies() }
                                        }
                                    }
                                }
                                
                                // ✅ Loading indicator
                                if viewModel.isLoadingMore {
                                    ProgressView()
                                        .tint(.red)
                                        .gridCellColumns(2)
                                }
                            }
                            .padding()
                        }
                        .refreshable {
                            await viewModel.fetchTrendingMovies()
                        }
                    }
                }
                .navigationTitle("Trending Movies")
                .navigationDestination(for: Movie.self) { movie in
                    MovieDetailView(movie: movie)
                }
            }
            .onAppear {
                Task { await viewModel.fetchTrendingMovies() }
            }
        }
    }
}

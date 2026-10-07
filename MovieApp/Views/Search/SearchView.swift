//
//  SearchView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import SwiftUI
import MovieCore

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    @State private var searchText = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // ✅ Search Type Picker
                Picker("Search Type", selection: $viewModel.searchType) {
                    ForEach(SearchType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Group {
                    if viewModel.isLoading {
                        ProgressView("Searching...")
                            .tint(.red)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if viewModel.movies.isEmpty && !viewModel.searchText.isEmpty {
                        // ✅ Empty State
                        VStack(spacing: 16) {
                            Image(systemName: "film.slash")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("No results found")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if viewModel.searchText.isEmpty {
                        // ✅ Initial State
                        VStack(spacing: 16) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("Search for movies or TV shows")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        // ✅ Results
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(value: movie) {
                                        MovieCardView(movie: movie)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search movies & TV shows...")
            .onChange(of: searchText) {
                viewModel.searchText = searchText
            }
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
        .onAppear {
            viewModel.setupSearch()
        }
    }
}

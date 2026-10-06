//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation
import Combine

class MoviesViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var errorMessage: String?
    
    // MARK: - Pagination
    private var currentPage = 1
    private var totalPages = 1
    var hasMorePages: Bool { currentPage <= totalPages }
    
    // MARK: - Repository
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
    }
    
    // MARK: - Fetch Trending
    @MainActor
    func fetchTrendingMovies() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        currentPage = 1
        
        do {
            let response = try await repository.getTrendingMovies(page: currentPage)
            movies = response.results
            totalPages = response.totalPages
            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Load More
    @MainActor
    func loadMoreMovies() async {
        guard !isLoadingMore && hasMorePages else { return }
        isLoadingMore = true
        
        do {
            let response = try await repository.getTrendingMovies(page: currentPage)
            movies.append(contentsOf: response.results)
            totalPages = response.totalPages
            currentPage += 1
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoadingMore = false
    }
}

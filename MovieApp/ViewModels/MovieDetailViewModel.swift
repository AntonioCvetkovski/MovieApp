//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation
import Combine
import MovieCore

class MovieDetailViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var movieDetail: MovieDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Repository
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
    }
    
    // MARK: - Fetch Detail
    @MainActor
    func fetchMovieDetail(id: Int) async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            movieDetail = try await repository.getMovieDetail(id: id)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}

//
//  SearchType.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation
import Combine
import MovieCore

enum SearchType: String, CaseIterable {
    case movies = "Movies"
    case tv = "TV Shows"
}

class SearchViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var searchText = ""
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchType: SearchType = .movies
    
    // MARK: - Combine
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Repository
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
        setupSearch()
    }
    
    // MARK: - Setup Search
    func setupSearch() {
        Publishers.CombineLatest($searchText, $searchType)
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates(by: { $0.0 == $1.0 && $0.1 == $1.1 })
            .filter { !$0.0.isEmpty }
            .sink { [weak self] text, type in
                Task {
                    await self?.search(query: text, type: type)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Search
    @MainActor
    func search(query: String, type: SearchType) async {
        guard !query.isEmpty else {
            movies = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let response: MovieResponse
            switch type {
            case .movies:
                response = try await repository.searchMovies(query: query, page: 1)
            case .tv:
                response = try await repository.searchTV(query: query, page: 1)
            }
            movies = response.results
        } catch {
            errorMessage = error.localizedDescription
            movies = []
        }
        
        isLoading = false
    }
    
    // MARK: - Clear
    func clearSearch() {
        searchText = ""
        movies = []
        errorMessage = nil
    }
}

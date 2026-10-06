//
//  MovieRepositoryProtocol.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation

// Protocol
protocol MovieRepositoryProtocol {
    func getTrendingMovies(page: Int) async throws -> MovieResponse
    func getMovieDetail(id: Int) async throws -> MovieDetail
    func searchMovies(query: String, page: Int) async throws -> MovieResponse
    func searchTV(query: String, page: Int) async throws -> MovieResponse
}

// Implementation
class MovieRepository: MovieRepositoryProtocol {
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func getTrendingMovies(page: Int) async throws -> MovieResponse {
        return try await apiManager.request(
            APIConstants.Endpoints.trendingMovies,
            queryItems: [URLQueryItem(name: "page", value: "\(page)")]
        )
    }
    
    func getMovieDetail(id: Int) async throws -> MovieDetail {
        return try await apiManager.request(
            "\(APIConstants.Endpoints.movieDetails)/\(id)",
            queryItems: nil
        )
    }
    
    func searchMovies(query: String, page: Int) async throws -> MovieResponse {
        return try await apiManager.request(
            APIConstants.Endpoints.searchMovies,
            queryItems: [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        )
    }
    
    func searchTV(query: String, page: Int) async throws -> MovieResponse {
        return try await apiManager.request(
            APIConstants.Endpoints.searchTV,
            queryItems: [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        )
    }
}

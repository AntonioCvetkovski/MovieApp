//
//  MovieRepositoryProtocol.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation

// Protocol
public protocol MovieRepositoryProtocol {
    func getTrendingMovies(page: Int) async throws -> MovieResponse
    func getMovieDetail(id: Int) async throws -> MovieDetail
    func searchMovies(query: String, page: Int) async throws -> MovieResponse
    func searchTV(query: String, page: Int) async throws -> MovieResponse
}

// Implementation
public class MovieRepository: MovieRepositoryProtocol {
    
    private let apiManager: APIManagerProtocol
    
    public init(apiManager: APIManagerProtocol? = nil) {
        self.apiManager = apiManager ?? APIManager.shared
    }
    
    public func getTrendingMovies(page: Int) async throws -> MovieResponse {
        return try await apiManager.request(
            APIConstants.Endpoints.trendingMovies,
            queryItems: [URLQueryItem(name: "page", value: "\(page)")]
        )
    }
    
    public func getMovieDetail(id: Int) async throws -> MovieDetail {
        return try await apiManager.request(
            "\(APIConstants.Endpoints.movieDetails)/\(id)",
            queryItems: nil
        )
    }
    
    public func searchMovies(query: String, page: Int) async throws -> MovieResponse {
        return try await apiManager.request(
            APIConstants.Endpoints.searchMovies,
            queryItems: [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        )
    }
    
    public func searchTV(query: String, page: Int) async throws -> MovieResponse {
        return try await apiManager.request(
            APIConstants.Endpoints.searchTV,
            queryItems: [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        )
    }
}

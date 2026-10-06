//
//  MockMovieRepository.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 06/10/2026.
//


import Foundation
@testable import MovieApp

class MockMovieRepository: MovieRepositoryProtocol {
    
    var shouldFail = false
    
    func getTrendingMovies(page: Int) async throws -> MovieResponse {
        if shouldFail { throw NetworkError.invalidResponse }
        return MovieResponse(
            page: 1,
            results: Movie.mockData,
            totalPages: 5,
            totalResults: 100
        )
    }
    
    func getMovieDetail(id: Int) async throws -> MovieDetail {
        if shouldFail { throw NetworkError.invalidResponse }
        return MovieDetail.mock
    }
    
    func searchMovies(query: String, page: Int) async throws -> MovieResponse {
        if shouldFail { throw NetworkError.invalidResponse }
        return MovieResponse(page: 1, results: Movie.mockData, totalPages: 1, totalResults: 20)
    }
    
    func searchTV(query: String, page: Int) async throws -> MovieResponse {
        if shouldFail { throw NetworkError.invalidResponse }
        return MovieResponse(page: 1, results: Movie.mockData, totalPages: 1, totalResults: 20)
    }
}

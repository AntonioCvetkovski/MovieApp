//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let title: String?
    let name: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let releaseDate: String?
    let firstAirDate: String?
    let popularity: Double?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIds: [Int]?
    let mediaType: String?
    let adult: Bool?
    let video: Bool?
    
    var displayTitle: String {
        title ?? name ?? "Unknown"
    }
    
    var displayDate: String {
        releaseDate ?? firstAirDate ?? "Unknown"
    }
    
    var posterURL: String? {
        guard let path = posterPath else { return nil }
        return APIConstants.imageBaseURL + APIConstants.ImageSize.medium + path
    }
    
    var posterLowResURL: String? {
        guard let path = posterPath else { return nil }
        return APIConstants.imageBaseURL + APIConstants.ImageSize.low + path
    }
    
    var backdropURL: String? {
        guard let path = backdropPath else { return nil }
        return APIConstants.imageBaseURL + APIConstants.ImageSize.high + path
    }
    
    var formattedRating: String {
        guard let rating = voteAverage else { return "N/A" }
        return String(format: "%.1f", rating)
    }
}

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

extension Movie {
    static let mockData: [Movie] = [
        Movie(
            id: 1,
            title: "Spider-Man",
            name: nil,
            overview: "A great movie",
            posterPath: "/test.jpg",
            backdropPath: "/backdrop.jpg",
            voteAverage: 8.5,
            voteCount: 1000,
            releaseDate: "2026-01-01",
            firstAirDate: nil,
            popularity: 100.0,
            originalLanguage: "en",
            originalTitle: "Spider-Man",
            genreIds: [28, 12],
            mediaType: "movie",
            adult: false,
            video: false
        ),
        Movie(
            id: 2,
            title: "Avengers",
            name: nil,
            overview: "Another great movie",
            posterPath: "/test2.jpg",
            backdropPath: "/backdrop2.jpg",
            voteAverage: 9.0,
            voteCount: 2000,
            releaseDate: "2026-02-01",
            firstAirDate: nil,
            popularity: 200.0,
            originalLanguage: "en",
            originalTitle: "Avengers",
            genreIds: [28],
            mediaType: "movie",
            adult: false,
            video: false
        )
    ]
}

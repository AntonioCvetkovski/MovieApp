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

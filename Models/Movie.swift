//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation

public struct Movie: Identifiable, Codable, Hashable {
    public let id: Int
    public let title: String?
    public let name: String?
    public let overview: String?
    public let posterPath: String?
    public let backdropPath: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let releaseDate: String?
    public let firstAirDate: String?
    public let popularity: Double?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let genreIds: [Int]?
    public let mediaType: String?
    public let adult: Bool?
    public let video: Bool?
    
    public init(
        id: Int,
        title: String?,
        name: String?,
        overview: String?,
        posterPath: String?,
        backdropPath: String?,
        voteAverage: Double?,
        voteCount: Int?,
        releaseDate: String?,
        firstAirDate: String?,
        popularity: Double?,
        originalLanguage: String?,
        originalTitle: String?,
        genreIds: [Int]?,
        mediaType: String?,
        adult: Bool?,
        video: Bool?
    ) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.releaseDate = releaseDate
        self.firstAirDate = firstAirDate
        self.popularity = popularity
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIds = genreIds
        self.mediaType = mediaType
        self.adult = adult
        self.video = video
    }
    
    public var displayTitle: String {
        title ?? name ?? "Unknown"
    }
    
    public var displayDate: String {
        releaseDate ?? firstAirDate ?? "Unknown"
    }
    
    public var posterURL: String? {
        guard let path = posterPath else { return nil }
        return APIConstants.imageBaseURL + APIConstants.ImageSize.medium + path
    }
    
    public var posterLowResURL: String? {
        guard let path = posterPath else { return nil }
        return APIConstants.imageBaseURL + APIConstants.ImageSize.low + path
    }
    
    public var backdropURL: String? {
        guard let path = backdropPath else { return nil }
        return APIConstants.imageBaseURL + APIConstants.ImageSize.high + path
    }
    
    public var formattedRating: String {
        guard let rating = voteAverage else { return "N/A" }
        return String(format: "%.1f", rating)
    }
}

public struct MovieResponse: Decodable {
    public let page: Int
    public let results: [Movie]
    public let totalPages: Int
    public let totalResults: Int
    
    public init(page: Int, results: [Movie], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

extension Movie {
    public static let mockData: [Movie] = [
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

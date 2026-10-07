//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation

public struct MovieDetail: Identifiable, Decodable {
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
    public let runtime: Int?
    public let status: String?
    public let tagline: String?
    public let budget: Int?
    public let revenue: Int?
    public let homepage: String?
    public let genres: [Genre]?
    public let productionCompanies: [ProductionCompany]?
    public let spokenLanguages: [SpokenLanguage]?
    
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
    
    public var backdropURL: String? {
        guard let path = backdropPath else { return nil }
        return APIConstants.imageBaseURL + APIConstants.ImageSize.high + path
    }
    
    public var formattedRating: String {
        guard let rating = voteAverage else { return "N/A" }
        return String(format: "%.1f", rating)
    }
    
    public var formattedRuntime: String {
        guard let runtime = runtime else { return "N/A" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
    public var formattedBudget: String {
        guard let budget = budget, budget > 0 else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: budget)) ?? "N/A"
    }
}

public struct Genre: Identifiable, Decodable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public struct ProductionCompany: Identifiable, Decodable {
    public let id: Int
    public let name: String
    public let logoPath: String?
    public let originCountry: String?
}

public struct SpokenLanguage: Decodable {
    public let englishName: String?
    public let name: String?
}

extension MovieDetail {
    public static let mock = MovieDetail(
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
        runtime: 120,
        status: "Released",
        tagline: "With great power",
        budget: 200000000,
        revenue: 500000000,
        homepage: nil,
        genres: [Genre(id: 28, name: "Action")],
        productionCompanies: nil,
        spokenLanguages: nil
    )
}

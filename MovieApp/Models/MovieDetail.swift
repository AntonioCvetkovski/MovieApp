//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation

struct MovieDetail: Identifiable, Decodable {
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
    let runtime: Int?
    let status: String?
    let tagline: String?
    let budget: Int?
    let revenue: Int?
    let homepage: String?
    let genres: [Genre]?
    let productionCompanies: [ProductionCompany]?
    let spokenLanguages: [SpokenLanguage]?
    
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
    
    var backdropURL: String? {
        guard let path = backdropPath else { return nil }
        return APIConstants.imageBaseURL + APIConstants.ImageSize.high + path
    }
    
    var formattedRating: String {
        guard let rating = voteAverage else { return "N/A" }
        return String(format: "%.1f", rating)
    }
    
    var formattedRuntime: String {
        guard let runtime = runtime else { return "N/A" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
    var formattedBudget: String {
        guard let budget = budget, budget > 0 else { return "N/A" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: budget)) ?? "N/A"
    }
}

// MARK: - Supporting Models
struct Genre: Identifiable, Decodable {
    let id: Int
    let name: String
}

struct ProductionCompany: Identifiable, Decodable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: String?
}

struct SpokenLanguage: Decodable {
    let englishName: String?
    let name: String?
}

extension MovieDetail {
    static let mock = MovieDetail(
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

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

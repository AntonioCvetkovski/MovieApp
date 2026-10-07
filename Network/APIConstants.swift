//
//  APIConstants.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation

public enum APIConstants {
    
    static let apiKey = "011204a18e2cd5e9be28eb2526672e32"
    static let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMTEyMDRhMThlMmNkNWU5YmUyOGViMjUyNjY3MmUzMiIsIm5iZiI6MTY0NTI5ODU1MS43NzIsInN1YiI6IjYyMTE0Mzc3ZTcyZmU4MDA0M2I1OTNmOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.buTnpTC6ihVYqnbbNsvVDGZb-pxkfkrEMVYrxKEkNVc"
    static let baseURL = "https://api.themoviedb.org/3"
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/"
    
    public enum ImageSize {
        static let low = "w200"
        static let medium = "w500"
        static let high = "original"
    }
    
    public enum Endpoints {
        static let trendingMovies = "/trending/movie/week"
        static let movieDetails = "/movie"
        static let search = "/search/multi"
        static let searchMovies = "/search/movie"
        static let searchTV = "/search/tv"
    }
}

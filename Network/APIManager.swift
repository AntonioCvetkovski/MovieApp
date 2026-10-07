//
//  APIManagerProtocol.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import Foundation

public protocol APIManagerProtocol {
    func request<T: Decodable>(_ endpoint: String, queryItems: [URLQueryItem]?) async throws -> T
}

public class APIManager: APIManagerProtocol {
    
    static let shared = APIManager()
    public init() {}
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    public func request<T: Decodable>(_ endpoint: String, queryItems: [URLQueryItem]? = nil) async throws -> T {
        
        // ✅ Build URL
        guard var components = URLComponents(string: APIConstants.baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        // ✅ Query items
        var items = [URLQueryItem(name: "api_key", value: APIConstants.apiKey)]
        if let queryItems = queryItems {
            items.append(contentsOf: queryItems)
        }
        components.queryItems = items
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        // ✅ Request со Bearer Token
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(APIConstants.bearerToken)", forHTTPHeaderField: "Authorization")
        
        // ✅ Execute
        let (data, response) = try await session.data(for: request)
        
        // ✅ Validate response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }
        
        // ✅ Decode
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

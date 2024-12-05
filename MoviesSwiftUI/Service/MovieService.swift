//
//  MovieService.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import Foundation

enum MovieError: Error {
    case path
    case url
    case server
    
    var errorDescription: String {
        switch self {
        case .path:
            "Error: path is invalid."
        case .url:
            "Error: URL is invalid."
        case .server:
            "Error: Server is invalid."
        }
    }
}

struct MovieService {
    private static let apiKey = "b34e9579"
    private var path: String { "http://www.omdbapi.com/" }
    
    func buildUrl(searchQuery: String) throws -> URL {
        guard var components = URLComponents(string: path)
        else { throw MovieError.path }
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: MovieService.apiKey),
            URLQueryItem(name: "t", value: searchQuery)
        ]
        guard let url = components.url
        else { throw MovieError.url }
        return url
    }
}

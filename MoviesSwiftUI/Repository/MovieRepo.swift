//
//  MovieRepo.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import Foundation

protocol Repository { }

protocol MovieRepository: Repository {
    func fetchMovies(searchText: String) async throws -> [Movie]
}

enum MovieViewModelState {
    case idle
    case loading
    case loaded
    case error(Error)
}

struct MovieRepo: MovieRepository {
    let service: MovieService
    
    init(service: MovieService) {
        self.service = service
    }
    
    func fetchMovies(searchText: String) async throws -> [Movie] {
        var url: URL?
        do {
            url = try? service.buildUrl(searchQuery: searchText)
        }
        
        guard let url else {
            throw MovieError.url
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
            print("error")
            throw MovieError.server
        }
        print("data is: \(data)")
        let movie = try JSONDecoder().decode(Movie.self, from: data)
        return [movie]
    }
}

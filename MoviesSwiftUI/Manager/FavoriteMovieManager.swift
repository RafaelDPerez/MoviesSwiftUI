//
//  FavoriteMovieManager.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import SwiftUI

@Observable
class FavoriteMovieManager {
    private var movies: Set<Movie>
    private let key = "Favorites"
    private let defaults = UserDefaults.standard

    init() {
        if let moviesData = defaults.data(forKey: key), let moviesArray = try? JSONDecoder().decode([Movie].self, from: moviesData) {
            movies = Set(moviesArray)
        } else {
            movies = []
        }
    }

    func contains(_ movie: Movie) -> Bool {
        if let moviesData = defaults.data(forKey: key), let moviesArray = try? JSONDecoder().decode([Movie].self, from: moviesData) {
            return moviesArray.contains(where: { $0.title == movie.title })
        } else {
            return false
        }
    }

    func add(_ movie: Movie) {
        movies.insert(movie)
        save()
    }
    
    func remove(_ movie: Movie) {
        movies.remove(movie)
        save()
    }

    func save() {
        let data = try? JSONEncoder().encode(Array(movies))
        defaults.set(data, forKey: key)
    }
}

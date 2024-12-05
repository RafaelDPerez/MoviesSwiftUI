//
//  MovieViewModel.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import Foundation

class MovieViewModel: ObservableObject {
    private var favoritesManager = FavoriteMovieManager()
    @Published var isFavorite: Bool = false
    
    var title: String {
        movie.title
    }
    
    var poster: URL {
        return URL(string: movie.poster) ?? URL(fileURLWithPath: "")
    }
    
    var year: String {
        movie.year
    }
    
    var plot: String {
        movie.plot
    }
    
    var rating: String {
        movie.imdbRating
    }
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = favoritesManager.contains(movie)
    }
    
    func addToFavorites() {
        favoritesManager.add(movie)
        isFavorite = true
    }
    
    func removeFromFavorites() {
        favoritesManager.remove(movie)
        isFavorite = false
    }
}

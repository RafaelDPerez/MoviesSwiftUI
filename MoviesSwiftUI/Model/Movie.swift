//
//  Movie.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable, Equatable {
    var id = UUID()
    var plot: String
    var year: String
    var poster: String
    var title: String
    var imdbRating: String
    
    enum CodingKeys: String, CodingKey {
        case imdbRating
        case plot = "Plot"
        case title = "Title"
        case year = "Year"
        case poster = "Poster"
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title && lhs.year == rhs.year
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

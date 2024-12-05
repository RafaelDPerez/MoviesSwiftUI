//
//  MovieDetailView.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                GeometryReader { proxy in
                    VStack(alignment: .leading, spacing: 10) {
                        CachedAsyncImage(url: viewModel.poster) { image in
                            image
                                .resizable()
                                .frame(width: proxy.size.width,
                                       height: 500)
                                .scaledToFill()
                                
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(viewModel.title)
                            .font(.title)
                            .bold()
                            .foregroundStyle(.black)
                        
                        Text("IMdB Rating: \(viewModel.rating)")
                            .font(.title2)
                            .foregroundStyle(.black)
                        
                        Text(viewModel.plot)
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.black)
                        
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .toolbar {
            Button {
                if viewModel.isFavorite {
                    viewModel.removeFromFavorites()
                } else {
                    viewModel.addToFavorites()
                }
            } label: {
                if viewModel.isFavorite {
                    Image(systemName: "star.fill")
                } else {
                    Image(systemName: "star")
                }
            }
        }
    }
}

#Preview {
    let viewModel = MovieViewModel(movie: Movie(plot: "Hitman Steven Matrix is shot, experiences afterlife, gets second chance by helping others. Wakes up, meets guides assigning cases where he aids people using unorthodox methods from past profession.", year: "2024", poster: "https://m.media-amazon.com/images/M/MV5BM2JiZjU1NmQtNjg1Ni00NjA3LTk2MjMtNjYxMTgxODY0NjRhXkEyXkFqcGc@._V1_SX300.jpg", title: "The Batman", imdbRating: "10.0"))
        
    MovieDetailView(viewModel: viewModel)
}

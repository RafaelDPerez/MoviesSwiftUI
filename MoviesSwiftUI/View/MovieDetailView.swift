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
                    ScrollView {
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

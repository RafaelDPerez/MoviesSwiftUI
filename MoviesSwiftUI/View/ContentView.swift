//
//  ContentView.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import Combine
import SwiftUI

enum SearchScope: String, CaseIterable {
    case inbox, favorites
}

struct ContentView: View {
    @StateObject var viewModel: MovieListViewModel
    @State private var searchScope = SearchScope.inbox
    
    private let columns = [
            GridItem(.adaptive(minimum: 150, maximum: 200))
        ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    switch viewModel.state {
                    case .idle:
                        Text("No results available")
                    case .loading:
                        VStack(alignment: .center) {
                            ProgressView()
                                .frame(width: 150, height: 150)
                        }
                        
                    case .loaded:
                        ForEach(viewModel.movies, id: \.title) { movie in
                            NavigationLink(destination: MovieDetailView(viewModel: movie)) {
                                VStack(alignment: .leading) {
                                    CachedAsyncImage(url: movie.poster) { image in
                                        image
                                            .resizable()
                                            .frame(maxWidth: 200,
                                                   maxHeight: 300)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text(movie.title)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundStyle(.black)
                                    Text(movie.year)
                                        .font(.caption2)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                    case .error(_):
                        if viewModel.searchText.isEmpty {
                            Text("No results available")
                        }
                    }
                })
            }
            .searchable(text: $viewModel.searchText, placement: .toolbar, prompt: "Search movie")
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView(viewModel: MovieListViewModel())
}

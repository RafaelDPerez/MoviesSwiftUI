//
//  MovieListViewModel.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import Combine
import Foundation
import UIKit

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [MovieViewModel] = []
    @Published var searchText: String = ""
    @Published var state: MovieViewModelState = .idle
    private var cancellables: Set<AnyCancellable> = []
    
    deinit {
        cancellables.forEach {
            $0.cancel()
        }
    }
    
    private let repo: MovieRepo
    
    init(repository: MovieRepo = MovieRepo(service: MovieService())) {
        self.repo = repository
        setupBindings()
    }
    
    private func setupBindings() {
        $searchText
            .dropFirst()
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                Task {
                    do {
                        self.state = .loading
                        try await self.getMovies(text: text)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func getMovies(text: String) async throws {
        do {
            let movieObjects = try await repo.fetchMovies(searchText: text)
            movies = movieObjects.map { movie in
                MovieViewModel(movie: movie)
            }
            self.state = .loaded
        } catch {
            movies = []
            self.state = .error(error)
            throw error
        }
    }
}

//
//  MoviesSwiftUIApp.swift
//  MoviesSwiftUI
//
//  Created by Rafael Perez on 5/12/24.
//

import SwiftUI

@main
struct MoviesSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MovieListViewModel())
        }
    }
}

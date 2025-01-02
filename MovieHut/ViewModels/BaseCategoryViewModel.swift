//
//  BaseCategoryViewModel.swift
//  MovieHut
//
//  Created by Optimus Prime on 15/11/24.
//

import Foundation
import SwiftUI
import Combine

class BaseCategoryViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var isLoading = false

    var currentPage = 1
    var canLoadMore = true
    
    func fetchMovies() async {
        fatalError("This method should be overridden by subclasses")
    }
    
    func fetchMovieWithContinuation(for endPoint : MovieListEndPoint) async {
        return await withCheckedContinuation { continuation in
            let store = MovieStore.shared
            store.fetchMovies(endPoint: endPoint) { [weak self] result in
                guard let self else { return }
                if case .success(let movie) = result {
                    self.movies = movie.results
                }
                if case .failure(let failure) = result {
                    print(failure)
                }
                continuation.resume()
            }
        }
    }
    
}

class PopularCategoryViewModel: BaseCategoryViewModel {
    
    override func fetchMovies() async {
        await fetchMovieWithContinuation(for: .popular)
    }
}

class UpcomingCategoryViewModel: BaseCategoryViewModel {
    
    override func fetchMovies() async {
        await fetchMovieWithContinuation(for: .upcoming)
    }
}

class TopRatedCategoryViewModel: BaseCategoryViewModel {
    
    override func fetchMovies() async {
        await fetchMovieWithContinuation(for: .topRated)
    }
}

class NowPlayingCategoryViewModel: BaseCategoryViewModel {
    
    override func fetchMovies() async {
        await fetchMovieWithContinuation(for: .nowPlaying)
    }
}

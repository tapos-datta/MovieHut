//
//  MovieDetailsState.swift
//  MovieHut
//
//  Created by Optimus Prime on 11/12/24.
//
import SwiftUI

class MovieDetailsState: ObservableObject {
    private let movieService: MovieService
    @Published var movie: Movie?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func fetchMovieDetails(id: Int) async {
        self.movie = nil
        self.isLoading = true
        return await withCheckedContinuation { continuation in
            self.movieService.fetchMovie(id: id) { [weak self] (result) in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let movie):
                    self.movie = movie
                case .failure(let error):
                    self.error = error as NSError
                }
            }
        }
    }
    
    
}

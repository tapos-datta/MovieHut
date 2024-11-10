//
//  MovieService.swift
//  MovieHut
//
//  Created by Optimus Prime on 8/11/24.
//

import Foundation

protocol MovieService {
    func fetchMovies(endPoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieServiceError>) -> Void)
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieServiceError>) -> Void)
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieServiceError>) -> Void)
}


enum MovieListEndPoint: String, CaseIterable {
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case upcoming
    case popular
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now Playing"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        case .popular: return "Popular"
        }
    }
}

enum MovieServiceError: Error {
    case invalideEndPoint
    case invalidResponse
    case noData
    case serializationError
    case apiError
    
    var localizedDescription: String {
        switch self {
        case .invalideEndPoint: return "Invalid End Point"
        case .invalidResponse: return "Invalid Response"
        case .noData: return "No Data Exists"
        case .serializationError: return "Serialization Error"
        case .apiError: return "Failed to fetch data from API"
        }
    }
    
    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}




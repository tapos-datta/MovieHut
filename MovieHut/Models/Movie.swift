//
//  Movie.swift
//  MovieHut
//
//  Created by Optimus Prime on 8/11/24.
//
import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let backdropPath: String?
    let runtime: Int?
    let popularity: Double
    let adult: Bool
    let originalLanguage: String
    let title: String
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case runtime
        case popularity
        case adult
        case originalLanguage = "original_language"
        case title
        case video
    }
}

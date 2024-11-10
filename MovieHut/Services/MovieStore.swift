//
//  MovieStore.swift
//  MovieHut
//
//  Created by Optimus Prime on 9/11/24.
//

import Foundation

class MovieStore : MovieService {
    
    static let shared = MovieStore()
    
    private init() {}
    private let urlSession: URLSession = .shared
    private let jsonDecoder = Utils.jsonDecoder
    
    func fetchMovies(endPoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieServiceError>) -> Void) {
        let endpointPath = "movie/\(endPoint.rawValue)"
        self.loadURLAndDecode(for: endpointPath, with: [:], completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieServiceError>) -> Void) {
        let endpointPath = "movie/\(id)"
        self.loadURLAndDecode(for: endpointPath, with: [
            "append_to_response" : "videos,credits"
        ], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieServiceError>) -> Void) {
        let endpointPath = "search/movie"
        self.loadURLAndDecode(for: endpointPath, with: [
            "language" : "en-US",
            "include_adult": "false",
            "query" : query,
            "region" : "US"
        ], completion: completion)
    }
    
    private func loadURLAndDecode<T: Decodable>(for endpoint : String, with params: [String: String]?, completion: @escaping (Result<T, MovieServiceError>) -> Void) {
        
        guard let finalURL = NetworkConfiguration.buildURL(for: endpoint, with: params) else {
            completion(.failure(.invalideEndPoint))
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(NetworkConfiguration.accessKey)", forHTTPHeaderField: "Authorization")
        
        urlSession.dataTask(with: request) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch  {
                print(error.localizedDescription)
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
            
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<T: Decodable>(with result: Result<T, MovieServiceError>, completion: @escaping (Result<T, MovieServiceError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

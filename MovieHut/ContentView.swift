//
//  ContentView.swift
//  MovieHut
//
//  Created by Optimus Prime on 8/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .onAppear {
                    let store = MovieStore.shared
                    store.fetchMovies(endPoint: .popular) { result in
                        if case .success(let movies) = result {
                            let _id = movies.results.first?.id ?? 0
                            store.fetchMovie(id: _id ) { resultMovie in
                                if case .success(let movie) = resultMovie {
                                    print(movie)
                                }
                                if case .failure(let failure) = resultMovie {
                                    print(failure)
                                }
                                
                            }
                        }
                        if case .failure(let failure) = result {
                            print(failure)
                        }
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  MoviePosterCard.swift
//  MovieHut
//
//  Created by Optimus Prime on 11/11/24.
//

import SwiftUI

struct MoviePosterCard: View {
    
    let movie: Movie
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.blue.opacity(0.35))
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            .aspectRatio(CGSize(width: ScreenUtils.responsiveWidth(100), height: ScreenUtils.responsiveHeight(145.92)), contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: ScreenUtils.responsiveWidth(8)))
            .shadow(radius: 8)
            
        }
        .task {
            guard let posterPath = movie.posterPath else { return }
            let url = ImageUrlBuilder.getImageUrl(for: posterPath)
            self.imageLoader.loadImage(from: url)
        }
    }
}

#Preview {
    //    MoviePosterCard(movie: Movie(from: .mock))
}

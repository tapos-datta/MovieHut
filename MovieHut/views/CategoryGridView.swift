//
//  CategoryView.swift
//  MovieHut
//
//  Created by Optimus Prime on 15/11/24.
//

import SwiftUI
import Foundation

struct CategoryGridView: View {
        
    @State var isLoading: Bool = false
    @State private var selectedIndex: Int = 0
    private let categories = MovieListEndPoint.allCases.map(\.description)
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    ForEach(0..<categories.count, id: \.self) { index in
                        Text(categories[index])
                            .foregroundColor(selectedIndex == index ? .white : .gray)
                            .padding(.vertical, 0)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    selectedIndex = index
                                }
                            }
                    }
                }
                
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: geometry.size.width / CGFloat(categories.count), height: ScreenUtils.responsiveHeight(4))
                        .offset(x: CGFloat(selectedIndex) * geometry.size.width / CGFloat(categories.count))
                        .animation(.easeInOut, value: selectedIndex)
                }
                .frame(height: ScreenUtils.responsiveHeight(4))
            }
            .frame(height: ScreenUtils.responsiveHeight(41))
            .background(Color.yellow)
         
            switch selectedIndex {
            case 0:  CategoryToggleView(viewModel: PopularCategoryViewModel())
            case 1:  CategoryToggleView(viewModel: UpcomingCategoryViewModel())
            case 2:  CategoryToggleView(viewModel: NowPlayingCategoryViewModel())
            case 3:  CategoryToggleView(viewModel: TopRatedCategoryViewModel())
            default:
                EmptyView()
            }
        }
    }
}

struct CategoryToggleView : View {
    
    @StateObject private var categoryViewModel: BaseCategoryViewModel
    
    init(viewModel: @autoclosure @escaping () -> BaseCategoryViewModel) {
        _categoryViewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: ScreenUtils.responsiveWidth(114)))], spacing: ScreenUtils.responsiveHeight(15)) {
                ForEach(0..<categoryViewModel.movies.count, id: \.self) { index in
                    MoviePosterCard(movie: categoryViewModel.movies[index])
                }
            }
        }
        .task {
            await categoryViewModel.fetchMovies()
        }
    }
}

#Preview {
    CategoryGridView()
}


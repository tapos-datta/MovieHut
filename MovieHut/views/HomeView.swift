//
//  ContentView.swift
//  MovieHut
//
//  Created by Optimus Prime on 8/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ZStack {
            //background
            Color.green.edgesIgnoringSafeArea(.all)
            
            //foreground
            VStack() {
                VStack{
                    Color.black
                }
                .frame(height: ScreenUtils.responsiveHeight(430))
                
                Spacer(minLength: 0)
                
                CategoryGridView()
                    .frame(minHeight: ScreenUtils.responsiveHeight(382))
            }
        }
    }
}

#Preview {
    HomeView()
}

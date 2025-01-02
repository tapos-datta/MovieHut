//
//  ActivityIndicatorView.swift
//  MovieHut
//
//  Created by Optimus Prime on 11/12/24.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    
}

//
//  LoadingView.swift
//  MovieHut
//
//  Created by Optimus Prime on 11/12/24.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool
    @Binding var error: NSError?
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: ScreenUtils.responsiveHeight(16)) {
            if isLoading {
                HStack {
                    Spacer()
                    ActivityIndicatorView()
                    Spacer()
                }
            } else if error != nil {
                VStack(spacing: 4) {
                    Text(error!.localizedDescription)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, ScreenUtils.responsiveWidth(24))
                    
                    if let retryAction = self.retryAction {
                        Button(action: retryAction) {
                            Text("Retry")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Center the content
    }
}

#Preview("Loading State") {
    // Loading State Preview
    LoadingView(
        isLoading: .constant(true), error: .constant(nil),
        retryAction: {
            print("Retry Action Triggered")
        })
}

#Preview("Error State") {
    // Error State Preview
    LoadingView(
        isLoading: .constant(false),
        error: .constant(
            NSError(
                domain: "Preview Error", code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Something went wrong."])),
        retryAction: {
            print("Retry Action Triggered")
        })
}

#Preview(
    "Success State",
    body: {
        // Completed State Preview
        LoadingView(
            isLoading: .constant(false), error: .constant(nil), retryAction: nil
        )
    })

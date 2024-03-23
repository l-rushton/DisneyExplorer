//
//  CharacterImage.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI

@ViewBuilder
func characterImage(url: String, size: CGFloat = 100) -> some View {
    ZStack {
        Rectangle()
            .foregroundColor(.clear)
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .cornerRadius(10)
                    .clipped()
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
            @unknown default:
                EmptyView()
            }
        }
    }
    .frame(width: size, height: size)
}

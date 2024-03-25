//
//  CharacterImage.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI

struct CharacterImage: View {
    let url: String
    let size: CGFloat
    
    init(url: String, size: CGFloat = 100) {
        self.url = url
        self.size = size
    }
    
    var body: some View {
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
}

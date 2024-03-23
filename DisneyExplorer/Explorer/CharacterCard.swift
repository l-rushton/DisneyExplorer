//
//  CharacterCard.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI

struct CharacterCard: View {
    let character: Character
    
    
    var body: some View {
//        Button {
//            onTap()
//        } label : {
            HStack {
                characterImage(url: character.imageUrl)
                Text(character.name)
                    .bold()
                    .padding()
                Spacer()
                Image(systemName: "chevron.right")
                    .padding()
            }
            .foregroundStyle(.black)
            .padding(5)
//        }
    }
}

@ViewBuilder
func characterImage(url: String) -> some View {
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
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .clipped()
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
            @unknown default:
                EmptyView()
            }
        }
    }
    
    .frame(width: 100, height: 100)
}

#Preview {
    CharacterCard(
        character: Character(
            name: "Queen Arianna",
            id: 0,
            films: ["Tangled"],
            shortFilms: ["Short Tangled"],
            url: "",
            imageUrl: "https://static.wikia.nocookie.net/disney/images/1/15/Arianna_Tangled.jpg/revision/latest?cb=20160715191802"
        )
    )
    .padding()
}

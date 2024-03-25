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
        HStack {
            CharacterImage(url: character.imageUrl)
            Text(character.name)
                .bold()
                .padding()
            Spacer()
            Image(systemName: "chevron.right")
                .padding()
        }
        .foregroundStyle(.black)
        .padding(5)
    }
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

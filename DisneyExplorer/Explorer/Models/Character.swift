//
//  Character.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

struct Character: Equatable {
    let name: String
    let id: Int
    let films: [String]
    let shortFilms: [String]
    let url: String
    let imageUrl: String
    
    init(dto: CharacterDTO) {
        self.name = dto.name
        self.id = dto.id
        self.films = dto.films
        self.shortFilms = dto.films
        self.url = dto.url
        self.imageUrl = dto.imageUrl
    }
}

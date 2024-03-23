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
    
    init(
        name: String,
        id: Int,
        films: [String],
        shortFilms: [String],
        url: String,
        imageUrl: String
    ) {
        self.name = name
        self.id = id
        self.films = films
        self.shortFilms = shortFilms
        self.url = url
        self.imageUrl = imageUrl
    }
    
    init(dto: CharacterDTO) {
        self.name = dto.name
        self.id = dto.id
        self.films = dto.films
        self.shortFilms = dto.films
        self.url = dto.url
        self.imageUrl = dto.imageUrl
    }
}

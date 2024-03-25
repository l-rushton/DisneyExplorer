//
//  Character.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftData

@Model
class Character: Equatable, Identifiable {
    let name: String
    let id: Int
    let films: [String]
    let shortFilms: [String]
    let tvShows: [String]?
    let videoGames: [String]?
    let parkAttractions: [String]?
    let allies: [String]?
    let enemies: [String]?
    let url: String?
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
    
    init?(dto: CharacterDTO) {
        guard let id = dto.id else {
            return nil
        }
        
        self.name = dto.name ?? ""
        self.id = id
        self.films = dto.films ?? []
        self.shortFilms = dto.films ?? []
        self.tvShows = dto.tvShows
        self.videoGames = dto.videoGames
        self.parkAttractions = dto.parkAttractions
        self.allies = dto.allies
        self.enemies = dto.enemies
        self.url = dto.url ?? ""
        self.imageUrl = dto.imageUrl ?? ""
    }
}

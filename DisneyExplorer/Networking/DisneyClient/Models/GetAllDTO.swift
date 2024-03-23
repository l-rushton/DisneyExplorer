//
//  GetAllDTO.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation

struct GetAllDTO: Decodable, Equatable {
    let info: InfoDTO
    let data: [CharacterDTO]
}

struct InfoDTO: Decodable, Equatable {
    let totalPages: Int?
    let count: Int?
    let previousPage: String?
    let nextPage: String?
}

struct CharacterDTO: Decodable, Equatable {
    let id: Int?
    let films: [String]?
    let shortFilms: [String]?
    let tvShows: [String]?
    let videoGames: [String]?
    let parkAttractions: [String]?
    let allies: [String]?
    let enemies: [String]?
    let sourceUrl: String?
    let name: String?
    let imageUrl: String?
    let createdAt: String?
    let updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case films, shortFilms, tvShows, videoGames, parkAttractions, allies, enemies, sourceUrl, name, imageUrl, createdAt, updatedAt, url
    }
}

//
//  StubData.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation
@testable import DisneyExplorer

struct StubData {
    static func read(file: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {
            throw StubDataError.noFileDetected
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            throw StubDataError.decodingError
        }
    }
}

struct MockResponse {
    static let info = InfoDTO(
        totalPages: 149,
        count: 50,
        previousPage: "https://api.disneyapi.dev/character?page=3",
        nextPage: "https://api.disneyapi.dev/character?page=5"
    )
    
    static let queenArianna = CharacterDTO(
        id: 308,
        films: ["Tangled","Tangled: Before Ever After"],
        shortFilms: ["Tangled Ever After","Hare Peace"],
        tvShows: ["Once Upon a Time","Tangled: The Series"],
        videoGames: ["Disney Princess Enchanting Storybooks","Hidden Worlds","Disney Crossy Road","Kingdom Hearts III"],
        parkAttractions: ["Celebrate the Magic","Jingle Bell, Jingle BAM!"],
        allies: [],
        enemies: [],
        sourceUrl: "https://disney.fandom.com/wiki/Queen_Arianna",
        name: "Queen Arianna",
        imageUrl: "https://static.wikia.nocookie.net/disney/images/1/15/Arianna_Tangled.jpg/revision/latest?cb=20160715191802",
        createdAt: "2021-04-12T01:33:34.458Z",
        updatedAt: "2021-04-12T01:33:34.458Z",
        url: "https://api.disneyapi.dev/characters/308"
    )
    
    static let elsa = CharacterDTO(
        id: 309,
        films: ["Frozen","Frozen II"],
        shortFilms: [],
        tvShows: ["Frozen: The Series"],
        videoGames: ["Disney Princess Enchanting Storybooks","Hidden Worlds","Disney Crossy Road","Kingdom Hearts III"],
        parkAttractions: ["Frozen: The Experience","Jingle Bell, Jingle BAM!"],
        allies: [],
        enemies: [],
        sourceUrl: "https://disney.fandom.com/wiki/Elsa",
        name: "Elsa",
        imageUrl: "",
        createdAt: "2021-04-12T01:33:34.458Z",
        updatedAt: "2021-04-12T01:33:34.458Z",
        url: "https://api.disneyapi.dev/characters/309"
    )
}

enum StubDataError: Error {
    case decodingError
    case noFileDetected
}

//
//  DisneyClientTests.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

import XCTest
@testable import DisneyExplorer

final class DisneyClientTests: XCTestCase {
    
    var info: InfoDTO!
    var queenArianna: CharacterDTO!
    var elsa: CharacterDTO!
    
    override func setUp() async throws {
        info = InfoDTO(
            totalPages: 149,
            count: 50,
            previousPage: "https://api.disneyapi.dev/character?page=3",
            nextPage: "https://api.disneyapi.dev/character?page=5"
        )
        
        queenArianna = CharacterDTO(
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
        
        elsa = CharacterDTO(
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
    
    override func tearDown() {
        info = nil
        queenArianna = nil
        elsa = nil
    }
    
    func test_getAllCharacters_success() async throws {
        let data = try StubData.read(file: "GetAllSuccess")
        let httpSuccess = URLResponse()
        let successUrlSession = MockURLSession(data: data, urlResponse: httpSuccess)
        let sut = DisneyClient(urlSession: successUrlSession)
        
        let response = await sut.getAllCharacters()
        
        let expectedResponse = GetAllDTO(info: info, data: [queenArianna, elsa])
       
        XCTAssertEqual(response, .success(expectedResponse))
    }
    
    func test_getAllCharacters_failure() async {
        let failingUrlSession = MockURLSession()
        let sut = DisneyClient(urlSession: failingUrlSession)
        
        let response = await sut.getAllCharacters()
        
        let error = ClientError.networkError
        
        XCTAssertEqual(response, .failure(error))
    }
    
    func test_getAllCharacters_decodingFailure() async throws {
        let data = try StubData.read(file: "InvalidResponse")
        let httpSuccess = URLResponse()
        let successUrlSession = MockURLSession(data: data, urlResponse: httpSuccess)
        let sut = DisneyClient(urlSession: successUrlSession)
        
        let response = await sut.getAllCharacters()
        
        let error = ClientError.decodingError
        
        XCTAssertEqual(response, .failure(error))
    }
    
    func test_getAllCharacters_invalidUrl() async throws {
        let invalidUrl = ""
        let successUrlSession = MockURLSession()
        let sut = DisneyClient(urlSession: successUrlSession)
        
        let response = await sut.getAllCharacters(url: invalidUrl)
        
        let error = ClientError.invalidUrl
        
        XCTAssertEqual(response, .failure(error))
    }
}

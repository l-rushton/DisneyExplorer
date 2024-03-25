//
//  ExplorerViewModelTests.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

import XCTest
import SwiftData
@testable import DisneyExplorer

final class ExplorerViewModelTests: XCTestCase {
    var storageManager: StorageManager!
    var elsa: Character!
    var queenArianna: Character!
    
    override func setUp() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Character.self, configurations: config)
        storageManager = StorageManager.init(modelContainer: container)
        
        elsa = Character(dto: MockResponse.elsa)
        queenArianna = Character(dto: MockResponse.queenArianna)
        
        guard elsa != nil, queenArianna != nil else {
            XCTFail()
            return
        }
    }
    
    override func tearDown() {
        storageManager = nil
        elsa = nil
        queenArianna = nil
    }
    
    func test_getCharacters_success() async throws {
        let data = try StubData.read(file: "GetAllSuccess")
        let httpResponse = URLResponse()
        let successUrlSession = MockURLSession(data: data, urlResponse: httpResponse)
        let client = DisneyClient(urlSession: successUrlSession)
        
        let sut = ExplorerViewModel(client: client, storageManager: self.storageManager)
        
        XCTAssertEqual(sut.viewState, .notLoaded)
        
        await sut.getCharacters()

        // The @Model macro seems to be giving difference instances of the same Character a
        // different hidden "persistentBackingData" value which breaks the expected equality.
        // Resorting to comparing all expected values indiviudally
        XCTAssertEqual(sut.characters[0].name, queenArianna.name)
        XCTAssertEqual(sut.characters[0].id, queenArianna.id)
        XCTAssertEqual(sut.characters[0].films, queenArianna.films)
        XCTAssertEqual(sut.characters[0].shortFilms, queenArianna.shortFilms)
        XCTAssertEqual(sut.characters[0].tvShows, queenArianna.tvShows)
        XCTAssertEqual(sut.characters[0].videoGames, queenArianna.videoGames)
        XCTAssertEqual(sut.characters[0].parkAttractions, queenArianna.parkAttractions)
        XCTAssertEqual(sut.characters[0].allies, queenArianna.allies)
        XCTAssertEqual(sut.characters[0].enemies, queenArianna.enemies)
        XCTAssertEqual(sut.characters[0].url, queenArianna.url)
        XCTAssertEqual(sut.characters[0].imageUrl, queenArianna.imageUrl)
        
        XCTAssertEqual(sut.characters[1].name, elsa.name)
        XCTAssertEqual(sut.characters[1].id, elsa.id)
        XCTAssertEqual(sut.characters[1].films, elsa.films)
        XCTAssertEqual(sut.characters[1].shortFilms, elsa.shortFilms)
        XCTAssertEqual(sut.characters[1].tvShows, elsa.tvShows)
        XCTAssertEqual(sut.characters[1].videoGames, elsa.videoGames)
        XCTAssertEqual(sut.characters[1].parkAttractions, elsa.parkAttractions)
        XCTAssertEqual(sut.characters[1].allies, elsa.allies)
        XCTAssertEqual(sut.characters[1].enemies, elsa.enemies)
        XCTAssertEqual(sut.characters[1].url, elsa.url)
        XCTAssertEqual(sut.characters[1].imageUrl, elsa.imageUrl)

        XCTAssertEqual(sut.viewState, .loaded)
    }
    
    func test_getCharacters_failure() async throws {
        let failingUrlSession = MockURLSession()
        let client = DisneyClient(urlSession: failingUrlSession)
        
        let sut = ExplorerViewModel(client: client, storageManager: self.storageManager)
        
        XCTAssertEqual(sut.viewState, .notLoaded)
        
        await sut.getCharacters()

        XCTAssertEqual(sut.viewState, .error("Network error, please try again"))
    }
    
    func test_getNextPage_success() async throws {
        let data = try StubData.read(file: "NextPageSuccess")
        let httpResponse = URLResponse()
        let successUrlSession = MockURLSession(data: data, urlResponse: httpResponse)
        let client = DisneyClient(urlSession: successUrlSession)
    
        let characters = [
            Character(
                name: "test",
                id: 1,
                films: [],
                shortFilms: [],
                url: "", 
                imageUrl: ""
            )
        ]
        
        let nextPageUrl = "url"
        let expectedNextPageUrl = "https://api.disneyapi.dev/character?page=6"
        
        let sut = ExplorerViewModel(
            client: client,
            characters: characters,
            nextPageUrl: nextPageUrl,
            storageManager: self.storageManager
        )
        
        XCTAssertEqual(sut.characters.count, 1)
        XCTAssertEqual(sut.nextPageUrl, nextPageUrl)
        
        await sut.getCharacters(nextPage: true)
        
        XCTAssertEqual(sut.characters.count, 3)
        XCTAssertEqual(sut.viewState, .loaded)
        XCTAssertEqual(sut.nextPageUrl, expectedNextPageUrl)
        XCTAssertEqual(sut.favourites.count, 0)
    }
    
    func test_fetchFavourites_success() async throws {
        let sut = ExplorerViewModel(storageManager: self.storageManager)
        
        XCTAssertEqual(sut.favourites.count, 0)
        
        try await self.storageManager.store(elsa)
        
        await sut.fetchFavourites()
        
        XCTAssertEqual(sut.favourites.count, 1)
    }
}

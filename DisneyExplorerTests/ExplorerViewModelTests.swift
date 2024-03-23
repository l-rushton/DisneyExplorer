//
//  ExplorerViewModelTests.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

import XCTest
@testable import DisneyExplorer

final class ExplorerViewModelTests: XCTestCase {
    func test_getAllCharacters_success() async throws {
        let data = try StubData.read(file: "GetAllSuccess")
        let httpResponse = URLResponse()
        let successUrlSession = MockURLSession(data: data, urlResponse: httpResponse)
        let client = DisneyClient(urlSession: successUrlSession)
        
        let sut = ExplorerViewModel(client: client)
        
        XCTAssertEqual(sut.viewState, .notLoaded)
        
        await sut.getAllCharacters()
        
        let elsa = Character(dto: MockResponse.elsa)
        let queenArianna = Character(dto: MockResponse.queenArianna)
        
        let characters: [Character] = [queenArianna!, elsa!]
        
        XCTAssertEqual(sut.characters, characters)
        XCTAssertEqual(sut.viewState, .loaded)
    }
    
    func test_getAllCharacters_failure() async throws {
        let data = try StubData.read(file: "GetAllSuccess")
        let httpResponse = URLResponse()
        let failingUrlSession = MockURLSession()
        let client = DisneyClient(urlSession: failingUrlSession)
        
        let sut = ExplorerViewModel(client: client)
        
        XCTAssertEqual(sut.viewState, .notLoaded)
        
        await sut.getAllCharacters()

        XCTAssertEqual(sut.viewState, .error)
    }
}

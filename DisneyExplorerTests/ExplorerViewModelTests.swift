//
//  ExplorerViewModelTests.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

import XCTest
@testable import DisneyExplorer

final class ExplorerViewModelTests: XCTestCase {
    func test_getAllCharacters() async {
        let mockUrlSession = MockURLSession()
        let client = DisneyClient(urlSession: mockUrlSession)
        
        let sut = ExplorerViewModel(client: client)
        
        XCTAssertEqual(sut.viewState, .notLoaded)
        
        await sut.getAllCharacters()
        
        let elsa = Character(dto: MockResponse.elsa)
        let queenArianna = Character(dto: MockResponse.queenArianna)
        
        let characters: [Character] = [elsa, queenArianna]
        XCTAssertEqual(sut.characters, characters)
        XCTAssertEqual(sut.viewState, .loaded)
    }
}

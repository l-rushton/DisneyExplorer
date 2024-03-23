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
        info = MockResponse.info
        queenArianna = MockResponse.queenArianna
        elsa = MockResponse.elsa
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

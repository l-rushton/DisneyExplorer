//
//  StorageManagerTests.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 25/03/2024.
//

import XCTest
import SwiftData
@testable import DisneyExplorer

final class StorageManagerTests: XCTestCase {
    var sut: StorageManager!
    var elsa: Character!
    
    @MainActor
    override func setUp() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Character.self, configurations: config)
        sut = StorageManager.init(modelContainer: container)
        
        elsa = Character(dto: MockResponse.elsa)
        
        guard elsa != nil else {
            XCTFail()
            return
        }
    }
    
    override func tearDown() {
        sut = nil
        elsa = nil
    }
    
    func test_store() async throws {
        let emptyArray = try await sut.fetchAll()
        XCTAssert(emptyArray.isEmpty)

        try await sut.store(elsa)
        
        let fetchedResults = try await sut.fetchAll()
        XCTAssertEqual(fetchedResults.first, elsa)
        XCTAssertEqual(fetchedResults.count, 1)
    }

    func test_delete_success() async throws {
        try await self.sut.store(elsa)
        
        let fetchedResults = try await sut.fetchAll()
        XCTAssertEqual(fetchedResults.first, elsa)
        
        try await sut.delete(id: elsa.id)
        
        var newFetchedResults = [elsa]
        
        newFetchedResults = try await sut.fetchAll()
        XCTAssertEqual(newFetchedResults.count, 0)
    }
    
    func test_isCharacterFavourite_true() async throws {
        try await self.sut.store(elsa)
        
        let isFavourite = try await self.sut.isCharacterFavourite(id: elsa.id)
        
        XCTAssertTrue(isFavourite)
    }
    
    
    func test_isCharacterFavourite_false() async throws {
        let isFavourite = try await self.sut.isCharacterFavourite(id: elsa.id)
        
        XCTAssertFalse(isFavourite)
    }
}

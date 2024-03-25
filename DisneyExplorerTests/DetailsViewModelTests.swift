//
//  DetailsViewModelTests.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

import XCTest
import SwiftData
@testable import DisneyExplorer

final class DetailsViewModelTests: XCTestCase {
    var storageManager: StorageManager!
    
    override func setUp() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Character.self, configurations: config)
        storageManager = StorageManager.init(modelContainer: container)
    }
    
    override func tearDown() {
        storageManager = nil
    }
    
    func test_checkCharacterIsFavourite() async throws {
        guard let elsa = Character(dto: MockResponse.elsa) else {
            XCTFail()
            return
        }
        
        let sut = CharacterDetailsViewModel(character: elsa, storageManager: self.storageManager)
        
        await sut.checkCharacterIsFavourite()
        
        XCTAssertFalse(sut.isFavourite)
        
        try? await self.storageManager.store(elsa)
        
        await sut.checkCharacterIsFavourite()
        
        XCTAssertTrue(sut.isFavourite)
    }
    
    func test_deleteCharacterFromFavourites() async throws {
        guard let elsa = Character(dto: MockResponse.elsa) else {
            XCTFail()
            return
        }
        
        try? await self.storageManager.store(elsa)
        
        let sut = CharacterDetailsViewModel(character: elsa, storageManager: self.storageManager)
        
        await sut.checkCharacterIsFavourite()
        
        XCTAssertTrue(sut.isFavourite)
        
        try? await sut.deleteCharacterFromFavourites()
        
        XCTAssertFalse(sut.isFavourite)
    }
    
    func test_saveCharacterToFavourites() async throws {
        guard let elsa = Character(dto: MockResponse.elsa) else {
            XCTFail()
            return
        }
        
        let sut = CharacterDetailsViewModel(character: elsa, storageManager: self.storageManager)
        
        await sut.checkCharacterIsFavourite()
        
        XCTAssertFalse(sut.isFavourite)
        
        await sut.saveCharacterToFavourites()
        
        XCTAssertTrue(sut.isFavourite)
    }
    
    func test_makeStringFromArray() {
        let apple = "apple"
        let pear = "pear"
        let banana = "banana"
        let orange = "orange"
        let dragonFruit = "dragon fruit"
        let durian = "durian"
        
        let arr = [apple, pear, banana, orange, dragonFruit, durian]
        
        let expectedString = "apple, pear, banana, orange, dragon fruit, durian"
        
        guard let elsa = Character(dto: MockResponse.elsa) else {
            XCTFail()
            return
        }
        
        let sut = CharacterDetailsViewModel(character: elsa, storageManager: self.storageManager)
        
        let result = sut.makeStringFromArray(arr)
        
        XCTAssertEqual(result, expectedString)
    }
}

//
//  CharacterDetailsViewModel.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 24/03/2024.
//

import Foundation
import SwiftData
import Observation

@Observable
class CharacterDetailsViewModel: ObservableObject {
    private(set) var storageManager: StorageManager
    
    private(set) var character: Character
    private(set) var isFavourite: Bool
    private(set) var filmsString: String = ""
    private(set) var shortFilmsString: String = ""
    
    init(character: Character, isFavourite: Bool = false, storageManager: StorageManager) {
        self.character = character
        self.isFavourite = isFavourite
        self.storageManager = storageManager
    }
    
    func checkCharacterIsFavourite() async {
        let matchingId = character.id
        
        isFavourite = await storageManager.isCharacterFavourite(id: matchingId)
    }
    
    func deleteCharacterFromFavourites() async throws {
        let id = character.id
        
        isFavourite = await !storageManager.delete(id: id)
    }
    
    func saveCharacterToFavourites() async {
        let character = self.character
        
        do {
            try await storageManager.store(character)
            isFavourite = true
        } catch {
            isFavourite = false
        }
    }
    
    func makeStringFromArray(_ arr: [String]) -> String {
        var string = ""
        
        guard !arr.isEmpty else {
            return string
        }

        for film in arr {
            string.append("\(film), ")
        }
        
        string.removeLast(2)
        return string
    }
}

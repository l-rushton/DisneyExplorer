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
        
        do {
            isFavourite = try await storageManager.isCharacterFavourite(id: matchingId)
        } catch {
            isFavourite = false
        }
    }
    
    func deleteCharacterFromFavourites() async throws {
        let id = character.id
        
        do {
            try await storageManager.delete(id: id)
            isFavourite = false
        } catch {
            isFavourite = true
        }
    }
    
    func saveCharacterToFavourites() async {
        do {
            try await storageManager.store(self.character)
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

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
    private var modelContext: ModelContext
    
    private(set) var character: Character
    private(set) var isFavourite: Bool
    
    private(set) var filmsString: String = ""
    
    private(set) var shortFilmsString: String = ""
    
    init(character: Character, isFavourite: Bool = false, modelContext: ModelContext) {
        self.character = character
        self.isFavourite = isFavourite
        self.modelContext = modelContext
    }
    
    func checkCharacterIsFavourite() {
        let matchingId = character.id
        var descriptor = FetchDescriptor<Character>(predicate: #Predicate {
            $0.id == matchingId
        }, sortBy: [ .init(\.name) ])
        
        descriptor.fetchLimit = 1
        
        do {
            let ch = try modelContext.fetch(descriptor)
            isFavourite = ch.isEmpty ? false : true
        } catch {
            isFavourite = false
        }
    }
    
    func deleteCharacterFromFavourites() {
        let id = character.id
        do {
            try modelContext.delete(model: Character.self, where: #Predicate { $0.id == id})
            
            isFavourite = false
        } catch {
            debugPrint("Couldn't delete character")
        }
    }
    
    func saveCharacterToFavourites() {
        modelContext.insert(character)
        try? modelContext.save()
        isFavourite = true
    }
    
    func makeFilmsString(films: [String]) -> String {
        var string = ""
        
        guard !films.isEmpty else {
            return string
        }

        for film in films {
            string.append("\(film), ")
        }
        
        string.removeLast(2)
        return string
    }
}

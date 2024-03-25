//
//  StorageManager.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 25/03/2024.
//

import SwiftData
import Foundation

@ModelActor
actor StorageManager {
    func store(_ character: Character) throws {
        modelContext.insert(character)
    }
    
    func delete(id: Int) -> Bool {
        if isCharacterFavourite(id: id) {
            try? modelContext.delete(model: Character.self, where: #Predicate { $0.id == id})
            return true
        } else {
            return false
        }
    }
    
    func fetchAll() -> [Character]  {
        let descriptor = FetchDescriptor<Character>()
        let results = try? modelContext.fetch(descriptor)
        
        return results ?? []
    }
    
    func isCharacterFavourite(id: Int) -> Bool {
        var descriptor = FetchDescriptor<Character>(predicate: #Predicate {
            $0.id == id
        }, sortBy: [ .init(\.name) ])
        
        descriptor.fetchLimit = 1
        
        if let ch = try? modelContext.fetch(descriptor) {
            return !ch.isEmpty
        } else {
            return false
        }
    }
}

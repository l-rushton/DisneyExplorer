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
        
        do {
            try modelContext.save()
        } catch {
            debugPrint("Could not store character")
            throw StorageManagerError.store
        }
    }
    
    func delete(id: Int) throws {
        do {
            try modelContext.delete(model: Character.self, where: #Predicate { $0.id == id})
        } catch {
            debugPrint("Couldn't delete character")
            throw StorageManagerError.delete
        }
    }
    
    func fetchAll() throws -> [Character]  {
        do {
            let descriptor = FetchDescriptor<Character>()
            return try modelContext.fetch(descriptor)
        } catch {
            debugPrint("Fetch failed")
            throw StorageManagerError.fetch
        }
    }
    
    func isCharacterFavourite(id: Int) throws -> Bool {
        var descriptor = FetchDescriptor<Character>(predicate: #Predicate {
            $0.id == id
        }, sortBy: [ .init(\.name) ])
        
        descriptor.fetchLimit = 1
        
        do {
            let ch = try modelContext.fetch(descriptor)
            return !ch.isEmpty
        } catch {
            return false
        }
    }
}

enum StorageManagerError: Error {
    case store
    case delete
    case fetch
}

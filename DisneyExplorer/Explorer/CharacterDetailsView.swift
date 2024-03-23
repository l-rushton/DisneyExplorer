//
//  CharacterDetailsView.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI
import SwiftData

struct CharacterDetailsView: View {
    // Using stateobject because you can't use property wrappers inside macros like observable
    
    // try refactoring swiftdata crud out and trying again
    @StateObject var viewModel: CharacterDetailsViewModel
    
    var body: some View {
        VStack {
            characterImage(url: viewModel.character.imageUrl, size: 300)
            Text(viewModel.character.name)
            List {
                Text("Films: \(viewModel.filmsString)")
                Text("Short films: \(viewModel.shortFilmsString)")
            }
            
            Button {
                viewModel.saveCharacterToFavourites()
            } label: {
                Text("Save")
            }
            
            Button {
                viewModel.deleteCharacterFromFavourites()
            } label: {
                Text("Delete")
            }
        }
    }
}

class CharacterDetailsViewModel: ObservableObject {
    var modelContext: ModelContext
    
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
            let _ = try modelContext.fetch(descriptor)
            isFavourite = true
        } catch {
            isFavourite = false
        }
    }
    
    func deleteCharacterFromFavourites() {
        modelContext.delete(character)
    }
    
    func saveCharacterToFavourites() {
        modelContext.insert(character)
    }
    
    func makeFilmsString(films: [String]) -> String {
        var string = ""
        guard films.isEmpty else {
            return string
        }

        for film in character.films {
            string.append("\(film), ")
        }
        string.removeLast(2)
        return string
    }
}

//
//  ExplorerViewModel.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation
import Observation
import SwiftData

@Observable
class ExplorerViewModel {
    var modelContext: ModelContext
    
    private(set) var client: DisneyClient
    private(set) var viewState: ExplorerViewState
    
    private(set) var characters: [Character]
    private(set) var favourites: [Character]
    
    init(
        client: DisneyClient = DisneyClient(),
        viewState: ExplorerViewState = .notLoaded, 
        characters: [Character] = [],
        favourites: [Character] = [],
        modelContext: ModelContext
    ) {
        self.client = client
        self.viewState = viewState
        self.characters = characters
        self.favourites = favourites
        
        self.modelContext = modelContext
    }
    
    func fetchFavourites() {
        do {
            let descriptor = FetchDescriptor<Character>()
            favourites = try modelContext.fetch(descriptor)
        } catch {
            debugPrint("Fetch failed")
        }
    }
    
    func getAllCharacters() async {
        viewState = .loading
        
        let result = await client.getAllCharacters()
        
        switch result {
        case let .success(characterDTO):
            let charactersResult: [Character] = characterDTO.data.compactMap{ characterDTO in
                return Character(dto: characterDTO)
            }
            characters = charactersResult
            viewState = .loaded
        case let .failure(error):
            // TODO: surface error messages
            viewState = .error
        }
    }
}

enum ExplorerViewState {
    case notLoaded
    case loading
    case loaded
    case error
}

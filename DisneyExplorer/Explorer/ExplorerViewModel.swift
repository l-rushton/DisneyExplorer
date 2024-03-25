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
    private(set) var storageManager: StorageManager
    
    private(set) var client: DisneyClient
    private(set) var viewState: ExplorerViewState
    
    private(set) var characters: [Character]
    private(set) var favourites: [Character]
    private(set) var nextPageUrl: String?
    
    init(
        client: DisneyClient = DisneyClient(),
        viewState: ExplorerViewState = .notLoaded, 
        characters: [Character] = [],
        favourites: [Character] = [],
        storageManager: StorageManager
    ) {
        self.client = client
        self.viewState = viewState
        self.characters = characters
        self.favourites = favourites
        
        self.storageManager = storageManager
    }
    
    func fetchFavourites() async {
        do {
            favourites = try await storageManager.fetchAll()
        } catch {
            favourites = []
        }
    }
    
    func getAllCharacters() async {
        viewState = .loading
        
        let result = await client.getAllCharacters()
        
        switch result {
        case let .success(getAllDTO):
            let charactersResult: [Character] = getAllDTO.data?.compactMap{ characterDTO in
                return Character(dto: characterDTO)
            } ?? []
            
            nextPageUrl = getAllDTO.info?.nextPage
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

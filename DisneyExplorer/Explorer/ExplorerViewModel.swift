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
    var nextPageLoading: Bool = false
    
    init(
        client: DisneyClient = DisneyClient(),
        viewState: ExplorerViewState = .notLoaded, 
        characters: [Character] = [],
        favourites: [Character] = [],
        nextPageUrl: String? = nil,
        storageManager: StorageManager
    ) {
        self.client = client
        self.viewState = viewState
        self.characters = characters
        self.favourites = favourites
        self.nextPageUrl = nextPageUrl
        
        self.storageManager = storageManager
    }
    
    func fetchFavourites() async {
        do {
            favourites = try await storageManager.fetchAll()
        } catch {
            favourites = []
        }
    }
    
    func getCharacters(nextPage: Bool = false) async {
        let result: Result<GetAllDTO, ClientError>
        
        if nextPage, let nextPageUrl {
            
            nextPageLoading = true
            result = await client.getCharacters(url: nextPageUrl)
            
        } else {
            
            viewState = .loading
            result = await client.getCharacters()
            
        }
        
        switch result {
        case let .success(getAllDTO):
            let charactersResult: [Character] = getAllDTO.data?.compactMap{ characterDTO in
                return Character(dto: characterDTO)
            } ?? []
            
            nextPageUrl = getAllDTO.info?.nextPage
            
            if nextPage {
                characters += charactersResult
                nextPageLoading = false 
            } else {
                characters = charactersResult
            }

            characters.sort(by: { $0.films.count > $1.films.count })
            
            viewState = .loaded
            
        case let .failure(error):
            viewState = .error(error.string)
        }
    }
}

enum ExplorerViewState: Equatable {
    case notLoaded
    case loading
    case loaded
    case error(String)
}

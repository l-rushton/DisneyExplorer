//
//  ExplorerViewModel.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation
import Observation

@Observable
class ExplorerViewModel {
    private(set) var client: DisneyClient
    private(set) var viewState: ExplorerViewState
    
    private(set) var characters: [Character]
    
    init(
        client: DisneyClient = DisneyClient(),
        viewState: ExplorerViewState = .notLoaded, 
        characters: [Character] = []
    ) {
        self.client = client
        self.viewState = viewState
        self.characters = characters
    }
    
    func getAllCharacters() async {
        
    }
}

enum ExplorerViewState {
    case notLoaded
    case loading
    case loaded
    case error
}

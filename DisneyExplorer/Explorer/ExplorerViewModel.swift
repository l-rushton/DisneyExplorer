//
//  ExplorerViewModel.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation
import Observation

class ExplorerViewModel {
    private(set) var characters: [Character] = []
    private(set) var viewState: ExplorerViewState = .notLoaded
}

enum ExplorerViewState {
    case notLoaded
    case loading
    case loaded
    case error
}

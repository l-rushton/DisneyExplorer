//
//  ContentView.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let storageManager: StorageManager
    
    var body: some View {
        NavigationView {
            ExplorerView(viewModel: ExplorerViewModel(storageManager: storageManager))
        }
    }
}

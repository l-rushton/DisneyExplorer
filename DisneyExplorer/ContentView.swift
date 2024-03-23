//
//  ContentView.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let modelContext: ModelContext
    
    var body: some View {
        NavigationView {
            ExplorerView(modelContext: modelContext)
        }
    }
}

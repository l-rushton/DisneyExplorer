//
//  DisneyExplorerApp.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI
import SwiftData

@main
struct DisneyExplorerApp: App {
    let container: ModelContainer

    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: Character.self)
        } catch {
            fatalError("Failed to create ModelContainer, favourite characters won't load")
        }
    }
}

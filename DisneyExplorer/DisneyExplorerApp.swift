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
    let storageManager: StorageManager

    var body: some Scene {
        WindowGroup {
            ContentView(storageManager: storageManager)
        }
        .modelContainer(storageManager.modelContainer)
    }
    
    init() {
        do {
            let container = try ModelContainer(for: Character.self)
            storageManager = StorageManager(modelContainer: container)
        } catch {
            fatalError("Failed to create ModelContainer, favourite characters won't load")
        }
    }
}

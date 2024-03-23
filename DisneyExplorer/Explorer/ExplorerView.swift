//
//  ExplorerView.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI
import SwiftData

struct ExplorerView: View {
    @State private var viewModel: ExplorerViewModel
    
    var body: some View {
        ZStack {
            Color.mint
            switch viewModel.viewState {
            case .notLoaded:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded:
                VStack {
                    VStack(alignment: .leading) {
                        Text("Favourites")
                        if viewModel.favourites.isEmpty {
                            Text("You can add favourites in character details!")
                        } else {
                            ScrollView(.horizontal) {
                                ForEach(viewModel.favourites) { favourite in
                                    characterImage(url: favourite.imageUrl, size: 25)
                                }
                            }
                        }
                    }
                    List {
                        ForEach(viewModel.characters) { character in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: Text("destination: ")) {
                                    CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: character, modelContext: viewModel.modelContext))
                                }
                                .opacity(0)
                                CharacterCard(character: character)
                            }
                            .listRowSeparator(.hidden)
                        }
                        
                    }
                }
                .navigationTitle("Explorer")
            case .error:
                // TODO: change
                Text("error")
            }
        }
        .task {
            await viewModel.getAllCharacters()
        }
    }
    
    init(modelContext: ModelContext) {
         let viewModel = ExplorerViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
}

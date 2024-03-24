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
            switch viewModel.viewState {
            case .notLoaded:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded:
                VStack {
                    HStack {
                        if viewModel.favourites.isEmpty {
                            Text("Add favourites in character details!")
                        } else {
                            ScrollView(.horizontal) {
                                HStack {
                                    Text("Favourites:")
                                        .font(.subheadline)
                                    ForEach(viewModel.favourites) { favourite in
                                        characterImage(url: favourite.imageUrl, size: 25)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.yellow)
                    .padding()
                    .cornerRadius(10)
                    
                    List {
                        ForEach(viewModel.characters) { character in
                            ZStack(alignment: .leading) {
                                NavigationLink(destination:  CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: character, modelContext: viewModel.modelContext))) {
                                   EmptyView()
                                }
                                .opacity(0)
                                CharacterCard(character: character)
                            }
                            .listRowSeparator(.hidden)
                        }
                        
                    }
                }
                .navigationTitle("Explorer")
                .onAppear {
                    viewModel.fetchFavourites()
                }
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

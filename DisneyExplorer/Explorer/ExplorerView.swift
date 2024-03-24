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
    @State private var fetched: Bool = false
    
    init(modelContext: ModelContext) {
         let viewModel = ExplorerViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .notLoaded:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded:
                VStack {
                    List {
                        if viewModel.favourites.isEmpty {
                            HStack {
                                Spacer()
                                Text("No favourites yet...")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                        } else {
                            HStack {
                                ScrollView(.horizontal) {
                                    HStack {
                                        Text("Favourites:")
                                            .font(.subheadline)
                                        ForEach(viewModel.favourites) { favourite in
                                            characterImage(url: favourite.imageUrl, size: 50)
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(10)
                        }
                        
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
                .refreshable {
                    await viewModel.getAllCharacters()
                }
            case .error:
                VStack {
                    Text("Error")
                    Button {
                        Task {
                            await viewModel.getAllCharacters()
                        }
                    } label: {
                        Text("Retry")
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                            .padding()
                        
                    }
                }
            }
        }
        .task {
            if !fetched {
                fetched = true
                await viewModel.getAllCharacters()
            }
        }
    }
}

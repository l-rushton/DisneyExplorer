//
//  ExplorerView.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI
import SwiftData

struct ExplorerView: View {
    private var viewModel: ExplorerViewModel
    @State private var fetched: Bool = false
    
    init(viewModel: ExplorerViewModel) {
        self.viewModel = viewModel
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
                        Section(header: Text("Favourites")) {
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
                                            ForEach(viewModel.favourites) { favourite in
                                                CharacterImage(url: favourite.imageUrl, size: 50)
                                            }
                                        }
                                    }
                                }

                            }
                        }
                        .listRowBackground (
                            RoundedRectangle(cornerRadius: 10, style: .circular)
                                .stroke(Color.white, lineWidth: 4)
                        )
                        
                        Section(header: Text("Characters")) {
                            ForEach(viewModel.characters) { character in
                                ZStack(alignment: .leading) {
                                    NavigationLink(
                                        destination: CharacterDetailsView(
                                            viewModel: CharacterDetailsViewModel(
                                                character: character,
                                                storageManager: viewModel.storageManager
                                            )
                                        )
                                    ) {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                    
                                    CharacterCard(character: character)
                                }
                                .listRowSeparator(.hidden)
                            }
                        }
                        
                        Section {
                            Button {
//                                await viewModel.fetchNextPage()
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                        .listRowBackground(Color(uiColor: UIColor.secondarySystemBackground))
                    }
                }
                .navigationTitle("Explorer")
                .task {
                    await viewModel.fetchFavourites()
                }
                .refreshable {
                    await viewModel.getAllCharacters()
                }
            case .error:
                VStack {
                    Text("Error")
                    actionButton(buttonType: .retry) {
                        Task {
                            await viewModel.getAllCharacters()
                        }
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

//
//  ExplorerView.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI

struct ExplorerView: View {
    let viewModel: ExplorerViewModel
    
    var body: some View {
        ZStack {
            Color.mint
            switch viewModel.viewState {
            case .notLoaded:
                EmptyView()
            case .loading:
                ProgressView()
            case .loaded:
                List {
                    ForEach(viewModel.characters) { character in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: Text("destination: ")) {
                                EmptyView()
                            }
                            .opacity(0)
                            CharacterCard(character: character)
                        }
                        .listRowSeparator(.hidden)
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
        
}

#Preview {
    ExplorerView(viewModel: ExplorerViewModel(viewState: .loaded))
}

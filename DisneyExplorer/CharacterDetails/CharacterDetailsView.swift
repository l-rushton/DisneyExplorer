//
//  CharacterDetailsView.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI

struct CharacterDetailsView: View {    
    // try refactoring swiftdata crud out and trying again
    var viewModel: CharacterDetailsViewModel
    
    var body: some View {
        VStack {
            CharacterImage(url: viewModel.character.imageUrl, size: 300)
                .overlay(alignment: .topTrailing) {
                    if viewModel.isFavourite {
                        Image(systemName: "star.fill")
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
            }
            
            Text(viewModel.character.name)
                .font(.title)
            
            List {
                if !viewModel.character.films.isEmpty {
                    Section(header: Text("Films")) {
                        Text(viewModel.makeFilmsString(films: viewModel.character.films))
                    }
                }
                
                if !viewModel.character.shortFilms.isEmpty {
                    Section(header: Text("Short films")) {
                        Text(viewModel.makeFilmsString(films: viewModel.character.shortFilms))
                    }
                }
                
                if let tvShows = viewModel.character.tvShows, !tvShows.isEmpty {
                    Section(header: Text("TV shows")) {
                        Text(viewModel.makeFilmsString(films: tvShows))
                    }
                }
                
                if let videoGames = viewModel.character.videoGames, !videoGames.isEmpty {
                    Section(header: Text("Video games")) {
                        Text(viewModel.makeFilmsString(films: videoGames))
                    }
                }
                
                if let parkAttractions = viewModel.character.parkAttractions, !parkAttractions.isEmpty {
                    Section(header: Text("Park attractions")) {
                        Text(viewModel.makeFilmsString(films: parkAttractions))
                    }
                }
                
                if let allies = viewModel.character.allies, !allies.isEmpty {
                    Section(header: Text("Allies")) {
                        Text(viewModel.makeFilmsString(films: allies))
                    }
                }

                if let enemies = viewModel.character.enemies, !enemies.isEmpty {
                    Section(header: Text("Enemies")) {
                        Text(viewModel.makeFilmsString(films: enemies))
                    }
                }
            }
            
            if viewModel.isFavourite {
                actionButton(buttonType: .delete) {
                    Task {
                        try await viewModel.deleteCharacterFromFavourites()
                    }
                }
            } else {
                actionButton(buttonType: .save) {
                    Task {
                        await viewModel.saveCharacterToFavourites()
                    }
                }
            }
        }
        .background (Color(UIColor.secondarySystemBackground))
        .task {
            await viewModel.checkCharacterIsFavourite()
        }
    }
}


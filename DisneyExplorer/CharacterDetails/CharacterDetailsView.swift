//
//  CharacterDetailsView.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    private var viewModel: CharacterDetailsViewModel
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
    }
    
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
                        Text(viewModel.makeStringFromArray(viewModel.character.films))
                    }
                }
                
                if !viewModel.character.shortFilms.isEmpty {
                    Section(header: Text("Short films")) {
                        Text(viewModel.makeStringFromArray(viewModel.character.shortFilms))
                    }
                }
                
                if let tvShows = viewModel.character.tvShows, !tvShows.isEmpty {
                    Section(header: Text("TV shows")) {
                        Text(viewModel.makeStringFromArray(tvShows))
                    }
                }
                
                if let videoGames = viewModel.character.videoGames, !videoGames.isEmpty {
                    Section(header: Text("Video games")) {
                        Text(viewModel.makeStringFromArray(videoGames))
                    }
                }
                
                if let parkAttractions = viewModel.character.parkAttractions, !parkAttractions.isEmpty {
                    Section(header: Text("Park attractions")) {
                        Text(viewModel.makeStringFromArray(parkAttractions))
                    }
                }
                
                if let allies = viewModel.character.allies, !allies.isEmpty {
                    Section(header: Text("Allies")) {
                        Text(viewModel.makeStringFromArray(allies))
                    }
                }

                if let enemies = viewModel.character.enemies, !enemies.isEmpty {
                    Section(header: Text("Enemies")) {
                        Text(viewModel.makeStringFromArray(enemies))
                    }
                }
            }
            
            if viewModel.isFavourite {
                ActionButton(buttonType: .delete) {
                    try await viewModel.deleteCharacterFromFavourites()
                }
            } else {
                ActionButton(buttonType: .save) {
                    await viewModel.saveCharacterToFavourites()
                }
            }
        }
        .background (Color(UIColor.secondarySystemBackground))
        .task {
            await viewModel.checkCharacterIsFavourite()
        }
    }
}


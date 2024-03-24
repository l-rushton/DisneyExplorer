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
            characterImage(url: viewModel.character.imageUrl, size: 300)
                .overlay(alignment: .topLeading) {
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

            }
            if viewModel.isFavourite {
                Button {
                    viewModel.deleteCharacterFromFavourites()
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete from favourites")
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding()
                }
            } else {
                Button {
                    viewModel.saveCharacterToFavourites()
                } label: {
                    HStack {
                        Spacer()
                        Text("Add to favourites")
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
        .background (Color(UIColor.secondarySystemBackground))
        .onAppear {
            viewModel.checkCharacterIsFavourite()
        }
    }
}

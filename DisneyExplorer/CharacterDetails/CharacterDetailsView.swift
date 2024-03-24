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
            
            if viewModel.isFavourite {
                HStack {
                    Text("Favourite")
                        .bold()
                    Image(systemName: "star.fill")
                }
                .padding()
                .background(Color.yellow)
                .cornerRadius(10)
            }
            
            characterImage(url: viewModel.character.imageUrl, size: 300)
            
            Text(viewModel.character.name)
                .font(.title)
            
            List {
                Text("Films: \(viewModel.makeFilmsString(films: viewModel.character.films))")
                Text("Short films: \(viewModel.makeFilmsString(films: viewModel.character.shortFilms))")
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
        .onAppear {
            viewModel.checkCharacterIsFavourite()
        }
    }
}

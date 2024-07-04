//
//  SwiftConcurrencyView.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import SwiftUI

struct AsyncPokemonView: View {
    @StateObject var pokemonViewModel = PokemonsViewModel()
    @State var showSync: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    Task {
                        await pokemonViewModel.fetchAllPokemonImages()
                    }
                    showSync.toggle()
                } label: {
                    Text(showSync ? "Show Async" : "Show with DispatchGroups")
                }
                
//MARK: DispatchGroup
                if showSync {
                    List(pokemonViewModel.images, id: \.self) { img in
                        HStack {
                            if let img {
                                Image(uiImage: img)
                                    .frame(width: 60, height: 60)
                            } else {
                                ProgressView()
                            }
                        }
                    }
                } else {
//MARK: AsyncImage
                    List(pokemonViewModel.pokemonList) { pokemon in
                        HStack {
                            AsyncImage(url: pokemon.sprites.front_default) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            Text(pokemon.name.capitalized)
                        }
                    }
                }
            }
            .navigationTitle("Pokémon")
            .task {
                await pokemonViewModel.fetchAllPokemons()
            }
        }
    }
}

#Preview {
    AsyncPokemonView()
}

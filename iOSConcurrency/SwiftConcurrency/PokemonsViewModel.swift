//
//  PokemonsViewModel.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import SwiftUI

class PokemonsViewModel: ObservableObject {
    private let pokemonService = PokemonService()
    @Published var pokemonList: [Pokemon] = []
    @Published var images: [UIImage?] = []
    
    func fetchAllPokemons() async {
        Task {
            await pokemonService.fetchPokemons()
            DispatchQueue.main.async {
                self.pokemonList = self.pokemonService.pokemonList
            }
        }
    }
    
    func fetchAllPokemonImages() async {
        self.pokemonService.fetchImages(for: self.pokemonService.pokemonList) { value in
            if value {
                self.images = self.pokemonService.pokemonImages
            }
        }
    }
}

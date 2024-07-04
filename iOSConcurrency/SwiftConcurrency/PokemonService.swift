//
//  PokemonService.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import UIKit

class PokemonService {
    var pokemonList: [Pokemon] = []
    var pokemonImages: [UIImage?] = []
    
//MARK: withThrowingTaskGroup
    func fetchPokemons() async {
        do {
            let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100")!
            let (data ,_) = try await URLSession.shared.data(from: url)
            let listResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
            
            let fetchedPokemon = try await withThrowingTaskGroup(of: Pokemon.self) { group -> [Pokemon] in
                for entry in listResponse.results {
                    group.addTask {
                        let (pokemonData, _) = try await URLSession.shared.data(from: entry.url)
                        return try JSONDecoder().decode(Pokemon.self, from: pokemonData)
                    }
                }
                
                var pokemonList: [Pokemon] = []
                for try await pokemon in group {
                    pokemonList.append(pokemon)
                }
                return pokemonList
            }
            
            DispatchQueue.main.async {
                self.pokemonList = fetchedPokemon
            }
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
//MARK: DispatchGroup
    func fetchImages(for pokemonList: [Pokemon], completion: @escaping (Bool)->()) {
        var images: [UIImage?] = []
        let dispatchGroup = DispatchGroup()
        
        for pokemon in pokemonList {
            dispatchGroup.enter()
            let url = pokemon.sprites.front_default
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { // end of the func or end of the loop
                    dispatchGroup.leave()
                }
                
                if let error = error {
                    print("Error fetching image for \(pokemon.name): \(error.localizedDescription)")
                    images.append(nil)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response for \(pokemon.name): \(response.debugDescription)")
                    images.append(nil)
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    images.append(image)
                } else {
                    images.append(nil)
                }
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.pokemonImages = images
            completion(true)
        }
    }
}

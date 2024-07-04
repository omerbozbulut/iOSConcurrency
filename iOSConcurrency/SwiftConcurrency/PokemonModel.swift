//
//  PokemonModel.swift
//  iOSConcurrency
//
//  Created by Ömer Bozbulut on 3.07.2024.
//

import UIKit

struct PokemonListResponse: Decodable {
    let results: [PokemonListEntry]

    struct PokemonListEntry: Decodable {
        let name: String
        let url: URL
    }
}

struct Pokemon: Identifiable, Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    
    struct Sprites: Decodable {
        let front_default: URL
    }
}

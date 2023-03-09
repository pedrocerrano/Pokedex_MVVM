//
//  Pokemon.swift
//  Pokedex_Codable
//
//  Created by iMac Pro on 2/28/23.
//

import Foundation

struct TopLevel: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PokemonResults]
}

struct PokemonResults: Decodable {
    let name: String
    let url: String
}

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    let moves: [Moves]
}

struct Sprites: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
    let frontDefault: String
    let frontShiny: String
}

struct Moves: Decodable {
    let move: Move
}

struct Move: Decodable {
    let name: String
    let url: String
}

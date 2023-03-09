//
//  Pokemon.swift
//  Pokedex
//
//  Created by iMac Pro on 2/23/23.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let moves: [CharacterMoves]
    let sprites: Sprite
}

struct CharacterMoves: Decodable {
    let move: Move
}

struct Move: Decodable {
    private enum CodingKeys: String, CodingKey {
        case moveName = "name"
    }
    
    let moveName: String
}

struct Sprite: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontShiny = "front_shiny"
    }
    
    let frontShiny: String
}

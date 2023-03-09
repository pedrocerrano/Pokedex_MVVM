//
//  Pokemon.swift
//  Pokedex
//
//  Created by iMac Pro on 2/23/23.
//

import Foundation

class Pokemon {
    
    let name: String
    let id: Int
    let moves: [String]
    let spritePath: String
    
    enum Keys: String {
        case name
        case id
        case moves
        case move
        case sprites
        case frontShiny = "front_shiny"
    }
    
    init?(pokemonDictionary: [String : Any]) {
        guard let name = pokemonDictionary[Keys.name.rawValue] as? String,
              let id = pokemonDictionary[Keys.id.rawValue] as? Int,
              let spriteDictionary = pokemonDictionary[Keys.sprites.rawValue] as? [String : Any],
              let spritePosterPath = spriteDictionary[Keys.frontShiny.rawValue] as? String,
              let movesArray = pokemonDictionary[Keys.moves.rawValue] as? [[String : Any]] else { return nil }
        
        var moves: [String] = []
        for dict in movesArray {
            guard let moveDictionary = dict[Keys.move.rawValue] as? [String : Any],
                  let moveName = moveDictionary[Keys.name.rawValue] as? String else { return nil }
            moves.append(moveName)
        }
        
        self.name = name
        self.id = id
        self.moves = moves
        self.spritePath = spritePosterPath
    }
}

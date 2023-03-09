//
//  PokemonTableViewCell.swift
//  Pokedex_Codable
//
//  Created by iMac Pro on 2/28/23.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    
    
    //MARK: - FUNCTIONS
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonNameLabel.text        = nil
        pokemonIDLabel.text          = nil
        pokemonSpriteImageView.image = nil
    }
    
    
    func updateUI(forPokemon pokemon: PokemonResults) {
        NetworkingController.fetchPokemon(with: pokemon.url) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.fetchSprite(forPokemon: pokemon)
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
    
    
    func fetchSprite(forPokemon pokemon: Pokemon) {
        NetworkingController.fetchSprite(for: pokemon.sprites.frontShiny) { [weak self] result in
            switch result {
            case .success(let sprite):
                DispatchQueue.main.async {
                    self?.pokemonNameLabel.text  = pokemon.name.capitalized
                    self?.pokemonIDLabel.text    = "No. \(pokemon.id)"
                    self?.pokemonSpriteImageView.image = sprite
                }
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
}

//
//  PokemonHomePageViewModel.swift
//  Pokedex_Codable
//
//  Created by iMac Pro on 3/9/23.
//

import Foundation

protocol PokemonHomePageViewModelDelegate: AnyObject {
    func pokedexLoadedSuccesfully()
}

class PokemonHomePageViewModel {
    weak var delegate: PokemonHomePageViewModelDelegate?
//    var topLevel: TopLevel?
    var pokedex: [PokemonResults] = []
    let service: NetworkingService
    
    init(delegate: PokemonHomePageViewModelDelegate, service: NetworkingService = NetworkingService()) {
        self.delegate = delegate
//        self.topLevel = topLevel
        self.service = service
        self.fetchPokedex()
    }
    
    func fetchPokedex() {
        service.fetchPokedex(with: Constants.Pokemon.fetchPokedexURL) { result in
            switch result {
            case .success(let topLevel):
//                self.topLevel = topLevel
                self.pokedex  = topLevel.results
                self.delegate?.pokedexLoadedSuccesfully()
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
}

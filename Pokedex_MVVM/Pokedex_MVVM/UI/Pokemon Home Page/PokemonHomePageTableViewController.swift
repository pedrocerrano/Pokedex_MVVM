//
//  PokemonHomePageTableViewController.swift
//  Pokedex_Codable
//
//  Created by iMac Pro on 2/28/23.
//

import UIKit

class PokemonHomePageTableViewController: UITableViewController {
    
    //MARK: - PROPERTIES
    var viewModel: PokemonHomePageViewModel!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PokemonHomePageViewModel(delegate: self)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokedex.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }
        
        let pokemon = viewModel.pokedex[indexPath.row]
        cell.updateUI(forPokemon: pokemon)
        
        return cell
    }
    
    //MARK: - PAGINATION
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let topLevel = topLevel else { return }
//
//        if indexPath.row == pokedex.count - 1 {
//            NetworkingService.fetchPokedex(with: topLevel.next) { [weak self] result in
//                switch result {
//                case .success(let topLevel):
//                    self?.topLevel = topLevel
//                    self?.pokedex.append(contentsOf: topLevel.results)
//                    self?.reloadTableViewOnMainThread()
//
//                case .failure(let error):
//                    print(error.errorDescription ?? Constants.Error.unknownError)
//                }
//            }
//        }
//    }
    
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toPokemonDetailVC" {
//            if let index = tableView.indexPathForSelectedRow {
//                if let destinationVC = segue.destination as? PokemonDetailVC {
//                    let pokemonToSend = pokedex[index.row]
//                    NetworkingService.fetchPokemon(with: pokemonToSend.url) { result in
//                        switch result {
//                        case .success(let pokemon):
//                            DispatchQueue.main.async {
//                                destinationVC.pokemon = pokemon
//                            }
//
//                        case .failure(let error):
//                            print(error.errorDescription ?? Constants.Error.unknownError)
//                        }
//                    }
//                }
//            }
//        }
//    }
} //: CLASS


//MARK: - EXT: ViewModel Delegate
extension PokemonHomePageTableViewController: PokemonHomePageViewModelDelegate {
    func pokedexLoadedSuccesfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

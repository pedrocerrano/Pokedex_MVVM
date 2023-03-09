//
//  PokemonTableViewController.swift
//  Pokedex_Codable
//
//  Created by iMac Pro on 2/28/23.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokedex()
    }
    
    
    //MARK: - PROPERTIES
    var topLevel: TopLevel?
    var pokedex: [PokemonResults] = []
    
    
    //MARK: - FUNCTIONS
    func fetchPokedex() {
        NetworkingController.fetchPokedex(with: Constants.Pokemon.fetchPokedexURL) { [weak self] result in
            switch result {
            case .success(let topLevel):
                self?.topLevel = topLevel
                self?.pokedex  = topLevel.results
                self?.reloadTableViewOnMainThread()
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
    
    
    func reloadTableViewOnMainThread() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedex.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }

        let pokemon = pokedex[indexPath.row]
        cell.updateUI(forPokemon: pokemon)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let topLevel = topLevel else { return }
        
        if indexPath.row == pokedex.count - 1 {
            NetworkingController.fetchPokedex(with: topLevel.next) { [weak self] result in
                switch result {
                case .success(let topLevel):
                    self?.topLevel = topLevel
                    self?.pokedex.append(contentsOf: topLevel.results)
                    self?.reloadTableViewOnMainThread()
                    
                case .failure(let error):
                    print(error.errorDescription ?? Constants.Error.unknownError)
                }
            }
        }
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPokemonDetailVC" {
            if let index = tableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? PokemonDetailVC {
                    let pokemonToSend = pokedex[index.row]
                    NetworkingController.fetchPokemon(with: pokemonToSend.url) { result in
                        switch result {
                        case .success(let pokemon):
                            DispatchQueue.main.async {
                                destinationVC.pokemon = pokemon
                            }
                            
                        case .failure(let error):
                            print(error.errorDescription ?? Constants.Error.unknownError)
                        }
                    }
                }
            }
        }
    }
} //: CLASS

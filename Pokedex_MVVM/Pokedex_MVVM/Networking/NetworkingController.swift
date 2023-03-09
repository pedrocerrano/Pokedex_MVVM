//
//  NetworkingController.swift
//  Pokedex_Codable
//
//  Created by iMac Pro on 2/28/23.
//

import UIKit

class NetworkingController {
    
    static func fetchPokedex(with url: String, completion: @escaping (Result<TopLevel, NetworkError>) -> Void) {
        guard let finalURL = URL(string: url) else { completion(.failure(.invalidURL)) ; return }
        print("fetchPokedex Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("fetchPokedex Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            do {
                let topLevel = try JSONDecoder().decode(TopLevel.self, from: data)
                completion(.success(topLevel))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchPokemon(with url: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let finalURL = URL(string: url) else { completion(.failure(.invalidURL)) ; return }
        print("fetchPokemon Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("fetchPokemon Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ;  return }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchSprite(for url: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let finalURL = URL(string: url) else { completion(.failure(.invalidURL)) ; return }
        print("fetchSprite Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("fetchSprite Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            guard let image = UIImage(data: data) else { completion(.failure(.unableToDecode)) ; return }
            completion(.success(image))
        }.resume()
    }
}

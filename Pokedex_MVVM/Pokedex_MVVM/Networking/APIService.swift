//
//  APIService.swift
//  Pokedex_Codable
//
//  Created by iMac Pro on 3/9/23.
//

import Foundation

struct APIService {
    
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch Response Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            completion(.success(data))
        }.resume()
    }
}

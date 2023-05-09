//
//  PokeApi.swift
//  PokeApi
//
//  Created by Parris Louis  on 9/5/23.
//

import Foundation

struct PokemonListResponse: Decodable {
    let results: [Pokemon]
}

enum PokeAPI {

    private static let baseURL = "https://pokeapi.co/api/v2"
    private static let decoder = JSONDecoder()

    static func fetchPokemonList(page: Int, completion: @escaping (Result<PokemonListResponse, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/pokemon?offset=\(page * 20)&limit=20")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "PokeAPI", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])))
                return
            }

            do {
                let response = try decoder.decode(PokemonListResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}


//
//  ViewModel.swift
//  PokeApi
//
//  Created by Parris Louis  on 9/5/23.
//

import Foundation
import UIKit

class PokemonListViewModel{
    
    var pokemonList = [Pokemon]()
    
    var isLoading = false
    var isDoneLoading = false
    var currentPage = 0
    
    weak var delegate: PokemonListDelegate?
    
    func fetchPokemonList() {
        guard !isLoading && !isDoneLoading else { return }
        
        isLoading = true
        PokeAPI.fetchPokemonList(page: currentPage + 1) { result in
            switch result {
            case .success(let response):
                self.pokemonList.append(contentsOf: response.results)
                self.isLoading = false
                self.isDoneLoading = response.results.isEmpty
                self.currentPage += 1
                self.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.reloadData()
            }
        }
    }
    
    func fetchMorePokemonIfNeeded(for indexes: [Int]) {
        guard !isLoading && !isDoneLoading else { return }
        
        let needToLoad = indexes.contains { $0 >= pokemonList.count - 10 }
        if needToLoad {
            fetchPokemonList()
        }
    }
    
    
}


 








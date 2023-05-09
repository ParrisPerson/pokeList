//
//  ViewController.swift
//  PokeApi
//
//  Created by Parris Louis  on 9/5/23.
//

import UIKit

protocol PokemonListDelegate: AnyObject {
    func reloadData()
}

class ViewController: UIViewController, PokemonListDelegate {
    
    let pokeTableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.register(PokemonViewCell.self, forCellReuseIdentifier: "pokeCell")
        v.tableFooterView = UIView(frame: .zero)
        v.separatorStyle = .none;
        v.rowHeight = 60

        return v
    }()
    
    let spinner: UIActivityIndicatorView = {
        let s = UIActivityIndicatorView()
        s.style = .medium
        s.hidesWhenStopped = true
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    var showLoading: UIView?
    
    let viewModel = PokemonListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pokeTableView)
        self.view.addSubview(spinner)
 
        pokeTableView.dataSource = self
        pokeTableView.delegate = self
        
        viewModel.delegate = self
        
        setupConstraints()
        
       
        
        viewModel.fetchPokemonList()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pokeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            pokeTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            pokeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            pokeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        ])
    }
    
   
    func reloadData() {
        DispatchQueue.main.async {
            if self.showLoading != nil {
                self.showLoading?.removeFromSuperview()
                self.showLoading = nil
            }
            self.pokeTableView.reloadData()
        }
    }
    
    // MARK: Private Methods
        private func loadMoreIfNeeded(for indexPath: IndexPath) {
            let lastSection = pokeTableView.numberOfSections - 1
            let lastRow = pokeTableView.numberOfRows(inSection: lastSection) - 1
            if indexPath.section == lastSection && indexPath.row == lastRow {
                if (showLoading == nil){
                    showLoading = LoadingView.showLoading(self)
                }
                viewModel.fetchPokemonList()
            }
        }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        cell.textLabel?.text = viewModel.pokemonList[indexPath.row].name.uppercased()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;//Choose your custom row height
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadMoreIfNeeded(for: pokeTableView.indexPathsForVisibleRows?.last ?? IndexPath(row: 0, section: 0))
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadMoreIfNeeded(for: pokeTableView.indexPathsForVisibleRows?.last ?? IndexPath(row: 0, section: 0))
    }
}



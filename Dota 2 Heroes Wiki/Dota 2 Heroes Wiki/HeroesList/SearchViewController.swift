//
//  SearchViewController.swift
//  Dota 2 Heroes Wiki
//
//  Created by Игорь Попов on 21.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let heroesNetworkManager = HeroesNetworkManager()
    var heroesList = [Heroes]()
    var heroes: Heroes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroesNetworkManager.getHeroesList(result: {[ weak self] in
            self?.heroesList = $0.localized_name
        })
        setupSearchBar()
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let hero = heroes[indexPath.row]
        cell.textLabel?.text = "test"
        cell.imageView?.image = #imageLiteral(resourceName: "search")
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

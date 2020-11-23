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
    var heroList = [Heroes]()
    var heroes: Heroes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroesNetworkManager.getHeroesList(result: { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
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
        return heroList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let hero = heroList[indexPath.row]
        cell.textLabel?.text = hero.localizedName
        cell.imageView?.downloaded(from: ApiSend.startUrl + heroes!.img)
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
}

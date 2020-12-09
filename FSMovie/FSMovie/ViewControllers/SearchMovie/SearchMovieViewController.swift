//
//  SearchMovieViewController.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//
import Foundation
import UIKit

class SearchMovieViewController: UITableViewController {
    
    var timer: Timer?
    var networkManager = NetworkManager()
    var movies = [Result]()
    
    private lazy var footerView = FooterView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewCell()
        setupSearchBar()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        243
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieCell.reuseId, for: indexPath) as? SearchMovieCell
        cell?.configCellInformation(movie: movies[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = DetailMovieViewController()
        selectedMovie.movieId = movies[indexPath.row].id
        navigationController?.pushViewController(selectedMovie, animated: true)
    }
    
    
    
    func setupTableViewCell() {
        tableView.tableFooterView = UIView()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "SearchMovieCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchMovieCell.reuseId)
        tableView.tableFooterView = footerView
        
    }
    
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.footerView.showLoader()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { (_) in
            self.networkManager.fetchMovieList(searchText: searchText) { [weak self] (searchResults) in
                DispatchQueue.main.async {
                    self?.movies = searchResults
                    self?.tableView.reloadData()
                }
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movies = []
        tableView.reloadData()
        footerView.hideLoader()
    }
    
}

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
    
    private var timer: Timer?
    private var networkManager = NetworkManager()
    private var movies = [Result]()
    
    private lazy var footerView = FooterView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewCell()
        setupSearchBar()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath) as? SearchMovieCell
        cell?.configCellInformation(movie: movies[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return movies.count > 0 ? 0 : 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMovie = DetailMovieViewController()
        selectedMovie.movieId = movies[indexPath.row].id
        navigationController?.pushViewController(selectedMovie, animated: true)
    }
    
    
    
    private func setupTableViewCell() {
        tableView.tableFooterView = UIView()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.registerCell(type: SearchMovieCell.self)
        tableView.tableFooterView = footerView
        
    }
    
    
    private func setupSearchBar() {
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
            searchBar.placeholder = searchText

        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
        if searchBar.placeholder == "" {
            movies = []
            footerView.hideLoader()
            tableView.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
        movies = []
        tableView.reloadData()
        footerView.hideLoader()
    }
}

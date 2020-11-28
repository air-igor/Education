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
    
    var networkManager = NetworkManager()
    var movies = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewCell()
        setupSearchBar()
        
        
    }
    
    func setupTableViewCell() {
        tableView.tableFooterView = UIView()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        let nib = UINib(nibName: "SearchMovieCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchMovieCell.reuseId)
    }
    
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        243
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieCell.reuseId, for: indexPath) as! SearchMovieCell
        let movie = movies[indexPath.row]
        cell.movieInfo.text = movie.overview
        let imgUrl = "https://image.tmdb.org/t/p/w500" + "\(movie.posterPath ?? "")"
        cell.posterImg.downloaded(from: imgUrl)
        cell.voteRank.text = "\(movie.voteAverage)"
        cell.nameMovie.text = movie.title
        cell.releaseDate.setCorrectlyDate(movie)
        cell.voteView.backgroundColor = colorForVote().calculaeteColorVote(movie.voteAverage)
        return cell
    }
    
    
    
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkManager.fetchMovieList(searchText: searchText) { [weak self] (searchResults) in
            DispatchQueue.main.async {
                self?.movies = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        }
    }
    
}

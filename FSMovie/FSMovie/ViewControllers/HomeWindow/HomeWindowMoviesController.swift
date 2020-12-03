//
//  HomeWindowMovies.swift
//  FSMovie
//
//  Created by Игорь Попов on 02.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit


class HomeWindowMoviesController: UITableViewController {
    
    private lazy var footerView = FooterView()
    private var networkManager = NetworkManager()
    private var movies = [Result]()
    
    private var reloadInfo = UIRefreshControl()
    private var segmentedControl: UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewCell()
        getMoviesList()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        243
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieCell.reuseId, for: indexPath) as! SearchMovieCell
        cell.configViewCell(movie: movies[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailMovieViewController()
        detailVC.movieId = movies[indexPath.row].id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func setupTableViewCell() {
        tableView.tableFooterView = UIView()
        view.backgroundColor = .white
        tableView.separatorStyle = .none
        let nib = UINib(nibName: "SearchMovieCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchMovieCell.reuseId)
        tableView.tableFooterView = footerView
        
        let querys = ["Popular", "Upcoming", "Top Rated", "Now Playing"]
        segmentedControl = UISegmentedControl(items: querys)
        segmentedControl?.selectedSegmentIndex = 0
        tableView.tableHeaderView = segmentedControl
        segmentedControl?.addTarget(self, action: #selector(HomeWindowMoviesController.indexIsChanged(_:)), for: .valueChanged)
        
        tableView.refreshControl = reloadInfo
        reloadInfo.addTarget(self, action: #selector(getMoviesList), for: .valueChanged)
        
    }
    
    @objc func indexIsChanged(_ sender: UISegmentedControl) {
        let segmentedIndex = segmentedControl?.selectedSegmentIndex
        switch segmentedIndex {
        case 0:
            self.footerView.showLoader()
            movies = []
            tableView.reloadData()
            networkManager.homeList = .popular
            getMoviesList()
        case 1:
            self.footerView.showLoader()
            movies = []
            tableView.reloadData()
            networkManager.homeList = .upcoming
            getMoviesList()
        case 2:
            self.footerView.showLoader()
            movies = []
            tableView.reloadData()
            networkManager.homeList = .topRated
            getMoviesList()
        case 3:
            self.footerView.showLoader()
            movies = []
            tableView.reloadData()
            networkManager.homeList = .nowPlaying
            getMoviesList()
        default:
            break
        }
        
        
    }
    
    @objc func getMoviesList() {
        networkManager.getHomeMovies { [weak self] (homeResults) in
            guard let homeMovies = homeResults else { return }
            self?.movies = homeMovies
            self?.tableView.reloadData()
            self?.footerView.hideLoader()
            self?.reloadInfo.endRefreshing()
        }
    }
    
    
}

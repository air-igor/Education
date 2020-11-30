//
//  DetailMovieViewController.swift
//  FSMovie
//
//  Created by Игорь Попов on 29.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    var movieId: Int?
    let networkManager = NetworkManager()
    var detailMovie: DetailMovie?
    
    private let favoriteButton = UIButton(type: .custom)
    @IBOutlet weak var movieAvatar: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var voteLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var taglineLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var runtimeLbl: UILabel!
    @IBOutlet weak var voteView: UIView!
    @IBOutlet weak var aboutDate: UILabel!
    @IBOutlet weak var aboutBudget: UILabel!
    @IBOutlet weak var aboutRevenue: UILabel!
    @IBOutlet weak var aboutLanguage: UILabel!
    @IBOutlet weak var releaseView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingDetailInfo()
    }
    
    func gettingDetailInfo() {
        guard let movieId = movieId else { return }
        networkManager.fetchDetailMovie(movieId: movieId) { [weak self] (results) in
            self?.detailMovie = results
            print(results)
            self?.updateInterface()
        }
    }
    
    func updateInterface() {
        let mainUrl = "https://image.tmdb.org/t/p/original" + "\(detailMovie?.backdropPath ?? "")"
        movieAvatar.downloaded(from: mainUrl)
        titleLbl.text = detailMovie?.title
        voteLbl.textColor = UIColor.voteColor(vote: detailMovie?.voteAverage ?? 0.0)
        voteLbl.text = "\(detailMovie?.voteAverage ?? 0.0)"
        guard let detailsMovie = detailMovie else { return }
        releaseDateLbl.setCorrectlyDate(detailsMovie)
        aboutDate.setCorrectlyDate(detailsMovie)
        aboutLanguage.text = detailsMovie.originalLanguage
        
        if detailsMovie.revenue == 0 {
            self.aboutRevenue.text = "Information on the revenue is unknown"
        } else {
            aboutRevenue.text = "\(detailsMovie.revenue ?? 0)$"
        }
        
        if detailsMovie.budget == 0 {
            self.aboutBudget.text = "Information on the budget is unknown"
        } else {
            aboutBudget.text = "\(detailsMovie.budget ?? 0)$"
        }
        
        if detailsMovie.overview == "" {
            self.overviewLbl.text = "The movie description is missing"
        } else {
            overviewLbl.text = detailMovie?.overview
        }
        
        if detailsMovie.runtime == 0 {
            self.runtimeLbl.text = "Run time movie is unknown"
        } else if detailsMovie.runtime != 0 {
            runtimeLbl.text = "\(detailMovie?.runtime ?? 0) minuts"
        }
        configView()
    }
    
    func configView() {
        releaseView.layer.cornerRadius = 8
        releaseView.clipsToBounds = true
        voteView.layer.cornerRadius = 8
        movieAvatar.clipsToBounds = true
        movieAvatar.layer.cornerRadius = 10
        let buttonBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = buttonBarButtonItem
        favoriteButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(saveMovieTap), for: .touchUpInside)
    }
    
    @objc func saveMovieTap() {
        
    }
}


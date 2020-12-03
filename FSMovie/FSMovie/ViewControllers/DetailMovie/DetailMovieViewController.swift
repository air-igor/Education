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
    let movieStorage = MovieStorageService()
    private var cast = [Cast]()
    private var crew = [Crew]()
    private let networkManager = NetworkManager()
    private let repository = MovieRepositoryService()
    var detailMovie: DetailMovieEntity?
    
    private let fActivityIndicator = UIActivityIndicatorView(style: .gray)
    private var isFavorite = false
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
    @IBOutlet weak var fullImage: UIImageView!
    @IBOutlet weak var shadowPoster: UIView!
    @IBOutlet weak var shadowMovieAvatar: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var crewCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        gettingDetailInfo()
        configureCollectionView()
        getCastAndCrewCredits()
        
        
    }
    
    private func configureCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        let nib = UINib(nibName: "CastCell", bundle: nil)
        castCollectionView.register(nib, forCellWithReuseIdentifier: CastCell.reuseId)
        crewCollectionView.delegate = self
        crewCollectionView.dataSource = self
        crewCollectionView.register(nib, forCellWithReuseIdentifier: CastCell.reuseId)
        
    }
    
    func gettingDetailInfo() {
        guard let movieId = movieId else { return }
        
        repository.getDetail(by: movieId, onCompletion: { [weak self] results in
            self?.detailMovie = results
            self?.updateInterface()
            }, onError: { [weak self] stringError in
                print(Error.self)
        })
        
    }
    
    func updateInterface() {
        let movieUrl = ApiKeys.imageStartUrl + "\(detailMovie?.backdropPath ?? "")"
        let posterUrl = ApiKeys.imageStartUrl + "\(detailMovie?.posterPath ?? "")"
        movieAvatar.downloaded(from: movieUrl)
        posterImage.downloaded(from: posterUrl)
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
        let barButtonItem = UIBarButtonItem(customView: fActivityIndicator)
        navigationItem.rightBarButtonItem = barButtonItem
        fActivityIndicator.startAnimating()
        
    }
    
    func getCastAndCrewCredits() {
        guard let movieId = movieId else { return }
        networkManager.fetchCastAndCrew(movieId: movieId) { [weak self] (CastResults, CrewResults) in
            self?.cast = CastResults
            self?.crew = CrewResults
            self?.castCollectionView.reloadData()
            self?.crewCollectionView.reloadData()
        }
    }
    
}

private extension DetailMovieViewController {
    
    func configureAppearance() {
        configureNavigationBar()
        configureReleaseView()
        voteView.layer.cornerRadius = 8
        shadowMovieAvatar.clipsToBounds = true
        shadowMovieAvatar.layer.cornerRadius = 10
        favoriteButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(saveMovieTap), for: .touchUpInside)
        shadowPoster.addShadow()
        shadowMovieAvatar.addShadow()
    }
    
    func configureNavigationBar() {
        let buttonBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = buttonBarButtonItem
    }
    
    func configureReleaseView() {
        releaseView.layer.cornerRadius = 8
        releaseView.clipsToBounds = true
    }
    
}

extension DetailMovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension DetailMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView {
            return cast.count
        } else if collectionView == crewCollectionView {
            return crew.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == castCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.reuseId, for: indexPath) as! CastCell
            let castCredits = cast[indexPath.row]
            cell.personName.text = castCredits.name
            let imgUrl = ApiKeys.startImgUrl + "\(castCredits.profilePath ?? "")"
            
            return cell
            
        } else if collectionView == crewCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.reuseId, for: indexPath) as! CastCell
            let crewCredits = crew[indexPath.row]
            cell.personName.text = crewCredits.name
            let imgUrl = ApiKeys.startImgUrl + "\(crewCredits.profilePath ?? "")"
            cell.personImage.downloaded(from: imgUrl)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
}

//
//  DetailMovieViewController.swift
//  FSMovie
//
//  Created by Игорь Попов on 29.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import AVKit

class DetailMovieViewController: UIViewController {
    
    var movieId: Int?
    private let movieStorage = MovieStorageService()
    private var cast = [Cast]()
    private var crew = [Crew]()
    private let networkManager = NetworkManager()
    private let repository = MovieRepositoryService()
    private var detailMovie: DetailMovieEntity?
    private var videos = [VideoResult]()
    
    private let fActivityIndicator = UIActivityIndicatorView()
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
    @IBOutlet weak var shadowAboutView: UIView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        gettingDetailInfo()
        configureCollectionView()
        
    }
    
    private func configureCollectionView() {
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        let videoNib = UINib(nibName: "VideoCell", bundle: nil)
        videoCollectionView.register(videoNib, forCellWithReuseIdentifier: VideoCell.reuseId)
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        let nib = UINib(nibName: "PersonCell", bundle: nil)
        castCollectionView.register(nib, forCellWithReuseIdentifier: PersonCell.reuseId)
        crewCollectionView.delegate = self
        crewCollectionView.dataSource = self
        crewCollectionView.register(nib, forCellWithReuseIdentifier: PersonCell.reuseId)
        
    }
    
    func gettingDetailInfo() {
        guard let movieId = movieId else { return }
        
        repository.getDetail(by: movieId, onCompletion: { [weak self] results in
            self?.detailMovie = results
            self?.updateInterface()
            }, onError: { [weak self] stringError in
                print(Error.self)
        })
        
        networkManager.fetchVideos(movieId: movieId) { [weak self] videoResult in
            self?.videos = videoResult
            self?.videoCollectionView.reloadData()
        }
        
        networkManager.fetchCastAndCrew(movieId: movieId) { [weak self] (CastResults, CrewResults) in
            self?.cast = CastResults
            self?.crew = CrewResults
            self?.castCollectionView.reloadData()
            self?.crewCollectionView.reloadData()
        }
        
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
        configImageAndView()
    }
    
    
    func configImageAndView() {
        
        releaseView.layer.cornerRadius = 8
        releaseView.clipsToBounds = true
        voteView.layer.cornerRadius = 8
        movieAvatar.clipsToBounds = true
        movieAvatar.layer.cornerRadius = 10
        shadowAboutView.addShadow()
        let buttonBarButtonItem = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = buttonBarButtonItem
    }
    
    
    @objc func saveMovieTap() {
        let barButtonItem = UIBarButtonItem(customView: fActivityIndicator)
        navigationItem.rightBarButtonItem = barButtonItem
        fActivityIndicator.startAnimating()
        
    }
    
}

private extension DetailMovieViewController {
    
    func configureAppearance() {
        configureNavigationBar()
        configureReleaseView()
        voteView.layer.cornerRadius = 8
        shadowMovieAvatar.clipsToBounds = true
        shadowMovieAvatar.layer.cornerRadius = 10
        favoriteButton.setImage(#imageLiteral(resourceName: "addInFavorites"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(saveMovieTap), for: .touchUpInside)
        let tappedImaged = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        posterImage.addGestureRecognizer(tappedImaged)
        posterImage.isUserInteractionEnabled = true
        
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
    
    @objc func tapImage() {
        let fullPictureVC = FullPictureViewController()
        fullPictureVC.fullPicture = detailMovie?.posterPath ?? ""
        navigationController?.pushViewController(fullPictureVC, animated: true)
        
    }
    
}


extension DetailMovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == castCollectionView {
            return cast.count
        } else if collectionView == crewCollectionView {
            return crew.count
        } else if collectionView == videoCollectionView {
            return videos.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == castCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reuseId, for: indexPath) as! PersonCell
            let castCredits = cast[indexPath.row]
            cell.personName.text = castCredits.name
            let imgUrl = ApiKeys.startImgUrl + "\(castCredits.profilePath ?? "")"
            
            if castCredits.profilePath == nil {
                cell.personImage.image = #imageLiteral(resourceName: "noAvatar")
            } else {
                cell.personImage.downloaded(from: imgUrl)
            }
            cell.characterLbl.text = castCredits.character
            
            
            return cell
            
        } else if collectionView == crewCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reuseId, for: indexPath) as! PersonCell
            let crewCredits = crew[indexPath.row]
            cell.personName.text = crewCredits.name
            let imgUrl = ApiKeys.startImgUrl + "\(crewCredits.profilePath ?? "")"
            cell.characterLbl.text = crewCredits.job
            
            if crewCredits.profilePath == nil {
                cell.personImage.image = #imageLiteral(resourceName: "noAvatar")
            } else {
                cell.personImage.downloaded(from: imgUrl)
            }
            
            return cell
            
        } else if collectionView == videoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.reuseId, for: indexPath) as! VideoCell
            let videoCredits = videos[indexPath.row]
            cell.titleLbl.text = videoCredits.name
            let mainUrl = "https://img.youtube.com/vi/\(videoCredits.key ?? "")/0.jpg"
            cell.imageTrailer.downloaded(from: mainUrl)
    
                return cell
                
            } else {
                
                return UICollectionViewCell()
            }
            
        }
        
    }
    
    extension DetailMovieViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        // MARK: СДЕЛАТЬ МЕТОД ПЕРЕДАЧИ ССЫЛКИ ВИДЕО И ЗАПУСК ЕГО
            if collectionView == castCollectionView {
                let personDetailVC = PersonDetailViewController()
                personDetailVC.personId = cast[indexPath.row].id
                navigationController?.pushViewController(personDetailVC, animated: true)
            } else if collectionView == crewCollectionView {
                let personDetailVC = PersonDetailViewController()
                personDetailVC.personId = crew[indexPath.row].id
                navigationController?.pushViewController(personDetailVC, animated: true)
            } else if collectionView == videoCollectionView {
                networkManager.fetchYoutubeTrailer(key: videos[indexPath.row].key) { [weak self] (videoUrl) in
                    
                    let player = AVPlayer(url: videoUrl)
                    let avVC = AVPlayerViewController()
                    avVC.player = player
                    self?.present(avVC, animated: true) {
                        avVC.player?.play()
                    }
                    
                }
            }
        }
        
    }
    
    extension DetailMovieViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == castCollectionView {
                return PersonCell.sizeCell
            } else if collectionView == crewCollectionView {
                return PersonCell.sizeCell
            } else if collectionView == videoCollectionView {
                return VideoCell.sizeCell
            } else {
                return CGSize(width: 0, height: 0)
            }
        }
}

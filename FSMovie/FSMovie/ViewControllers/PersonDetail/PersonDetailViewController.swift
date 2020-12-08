//
//  PersonDetailViewController.swift
//  FSMovie
//
//  Created by Игорь Попов on 04.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//
import UIKit

class PersonDetailViewController: UIViewController {
    
    
    var networkManager = NetworkManager()
    var personId: Int?
    var personInfo: Person?
    var personImages = [Profile]()
    var personCastMovies = [PersonCastMovies]()
    
    @IBOutlet weak var personAvatar: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var biographyLbl: UILabel!
    @IBOutlet weak var shadowAbout: UIView!
    @IBOutlet weak var personImageCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPerson()
        
    }
    
    private func getPerson() {
        guard let personId = personId else { return }
        networkManager.fetchPerson(personId: personId) { [weak self] (result) in
            self?.personInfo = result
            self?.updateInterface()
        }
        networkManager.fetchPersonImages(personId: personId) { [weak self] (imagesResult) in
            self?.personImages = imagesResult
            self?.personImageCollectionView.reloadData()
            self?.setupCollectionAndTableCell()
        }
        networkManager.fetchPersonMovies(personId: personId) { [weak self] (castMoviesResult) in
            self?.personCastMovies = castMoviesResult
            self?.tableView.reloadData()
            
        }
    }
    
    private func setupCollectionAndTableCell() {
        personImageCollectionView.delegate = self
        personImageCollectionView.dataSource = self
        let collectionNib = UINib(nibName: "PersonImagesCell", bundle: nil)
        personImageCollectionView.register(collectionNib, forCellWithReuseIdentifier: PersonImagesCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        let tableNib = UINib(nibName: "PersonMoviesCell", bundle: nil)
        tableView.register(tableNib, forCellReuseIdentifier: PersonMoviesCell.reuseId)
        
    }
    
    private func updateInterface() {
        shadowAbout.addShadowPerson()
        shadowAbout.layer.cornerRadius = 10
        let posterUrl = ApiKeys.imageStartUrl + "\(personInfo?.profilePath ?? "")"
        personAvatar.clipsToBounds = true
        personAvatar.layer.cornerRadius = 10
        personAvatar.downloaded(from: posterUrl)
        nameLbl.text = personInfo?.name
        biographyLbl.text = personInfo?.biography
        
        if personInfo?.profilePath == nil {
            personAvatar.image = #imageLiteral(resourceName: "personNoAvatar")
        } else {
            personAvatar.downloaded(from: posterUrl)
        }
        
        if personInfo?.birthday == nil {
            birthdayLbl.text = ""
        } else {
            birthdayLbl.setCorrectlyDate(personInfo!)
        }
        
        if personInfo?.placeOfBirth == nil {
            fromLbl.text = ""
        } else {
            fromLbl.text = personInfo?.placeOfBirth
            
        }
        
        let tappedImaged = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        personAvatar.addGestureRecognizer(tappedImaged)
        personAvatar.isUserInteractionEnabled = true
    }
    
    @objc func tapImage() {
        let fullPictureVC = FullPictureViewController()
        fullPictureVC.fullPicture = personInfo?.profilePath ?? ""
        navigationController?.pushViewController(fullPictureVC, animated: true)
    }
    
}

extension PersonDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personCastMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonMoviesCell.reuseId, for: indexPath) as! PersonMoviesCell
        let person = personCastMovies[indexPath.row]
        cell.movieName.text = person.title
        let mainImageUrl = ApiKeys.imageStartUrl + "\(person.posterPath ?? "")"
        cell.movieImage.downloaded(from: mainImageUrl)
        cell.voteLbl.textColor = UIColor.voteColor(vote: person.voteAverage ?? 0.0)
        cell.voteLbl.text = "\(person.voteAverage ?? 0.0)"
        
        if person.releaseDate == nil {
            cell.movieRealeseDate.text = ""
        } else {
            cell.movieRealeseDate.setCorrectlyDate(person)
        }
        
        return cell
    }
    
}

extension PersonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = DetailMovieViewController()
        selectedMovie.movieId = personCastMovies[indexPath.row].id
        navigationController?.pushViewController(selectedMovie, animated: true)
    }
    
   }


extension PersonDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == personImageCollectionView {
            return personImages.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == personImageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonImagesCell.reuseId, for: indexPath) as! PersonImagesCell
            let persImg = personImages[indexPath.row]
            let urlString = ApiKeys.imageStartUrl + "\(persImg.filePath ?? "")"
            cell.personProfilePath.downloaded(from: urlString)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}

extension PersonDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == personImageCollectionView {
            let fullImageVC = FullPictureViewController()
            fullImageVC.fullPicture = personImages[indexPath.row].filePath ?? ""
            navigationController?.pushViewController(fullImageVC, animated: true)
        }
    }
    
}


extension PersonDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == personImageCollectionView {
            return PersonImagesCell.sizeCell
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}


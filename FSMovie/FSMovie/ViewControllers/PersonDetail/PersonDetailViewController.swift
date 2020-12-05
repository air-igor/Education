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
    
    
    @IBOutlet weak var personAvatar: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var biographyLbl: UILabel!
    @IBOutlet weak var shadowAbout: UIView!
    @IBOutlet weak var deathLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPerson()
        
    }
    
    func getPerson() {
        guard let personId = personId else { return }
        networkManager.fetchPerson(personId: personId) { [weak self] (result) in
            self?.personInfo = result
            self?.updateInterface()
        }
    }
    
    func updateInterface() {
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

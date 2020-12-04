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
    
    @IBOutlet weak private var shadowPerson: UIView!
    @IBOutlet weak var personAvatar: UIImageView!
    
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
        shadowPerson.addShadow()
        let posterUrl = ApiKeys.imageStartUrl + "\(personInfo?.profilePath ?? "")"
        personAvatar.downloaded(from: posterUrl)
    }
    
}

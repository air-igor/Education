//
//  PersonCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 03.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    static let reuseId = "PersonCell"
    static let sizeCell = CGSize(width: 143, height: 78)
    
    @IBOutlet weak private var personImage: UIImageView!
    @IBOutlet weak private var personName: UILabel!
    @IBOutlet weak private var shadowView: UIView!
    @IBOutlet weak private var characterLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
        
    }
    
    
    private func configView() {
        personImage.clipsToBounds = false
        shadowView.addShadowCast()
        shadowView.clipsToBounds = false
    }
    
    func configCrewCell(crewCredits: Crew) {
        personName.text = crewCredits.name
        let imgUrl = ApiKeys.startImgUrl + "\(crewCredits.profilePath ?? "")"
        characterLbl.text = crewCredits.job
        
        if crewCredits.profilePath == nil {
            personImage.image = #imageLiteral(resourceName: "noAvatar")
        } else {
            personImage.downloaded(from: imgUrl)
        }
        
    }
    
    func configCastCell(castCredits: Cast) {
        personName.text = castCredits.name
        let imgUrl = ApiKeys.startImgUrl + "\(castCredits.profilePath ?? "")"
        
        if castCredits.profilePath == nil {
            personImage.image = #imageLiteral(resourceName: "noAvatar")
        } else {
            personImage.downloaded(from: imgUrl)
        }
        characterLbl.text = castCredits.character
    }
    
}

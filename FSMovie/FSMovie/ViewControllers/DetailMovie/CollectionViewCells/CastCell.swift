//
//  PersonCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 03.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class CastCell: UICollectionViewCell {

    static let reuseId = "CastCell"

    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configViewCell()
        
    }

    
     func configCollectionCell(cast: Cast) {
        personName.text = cast.name
        let imgUrl = ApiKeys.startImgUrl + "\(cast.profilePath ?? "")"
    }
    
    func configViewCell() {
        personImage.clipsToBounds = false
        shadowView.addShadowCast()
        shadowView.clipsToBounds = false
    }
    
}

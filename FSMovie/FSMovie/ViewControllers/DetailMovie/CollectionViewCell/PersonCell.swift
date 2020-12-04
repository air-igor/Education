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
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var characterLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configViewCell()
        
    }

    
    func configViewCell() {
        personImage.clipsToBounds = false
        shadowView.addShadowCast()
        shadowView.clipsToBounds = false
    }
    
}

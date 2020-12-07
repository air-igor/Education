//
//  PersonImagesCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 07.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class PersonImagesCell: UICollectionViewCell {
    
    static let reuseId = "PersonImagesCell"
    static let sizeCell = CGSize(width: 60, height: 80)

    @IBOutlet weak var personProfilePath: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPersonImage()

    }
    
    func setupPersonImage() {
        personProfilePath.clipsToBounds = true
        personProfilePath.layer.cornerRadius = 4
    }

}

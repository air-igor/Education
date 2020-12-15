//
//  PersonImagesCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 07.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class PersonImagesCell: UICollectionViewCell {
    
    static let sizeCell = CGSize(width: 60, height: 80)
    
    @IBOutlet weak private var personProfilePath: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPersonImage()
        
    }
    
    private func setupPersonImage() {
        personProfilePath.clipsToBounds = true
        personProfilePath.layer.cornerRadius = 4
    }
    
    func configPersImgCell(persImg: Profile) {
        let urlString = ApiKeys.imageStartUrl + "\(persImg.filePath ?? "")"
        personProfilePath.downloaded(from: urlString)
    }
    
}

//
//  VideoCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 06.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    static let reuseId = "VideoCell"
    static let sizeCell = CGSize(width: 165, height: 119)

    

    @IBOutlet weak var imageTrailer: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionCell()
    }
    
    func configCollectionCell() {
        imageTrailer.layer.cornerRadius = 4
    }

}

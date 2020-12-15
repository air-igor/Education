//
//  VideoCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 06.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    static let sizeCell = CGSize(width: 165, height: 119)
    
    
    
    @IBOutlet weak private var imageTrailer: UIImageView!
    @IBOutlet weak private var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        imageTrailer.layer.cornerRadius = 4
    }
    
    func configVideoCell(videoCredits: VideoResult) {
        titleLbl.text = videoCredits.name
        let mainUrl = "https://img.youtube.com/vi/\(videoCredits.key ?? "")/0.jpg"
        imageTrailer.downloaded(from: mainUrl)
    }
    
}

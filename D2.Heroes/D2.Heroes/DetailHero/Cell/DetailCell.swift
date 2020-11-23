//
//  DetailCell.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 21.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import SDWebImage

class DetailCell: UITableViewCell {
    
    static let reuseId = "DetailCell"
    
    @IBOutlet weak var heroImg: UIImageView!
    @IBOutlet weak var healthLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var manaLbl: UILabel!
    @IBOutlet weak var moveSpeedLbl: UILabel!
    @IBOutlet weak var strLbl: UILabel!
    @IBOutlet weak var agiLbl: UILabel!
    @IBOutlet weak var intLbl: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBounds()
    }
    
    private func imageBounds() {
        heroImg.clipsToBounds = true
        heroImg.layer.cornerRadius = heroImg.frame.height / 2
        heroImg.contentMode = .scaleAspectFill
        heroImg.layer.shadowColor = UIColor.black.cgColor
        heroImg.layer.cornerRadius = 10
    }
    
}

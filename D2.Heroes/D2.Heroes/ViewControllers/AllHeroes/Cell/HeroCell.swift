//
//  HeroCell.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 19.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import SDWebImage

class HeroCell: UITableViewCell {
    
    
    static let reuseId = "HeroCell"
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var attackType: UILabel!
    @IBOutlet weak var attributeType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBounds()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heroImageView.image = nil
    }
    
   private func imageBounds() {
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = heroImageView.frame.height / 2
        heroImageView.contentMode = .scaleAspectFill
    }
    
    
    @IBAction func addHeroAction(_ sender: Any) {
        
    }
    
}

//
//  CustomTableViewCell.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 02.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCocktail: UIImageView!
    @IBOutlet weak var nameCocktail: UILabel!
    
    static let indetifier = "CustomTableViewCell"
    var coctail: Drinks?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBounds()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func imageBounds() {
        imageCocktail.clipsToBounds = true
        imageCocktail.layer.cornerRadius = imageCocktail.frame.height / 2
        imageCocktail.contentMode = .scaleAspectFill
    }
    
    
}

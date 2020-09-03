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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

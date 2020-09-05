//
//  CustomTableViewCellTwo.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 03.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class CustomTableViewCellTwo: UITableViewCell {
    @IBOutlet weak var ingredientsLbl: UILabel!
    
    static let indetifier = "CustomTableViewCellTwo"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



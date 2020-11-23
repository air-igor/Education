//
//  HeroesModel.swift
//  Dota 2 Heroes Wiki
//
//  Created by Игорь Попов on 21.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


struct Heroes: Codable {
    let localizedName: String
    let img: String
    
    enum CodingKeys: String, CodingKey {
        case localizedName = "localized_name"
        case img
    }
}

//
//  HeroesDataManager.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 19.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation
import RealmSwift

struct HeroesDataManager: Codable {
    var localizedName: String
    var img: String
    var attackType: String
    var primaryAttr: String
    var baseHealth: Int
    var baseMana: Int
    var moveSpeed: Int
    var baseStr: Int
    var baseAgi: Int
    var baseInt: Int
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case localizedName = "localized_name"
        case img, icon
        case attackType = "attack_type"
        case primaryAttr = "primary_attr"
        case baseHealth = "base_health"
        case baseMana = "base_mana"
        case moveSpeed = "move_speed"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
    }
}

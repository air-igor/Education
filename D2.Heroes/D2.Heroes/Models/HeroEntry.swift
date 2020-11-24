//
//  HeroEntry.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 23.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//


import RealmSwift


@objcMembers class HeroEntry: Object, Codable {
    dynamic var localizedName: String?
    dynamic var img: String?
    dynamic var attackType: String?
    dynamic var primaryAttr: String?
    dynamic var baseHealth = 0
    dynamic var baseMana = 0
    dynamic var moveSpeed = 0
    dynamic var baseStr = 0
    dynamic var baseAgi = 0
    dynamic var baseInt = 0
    dynamic var icon: String?
    
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
    
    convenience init(localizedName: String?, img: String?, attackType: String?, primaryAttr: String?, baseHealth: Int, baseMana: Int, moveSpeed: Int, baseStr: Int, baseAgi: Int, baseInt: Int, icon: String?) {
        self.init()
        self.localizedName = localizedName
        self.img = img
        self.attackType = attackType
        self.primaryAttr = primaryAttr
        self.baseHealth = baseHealth
        self.baseMana = baseMana
        self.moveSpeed = moveSpeed
        self.baseStr = baseStr
        self.baseAgi = baseAgi
        self.baseInt = baseInt
        self.icon = icon
        
    }
}

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
    dynamic var baseHealth: Int?
    dynamic var baseMana: Int?
    dynamic var moveSpeed: Int?
    dynamic var baseStr: Int?
    dynamic var baseAgi: Int?
    dynamic var baseInt: Int?
    dynamic var icon: String?
    
    convenience init(localizedName: String?, img: String?, attackType: String?, primaryAttr: String?, baseHealth: Int?, baseMana: Int?, moveSpeed: Int?, baseStr: Int?, baseAgi: Int?, baseInt: Int?, icon: String?) {
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

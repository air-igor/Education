//
//  HeroEntry.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 23.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import RealmSwift


@objcMembers class HeroEntry: Object, Codable {
    dynamic var id = UUID().uuidString
    dynamic var localizedName = ""
    dynamic var img = ""
    dynamic var attackType = ""
    dynamic var primaryAttr = ""
    dynamic var baseHealth: Int = 0
    dynamic var baseMana: Int = 0
    dynamic var moveSpeed: Int = 0
    dynamic var baseStr: Int = 0
    dynamic var baseAgi: Int = 0
    dynamic var baseInt: Int = 0
    dynamic var icon = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toEntity() -> HeroesDataManager {
        return HeroesDataManager(localizedName: localizedName,
                                 img: img,
                                 attackType: attackType,
                                 primaryAttr: primaryAttr,
                                 baseHealth: baseHealth,
                                 baseMana: baseMana,
                                 moveSpeed: moveSpeed,
                                 baseStr: baseStr,
                                 baseAgi: baseAgi,
                                 baseInt: baseInt,
                                 icon: icon)
    }
    
    func commonInit(localizedName: String, img: String, attackType: String, primaryAttr: String, baseHealth: Int, baseMana: Int, moveSpeed: Int, baseStr: Int, baseAgi: Int, baseInt: Int, icon: String) -> Object {
        let hero = HeroEntry()
        hero.id = id
        hero.img = img
        hero.attackType = attackType
        hero.primaryAttr = primaryAttr
        hero.baseHealth = baseHealth
        hero.baseMana = baseMana
        hero.moveSpeed = moveSpeed
        hero.baseStr = baseStr
        hero.baseAgi = baseAgi
        hero.baseInt = baseInt
        hero.icon = icon
        return hero
    }
}

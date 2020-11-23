//
//  HeroDabaseServiceRealm.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 23.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation
import RealmSwift

class HeroDatabaseServiceRealm: RootDatabaseServiceRealm {
    func getHeroFromDatabase(completion: @escaping ([HeroesDataManager]) -> Void) {
        let hero = realm.objects(HeroEntry.self)
        guard !hero.isEmpty else {
            print("Error")
            return
        }
        
        completion(fromEntryToEntity(entry: hero))
    }
    
    func fromEntryToEntity(entry: Results<HeroEntry>) -> [HeroesDataManager] {
        var heroEntity: [HeroesDataManager] = []
        entry.forEach { (heroEntry) in
            heroEntity.append(HeroesDataManager(localizedName: heroEntry.localizedName, img: heroEntry.img, attackType: heroEntry.attackType, primaryAttr: heroEntry.primaryAttr, baseHealth: heroEntry.baseHealth, baseMana: heroEntry.baseMana, moveSpeed: heroEntry.moveSpeed, baseStr: heroEntry.baseStr, baseAgi: heroEntry.baseAgi, baseInt: heroEntry.baseInt, icon: heroEntry.icon))
        }
        return heroEntity
    }
}

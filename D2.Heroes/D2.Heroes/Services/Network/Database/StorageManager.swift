//
//  StorageManager.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 23.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ array: [HeroEntry]) {
        try! realm.write {
            array.forEach({
                realm.add($0)
            })
        }
    }
    
    static func deleteObject(_ array: [HeroEntry]) {
        try! realm.write {
            array.forEach({
                realm.delete($0)
            })
        }
    }
}

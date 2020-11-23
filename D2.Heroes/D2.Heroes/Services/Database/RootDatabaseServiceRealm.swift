//
//  RootDatabaseServiceRealm.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 23.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation
import RealmSwift

class RootDatabaseServiceRealm {
    static let shared = RootDatabaseServiceRealm()
    
    let realm = try! Realm()
    
    func update<T: Object>(_ object: T) {
        try! realm.write {
            realm.add(object)
        }
    }
}

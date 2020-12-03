//
//  StorageService.swift
//  FSMovie
//
//  Created by Игорь Попов on 30.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation
import RealmSwift

class StorageService {
    
    var realm: Realm? {
        try? Realm()
    }
    
    func saveObject<T: Object>(object: T?) {
        try? realm?.write {
            guard let object = object else { return }
            realm?.add(object)
        }
    }
    
    func removeObjectId<T: Object>(object: T.Type, id: Int?) {
        guard let id = id else {
            return
        }
        guard let searchedObject = realm?.objects(object.self).filter("id == \(id)").first else { return }
        try? realm?.write {
            realm?.delete(searchedObject)
        }
    }
    
    func update<T: Object>(_ object: T) {
        do {
            try realm?.write {
                realm?.add(object, update: .all)
            }
        } catch {
            print("Eror create or update in store \(error)")
        }
    }

}

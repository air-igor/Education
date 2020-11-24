//
//  NetworkHeroesManager.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 19.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import Alamofire


class NetworkHeroesManager {
    let savedHeroes = realm.objects(HeroEntry.self)

    func getHeroesList(completion: @escaping ([HeroEntry]?) -> Void) {
        let url = ApiConstants.globalUrl
        
        AF.request(url).response { (dataResponse) in
            if let error = dataResponse.error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode([HeroEntry].self, from: data)
//                print(objects)
                if self.savedHeroes.count == 0 {
                    StorageManager.saveObject(objects)
                }
                completion(objects)
            } catch let jsonError {
                print(jsonError)
                completion(nil)
            }
            //            let someString = String(data: data, encoding: .utf8)
            //            print(someString ?? "")
        }
    }
}

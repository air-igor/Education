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
    let realm = HeroDatabaseServiceRealm.shared
    func getHeroesList(completion: @escaping ([HeroesDataManager]?) -> Void) {
        let url = "https://api.opendota.com/api/heroStats"
        
        AF.request(url).response { (dataResponse) in
            if let error = dataResponse.error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode([HeroesDataManager].self, from: data)
                print(objects)
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

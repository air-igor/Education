//
//  HeroesNetworkManager.swift
//  Dota 2 Heroes Wiki
//
//  Created by Игорь Попов on 22.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

struct HeroesNetworkManager {
    func getHeroesList(result: @escaping ((Heroes) -> Void)) {
        let urlString = ApiSend.startUrl + ApiSend.heroKey
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString ?? "")
                self.parseJSON(withData: data, result: result)
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data, result: @escaping ((Heroes) -> Void)) {
        let decoder = JSONDecoder()
        do {
            let getHeroesListData = try decoder.decode(Heroes.self, from: data)
            result(getHeroesListData)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}



//
//  CoctailNetworkManager.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 29.08.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

struct CoctailNetworkManager {
    func fetchCoctailList() {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let coctailListData = try decoder.decode(CoctailListData.self, from: data)
            print(coctailListData.drinks)
        } catch let error as NSError {
            print(error.localizedDescription)
    }
    
}
}

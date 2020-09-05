//
//  CoctailNetworkManager.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 29.08.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

struct CoctailNetworkManager {
    func fetchCoctailList(result: @escaping ((CoctailListData) -> Void)) {
        let urlString = ApiSend.startUrl + ApiSend.devlopmentKey + "/search.php?s=\(randomString(length: 1))"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                self.parseJSON(withData: data, result: result)
            }
        }
        task.resume()
    }
    
    
    func parseJSON(withData data: Data, result: @escaping ((CoctailListData) -> Void)) {
        let decoder = JSONDecoder()
        do {
            let coctailListData = try decoder.decode(CoctailListData.self, from: data)
            result(coctailListData)
        } catch let error as NSError {
            print(error.localizedDescription)
    }
    
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}


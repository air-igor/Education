//
//  NetworkService.swift
//  iSound
//
//  Created by Игорь Попов on 08.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService {
    func fetchTrack(searchText: String, complition: @escaping (SearchResponseList?) -> Void) {
        let url = "https://itunes.apple.com/search?term=\(searchText.replacingOccurrences(of: " ", with: "+"))&limit=15&media=music"
        
        AF.request(url).response { (dataResponse) in
            if let error = dataResponse.error {
                print(error.localizedDescription)
                complition(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponseList.self, from: data)
                print(objects)
                complition(objects)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
            //                let dataString = String(data: data, encoding: .utf8)
            //                print(dataString ?? "")
        }
    }
}

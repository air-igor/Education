//
//  NetworkManager.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


class NetworkManager {
    func fetchMovieList(searchText: String, completion: @escaping (MovieList?) -> Void) {
        let mainUrl = ApiKeys.startUrl + ApiKeys.movie + ApiKeys.globalKey + ApiKeys.paramUrl + "query=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
        
        guard let url = URL(string: mainUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil)
                print(error.localizedDescription)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(MovieList.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects)
                    }

                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}

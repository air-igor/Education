//
//  MovieStorageService.swift
//  FSMovie
//
//  Created by Игорь Попов on 30.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation
import RealmSwift

class MovieStorageService: StorageService {

    
    func getDetailEntry(by movieId: Int, onCompletion: @escaping (DetailMovieEntry) -> Void, onError: ((String) -> Void)? = nil) {
        let results = realm?.objects(DetailMovieEntry.self)
        guard let entry = results?.first(where: { $0.id == movieId }) else {
            onError?("error")
            return
        }

        onCompletion(entry)
    }
    
    func removeMovieId(id: Int?) {
        removeObjectId(object: MovieEntry.self, id: id)
    }
}

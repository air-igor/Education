//
//  MovieRepositoryService.swift
//  FSMovie
//
//  Created by Игорь Попов on 01.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation

enum RepositoryLoadingPolicy {
    case firstNetwork
    case firstStorage
}

final class MovieRepositoryService {
    
    typealias DetailCompletion = (DetailMovieEntity) -> Void
    typealias ErrorCompletion = (String) -> Void
    
    private let networkService = NetworkManager()
    private let movieStorage = MovieStorageService()
    
    private let policy: RepositoryLoadingPolicy
    
    init(policy: RepositoryLoadingPolicy = .firstNetwork) {
        self.policy = policy
    }
    
    func getDetail(by movieId: Int,
                   onCompletion: @escaping DetailCompletion,
                   onError: @escaping ErrorCompletion) {
        switch policy {
        case .firstNetwork:
            networkService.fetchDetailMovie(movieId: movieId,
                                            completion: { entity in
                                                // Подумать
//                                                movieStorage.update(entity)
                                                onCompletion(entity)
            }) { [weak self] error in
                self?.movieStorage.getDetailEntry(by: movieId, onCompletion: { entry in
                    onCompletion(entry.toEntity())
                }) { error in
                    onError(error)
                }
            }
        case .firstStorage:
            // СДЕЛАТЬ САМОМУ
            break
        }
    }

}

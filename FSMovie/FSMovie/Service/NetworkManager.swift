//
//  NetworkManager.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


private let movieStorageService = MovieStorageService()

class NetworkManager {
    var homeList: HomeMovieList = .popular
    
    func getHomeMovies(completion: @escaping ([Result]?) -> Void) {
        var mainHomeUrl: URL?
        switch homeList {
        case .popular:
            mainHomeUrl = URL(string: ApiKeys.startUrl + "/movie/popular" + ApiKeys.detailKey + ApiKeys.homeVideoEnd)
        case .upcoming:
            mainHomeUrl = URL(string: ApiKeys.startUrl + "/movie/upcoming" + ApiKeys.detailKey + ApiKeys.homeVideoEnd)
        case .topRated:
            mainHomeUrl = URL(string: ApiKeys.startUrl + "/movie/top_rated" + ApiKeys.detailKey + ApiKeys.homeVideoEnd)
        case .nowPlaying:
            mainHomeUrl = URL(string: ApiKeys.startUrl + "/movie/now_playing" + ApiKeys.detailKey + ApiKeys.homeVideoEnd)
        }
        
        guard let url = mainHomeUrl else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(MovieList.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects.results)
                        
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    
    
    
    func fetchMovieList(searchText: String, completion: @escaping ([Result]) -> Void) {
        
        
        let mainUrl = ApiKeys.startUrl + ApiKeys.movie + ApiKeys.globalKey + ApiKeys.paramUrl + "query=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
        
        guard let url = URL(string: mainUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(MovieList.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects.results)
                        
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func fetchDetailMovie(movieId: Int,
                          completion: @escaping (DetailMovieEntity) -> Void,
                          onError: @escaping (Error) -> Void) {
        let mainUrl = ApiKeys.startUrl + ApiKeys.detailMovie + "\(movieId)" + ApiKeys.detailKey + ApiKeys.paramUrl
        guard let url = URL(string: mainUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let objects = try decoder.decode(DetailMovieEntity.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects)
                    }
                    
                } catch let error as NSError {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
    
    func fetchCastAndCrew(movieId: Int, completion: @escaping ([Cast], [Crew]) -> Void) {
        let mainUrl = ApiKeys.startUrl + ApiKeys.detailMovie + "\(movieId)/" + ApiKeys.creditsAndKey
        guard let url = URL(string: mainUrl) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let objects = try decoder.decode(CastAndCrew.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects.cast, objects.crew)
                    }
                    
                } catch let error as NSError {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}

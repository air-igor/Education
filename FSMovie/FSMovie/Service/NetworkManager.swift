//
//  NetworkManager.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation
import XCDYouTubeKit

private let movieStorageService = MovieStorageService()

class NetworkManager {
    
    // MARK: Properties
    
    var homeList: HomeMovieList = .popular
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    // MARK: Methods
    
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
        dataTask = session.dataTask(with: url) { (data, response, error) in
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
        dataTask?.resume()
    }
    
    
    
    
    func fetchMovieList(searchText: String, completion: @escaping ([Result]) -> Void) {
        
        
        let mainUrl = ApiKeys.startUrl + ApiKeys.movie + ApiKeys.globalKey + ApiKeys.paramUrl + "query=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
        
        guard let url = URL(string: mainUrl) else { return }
        dataTask = session.dataTask(with: url) { (data, response, error) in
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
        dataTask?.resume()
    }
    
    func fetchDetailMovie(movieId: Int,
                          completion: @escaping (DetailMovieEntity) -> Void,
                          onError: @escaping (Error) -> Void) {
        let mainUrl = ApiKeys.startUrl + ApiKeys.detailMovie + "\(movieId)" + ApiKeys.detailKey + ApiKeys.paramUrl
        guard let url = URL(string: mainUrl) else { return }
        dataTask = session.dataTask(with: url) { (data, response, error) in
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
        dataTask?.resume()
    }
    
    func fetchCastAndCrew(movieId: Int, completion: @escaping ([Cast], [Crew]) -> Void) {
        let mainUrl = ApiKeys.startUrl + ApiKeys.detailMovie + "\(movieId)/" + ApiKeys.creditsAndKey
        guard let url = URL(string: mainUrl) else { return }
        dataTask = session.dataTask(with: url) { (data, response, error) in
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
        dataTask?.resume()
    }
    
    func fetchPerson(personId: Int, completion: @escaping (Person?) -> Void) {
        let mainUrl = ApiKeys.startUrl + ApiKeys.detailPerson + "\(personId)" + ApiKeys.detailKey + ApiKeys.paramUrl
        guard let url = URL(string: mainUrl) else { return }
        dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let objects = try decoder.decode(Person.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects)
                    }
                    
                } catch let error as NSError {
                    print("Decoding error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        dataTask?.resume()
    }
    
    func fetchVideos(movieId: Int, completion: @escaping ([VideoResult]) -> Void) {
        let mainUrl = ApiKeys.startUrl + ApiKeys.detailMovie + "\(movieId)" + ApiKeys.fetchVideos + ApiKeys.detailKey + ApiKeys.paramUrl
        
        guard let url = URL(string: mainUrl) else { return }
        dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let objects = try decoder.decode(Video.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects.results)
                    }
                    
                } catch let error as NSError {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
    func fetchYoutubeTrailer(key: String?, completion: @escaping (URL) -> Void) {
        guard let key = key else { return }
        
        let videoId = "\(key)"
        let youtubeClient = XCDYouTubeClient.default()
        
        youtubeClient.getVideoWithIdentifier(videoId) { video, _ in
            guard let ytVideo = video else {
                fatalError("Couldn't get the video from video id")
            }
            guard let streamUrl = (ytVideo.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ??
                ytVideo.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue] ??
                ytVideo.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] ??
                ytVideo.streamURLs[XCDYouTubeVideoQuality.small240.rawValue])
                else {
                    fatalError("Couldn't get URL for this quality")
            }
            DispatchQueue.main.async {
                completion(streamUrl)                
            }
        }
    }
    
    func fetchPersonImages(personId: Int?, completion: @escaping ([Profile]) -> Void) {
        guard let personId = personId else { return }
        
        let mainUrl = ApiKeys.startUrl + ApiKeys.person + "\(personId)" + ApiKeys.personImages + ApiKeys.detailKey
        guard let url = URL(string: mainUrl) else { return }
        dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let objects = try decoder.decode(PersonImage.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects.profiles)
                    }
                    
                } catch let error as NSError {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
    func fetchPersonMovies(personId: Int?, completion: @escaping ([PersonCastMovies]) -> Void) {
        
        guard let personId = personId else { return }
        
        let mainUrl = ApiKeys.startUrl + ApiKeys.person + "\(personId)" + ApiKeys.movieCredits + ApiKeys.detailKey + ApiKeys.paramUrl
        
        guard let url = URL(string: mainUrl) else { return }
        dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let objects = try decoder.decode(CastPersonMovies.self, from: data)
                    DispatchQueue.main.async {
                        completion(objects.cast)
                    }
                    
                } catch let error as NSError {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        dataTask?.resume()
    }
    
}

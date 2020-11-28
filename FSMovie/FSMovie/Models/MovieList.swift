//
//  MovieList.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


struct MovieList: Decodable {
    let results: [Result]
    
}

struct Result: Decodable {
    let popularity: Double
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: String
    let originalTitle: String
    let posterPath: String?
    let overview: String
    let video: Bool
    let voteAverage: Double
    let id: Int
    let voteCount: Int
    let releaseDate: String?
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case popularity, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview, video
        case voteAverage = "vote_average"
        case id
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case title
    }
}

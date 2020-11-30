//
//  DetailMovie.swift
//  FSMovie
//
//  Created by Игорь Попов on 29.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation

struct DetailMovie: Decodable {
    let backdropPath: String?
    let budget: Int?
    let homepage: String?
    let originalTitle: String?
    let overview: String?
    let voteAverage: Double?
    let posterPath: String?
    let revenue: Int?
    let runtime: Int?
    let title: String?
    let tagline: String?
    let releaseDate: String?
    let id: Int?
    let originalLanguage: String?
    
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget
        case homepage
        case id
        case originalTitle = "original_title"
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case revenue
        case runtime
        case title
        case tagline
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
    }
    
    
}

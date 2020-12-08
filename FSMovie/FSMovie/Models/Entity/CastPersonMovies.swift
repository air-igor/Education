//
//  PersonMovies.swift
//  FSMovie
//
//  Created by Игорь Попов on 08.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


struct CastPersonMovies: Decodable {
    let cast: [PersonCastMovies]
    let crew: [PersonCrewMovies]
}

struct PersonCastMovies: Decodable {
    let id: Int?
    let backdropPath: String?
    let releaseDate: String?
    let title: String?
}

struct PersonCrewMovies: Decodable {
    let id: Int?
    let backdropPath: String?
    let releaseDate: String?
    let title: String?
}

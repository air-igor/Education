//
//  CastPersonMovies.swift
//  FSMovie
//
//  Created by Игорь Попов on 08.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


struct CastPersonMovies: Decodable {
    let cast: [PersonCastMovies]
}

struct PersonCastMovies: Decodable {
    let id: Int?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteAverage: Double?
}

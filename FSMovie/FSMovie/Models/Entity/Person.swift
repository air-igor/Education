//
//  Person.swift
//  FSMovie
//
//  Created by Игорь Попов on 04.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation

struct Person: Decodable {
    let adult: Bool
    let biography: String?
    let birthday: String?
    let deathday: String?
    let gender: Int?
    let homepage: String?
    let id: Int?
    let imdbID, knownForDepartment, name: String?
    let placeOfBirth: String?
    let popularity: Double
    let profilePath: String?
}

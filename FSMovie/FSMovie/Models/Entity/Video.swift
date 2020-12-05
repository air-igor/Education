//
//  Video.swift
//  FSMovie
//
//  Created by Игорь Попов on 05.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation

struct Video: Codable {
    let id: Int?
    let results: [VideoResult]
}

struct VideoResult: Codable {
    let id, iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?
}

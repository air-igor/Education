//
//  SearchResponseList.swift
//  iSound
//
//  Created by Игорь Попов on 08.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation

struct SearchResponseList: Decodable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    let trackName: String
    let artistName: String
    let collectionName: String?
    let artworkUrl100: String?
}

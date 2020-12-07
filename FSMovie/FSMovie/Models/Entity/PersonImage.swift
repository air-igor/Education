//
//  PersonImage.swift
//  FSMovie
//
//  Created by Игорь Попов on 07.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


struct PersonImage: Decodable  {
    let id: Int?
    let profiles: [Profile]
}


struct Profile: Decodable {
    let filePath: String?
}

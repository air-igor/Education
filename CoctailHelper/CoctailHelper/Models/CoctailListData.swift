//
//  CoctailListData.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 29.08.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


struct CoctailListData: Codable {
    let drinks: [Drinks]
}

struct Drinks: Codable {
    let strDrink: String
}

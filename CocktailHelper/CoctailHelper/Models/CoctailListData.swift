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
    let strInstructions: String
    let strDrinkThumb: String
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
}

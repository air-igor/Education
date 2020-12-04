//
//  ApiKeys.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


enum ApiKeys {
    static let startUrl = "https://api.themoviedb.org/3"
    static let startImgUrl = "https://image.tmdb.org/t/p/w500"
    static let movie = "/search/movie?api_key="
    static let globalKey = "990e9ae77435b145536b30e7ba158fca"
    static let paramUrl = "&language=en-US&"
    static let detailMovie = "/movie/"
    static let detailPerson = "/person/"
    static let detailKey = "?api_key=990e9ae77435b145536b30e7ba158fca"
    static let imageStartUrl = "https://image.tmdb.org/t/p/original"
    static let homeVideoEnd = "&language=en-US&page=1"
    static let creditsAndKey = "credits?api_key=990e9ae77435b145536b30e7ba158fca&language=en-US"

}

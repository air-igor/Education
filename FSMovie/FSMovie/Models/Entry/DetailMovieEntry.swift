//
//  DetailMovieEntry.swift
//  FSMovie
//
//  Created by Игорь Попов on 01.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import RealmSwift

@objcMembers class DetailMovieEntry: Object {
    
    dynamic var backdropPath: String?
    dynamic var budget: Int?
    dynamic var homepage: String?
    dynamic var originalTitle: String?
    dynamic var overview: String?
    dynamic var voteAverage: Double?
    dynamic var posterPath: String?
    dynamic var revenue: Int?
    dynamic var runtime: Int?
    dynamic var title: String?
    dynamic var tagline: String?
    dynamic var releaseDate: String?
    dynamic var id: Int?
    dynamic var originalLanguage: String?
    
//    override class func primaryKey() -> String? {
//        return String(id)
//    }

    func toEntity() -> DetailMovieEntity {
        return .init(backdropPath: backdropPath,
                     budget: budget,
                     homepage: homepage,
                     originalTitle: originalTitle,
                     overview: overview,
                     voteAverage: voteAverage,
                     posterPath: posterPath,
                     revenue: revenue,
                     runtime: runtime,
                     title: title,
                     tagline: tagline,
                     releaseDate: releaseDate,
                     id: id,
                     originalLanguage: originalLanguage)
    }

}

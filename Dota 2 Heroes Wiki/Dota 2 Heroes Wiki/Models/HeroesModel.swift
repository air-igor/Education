//
//  HeroesModel.swift
//  Dota 2 Heroes Wiki
//
//  Created by Игорь Попов on 21.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation


struct Heroes: Codable {
    let localized_name: String
    let roles: [Roles]
    let img: String
}

enum Roles: String, Codable {
    case carry = "Carry"
    case disabler = "Disabler"
    case durable = "Durable"
    case escape = "Escape"
    case initiator = "Initiator"
    case jungler = "Jungler"
    case nuker = "Nuker"
    case pusher = "Pusher"
    case support = "Support"
}

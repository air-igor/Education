//
//  VoteTextManager.swift
//  FSMovie
//
//  Created by Игорь Попов on 28.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit


struct colorForVote {
    func calculaeteColorVote(_ vote: Double) -> UIColor {
        switch vote {
        case 0..<4:
            return .red
        case 4..<5.9:
            return .init(red: 255/255, green: 199/255, blue: 76/255, alpha: 1)
        case 5.9...10:
            return .init(red: 91/255, green: 202/255, blue: 70/255, alpha: 1)
        default:
            break
        }
        return .gray
    }
}

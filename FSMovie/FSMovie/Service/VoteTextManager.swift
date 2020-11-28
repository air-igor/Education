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
        case 4..<6.5:
            return .init(cgColor: #colorLiteral(red: 1, green: 0.7785236239, blue: 0.2993813753, alpha: 1))
        case 6.5...10:
            return .init(cgColor: #colorLiteral(red: 0.356010139, green: 0.7930163741, blue: 0.2730439305, alpha: 0.8024400685))
        default:
            break
        }
        return .black
    }
}

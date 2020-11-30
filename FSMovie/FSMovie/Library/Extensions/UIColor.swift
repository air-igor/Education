//
//  UIColor.swift
//  FSMovie
//
//  Created by Игорь Попов on 30.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit


extension UIColor {
    static func voteColor(vote: Double) -> UIColor {
        switch vote {
        case 0..<4:
            return .red
        case 4..<5.9:
            return .init(cgColor: #colorLiteral(red: 1, green: 0.7785236239, blue: 0.2993813753, alpha: 1))
        case 5.9...10:
            return .init(cgColor: #colorLiteral(red: 0.3827658892, green: 0.8715687394, blue: 0.3000439703, alpha: 0.8024400685))
        default:
            break
        }
        return .black
    }
}

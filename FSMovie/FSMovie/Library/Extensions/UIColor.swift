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
            return UIColor(red: 255/255, green: 199/255, blue: 76/255, alpha: 1)
        case 5.9...10:
            return UIColor(red: 98/255, green: 222/255, blue: 77/255, alpha: 1)
        default:
            break
        }
        return .black
    }
}

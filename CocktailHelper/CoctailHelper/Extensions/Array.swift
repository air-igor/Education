//
//  Array.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 05.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

}

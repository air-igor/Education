//
//  UIView.swift
//  FSMovie
//
//  Created by Игорь Попов on 28.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .init(width: 0.5, height: 4.0)
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        
    }
    
    func addShadowCast() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = .init(width: 0.5, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        
    }
}

//
//  UIViewController + Storyboard.swift
//  iSound
//
//  Created by Игорь Попов on 09.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: \(name) storyboard!")
        }
    }
}

//
//  Nib.swift
//  iSound
//
//  Created by Игорь Попов on 14.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

//
//  UICollectionView+RegisterCell.swift
//  FSMovie
//
//  Created by Игорь Попов on 12.12.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: identifier ?? cellId)
    }
}

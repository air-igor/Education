//
//  DetailMovieViewController.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit


class DetailMovieViewController: UIViewController {
    
    static let identifier = String(describing: DetailMovieViewController.self)

    var detailMovie: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    
}

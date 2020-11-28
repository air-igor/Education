//
//  MainTabBarController.swift
//  FSMovie
//
//  Created by Игорь Попов on 27.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            generateViewController(rootViewController: SearchMovieViewController(), image:
                #imageLiteral(resourceName: "search"), title: "Search"),
            generateViewController(rootViewController: DetailMovieViewController(), image: #imageLiteral(resourceName: "favorites"), title: "Favorites")
        ]
    }
    
}

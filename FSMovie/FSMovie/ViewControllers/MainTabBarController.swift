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
            generateViewController(rootViewController: HomeWindowMoviesController(),
                                   image: UIImage(named: "home") ?? UIImage(),
                                   title: "Home"),
            generateViewController(rootViewController: SearchMovieViewController(),
                                   image: UIImage(named: "search") ?? UIImage(),
                                   title: "Search"),
            generateViewController(rootViewController: FavoritesViewController(),
                                   image: UIImage(named: "favoritesTabBar") ?? UIImage(),
                                   title: "Favorites")
        ]
    }
    
}

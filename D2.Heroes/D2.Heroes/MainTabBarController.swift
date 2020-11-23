//
//  MainTabBarController.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 19.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 0.6980058551, green: 0.149012059, blue: 0.03684542701, alpha: 1)
        
        viewControllers = [
            generateViewController(rootViewController: MyAddedHeroesViewController(), image: #imageLiteral(resourceName: "dHome"), title: ""),
            generateViewController(rootViewController: AllHeroesListViewController(), image: #imageLiteral(resourceName: "dSearch"), title: "All Heroes"),
            generateViewController(rootViewController: ViewController(), image: #imageLiteral(resourceName: "dFavorites"), title: "Favorites Heroes")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
}

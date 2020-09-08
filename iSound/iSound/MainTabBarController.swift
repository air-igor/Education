//
//  MainTabBarController.swift
//  iSound
//
//  Created by Игорь Попов on 08.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        viewControllers = [
            generateViewController(rootViewController: SearchMusicViewController(), image: #imageLiteral(resourceName: "search"), title: "Search"),
            generateViewController(rootViewController: ViewController(), image: #imageLiteral(resourceName: "library"), title: "Library")
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

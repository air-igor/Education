//
//  MainTabBarController.swift
//  iSound
//
//  Created by Игорь Попов on 08.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

protocol MainTabBarControllerDelegate: class {
    func minimizedTrackDetailController()
    func miximizedTrackDetailController(viewModel: SearchViewModel.Cell?)
}

private var minimizedTopAnchorConstraints: NSLayoutConstraint!
private var miximizedTopAnchorConstraints: NSLayoutConstraint!
private var bottomAnchorConstraint: NSLayoutConstraint!

class MainTabBarController: UITabBarController {

    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        setupTrackDetailView()
        
        searchVC.tabBarDelegate = self
        viewControllers = [
            generateViewController(rootViewController: searchVC, image: #imageLiteral(resourceName: "search"), title: "Search"),
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
    
    

    private func setupTrackDetailView() {
        
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
//        use auto layout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        miximizedTopAnchorConstraints = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnchorConstraints = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraint.isActive = true
        miximizedTopAnchorConstraints.isActive = true
        
//        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

//        view.addSubview(trackDetailView)
        
    }

}

extension MainTabBarController: MainTabBarControllerDelegate {
    func miximizedTrackDetailController(viewModel: SearchViewModel.Cell?) {
        
        miximizedTopAnchorConstraints.isActive = true
        minimizedTopAnchorConstraints.isActive = false
        miximizedTopAnchorConstraints.constant = 0
        bottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: { self.view.layoutIfNeeded()
                        self.tabBar.alpha = 0
                        self.trackDetailView.miniTrackView.alpha = 0
                        self.trackDetailView.maximazedStackView.alpha = 1
                        
        },
                        completion: nil)
        
        guard let viewModel = viewModel else { return }
        self.trackDetailView.set(viewModel: viewModel)
    }
    
    
    func minimizedTrackDetailController() {
        miximizedTopAnchorConstraints.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraints.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1, options: .curveEaseOut,
                       animations: {
                        self.view.layoutIfNeeded()
                        self.tabBar.alpha = 1
                        self.trackDetailView.miniTrackView.alpha = 1
                        self.trackDetailView.maximazedStackView.alpha = 0
        },
                       completion: nil)
        
    }
    
}

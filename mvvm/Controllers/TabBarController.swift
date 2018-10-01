//
//  MainViewController.swift
//  Tennis
//
//  Created by Atabay Ziyaden on 27.09.17.
//  Copyright © 2017 IcyFlame Studios. All rights reserved.
//

import UIKit
import ChameleonFramework

fileprivate struct MainTabBarItem {
    var title: String?
    var icon: (UIImage?, UIImage?)
    var controller: UIViewController
}

class TabBarViewController: UITabBarController {
    
    fileprivate let tabBarItems = [
        MainTabBarItem(title: "Movies", icon: (#imageLiteral(resourceName: "movie"), #imageLiteral(resourceName: "movie")),
                       controller: MovieMainViewController()),
        MainTabBarItem(title: "Genres", icon: ( #imageLiteral(resourceName: "genre"), #imageLiteral(resourceName: "genre")),
                       controller: GenreListViewController()),
        MainTabBarItem(title: "Filter", icon: ( UIImage(named: "filter"), UIImage(named: "filter")),
                       controller: FilteredMovieListViewController())
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configAppBar()
    }
    
    fileprivate func configAppBar(){
        UINavigationBar.appearance().barTintColor = .flatBlackDark
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Light", size: 20)!]
        UINavigationBar.appearance().layer.shadowRadius = 0
        UINavigationBar.appearance().layer.shadowOffset = CGSize(width: 0, height: 0.0)
        UINavigationBar.appearance().isTranslucent = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.hideKeyboardWhenTappedAround()
    }
    
    fileprivate func configureTabBarItem(_ tabBarItem: UITabBarItem?, title: String?,
                                         image: UIImage?, selectedImage: UIImage?) {
        tabBarItem?.title = title
        tabBarItem?.image = image
        tabBarItem?.selectedImage = selectedImage
    }
    
    func configureTabBar() {
        viewControllers = tabBarItems.compactMap { item in
            let nc = UINavigationController(rootViewController: item.controller)
            
            return nc
        }
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.barTintColor = .flatBlackDark
        
        for (index, item) in tabBarItems.enumerated() {
            configureTabBarItem(tabBar.items![index],
                                title: item.title,
                                image: item.icon.0,
                                selectedImage: item.icon.1)
        }
    }
    
}



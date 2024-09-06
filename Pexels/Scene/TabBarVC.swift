//
//  TabBarVC.swift
//  Pexels
//
//  Created by Ayaz Ayazov on 28/8/24.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.isTranslucent = false
        
        let homeVC = HomeVC()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let searchVC = SearchVC()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let favoritesVC = FavoritesVC()
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "books.vertical.fill"), tag: 2)
        
        let profileVC = ProfileVC()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "play.rectangle.on.rectangle"), tag: 3)
        
        viewControllers = [homeNav, searchNav, favoritesNav, profileNav]
        
        
        
    }

}

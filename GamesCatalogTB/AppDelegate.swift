//
//  AppDelegate.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import UIKit
import Foundation
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        configureTabBar()
        
        return true
    }
    
    private func configureTabBar() {
        let vc = GamesViewController()
        
        let firstVC = UINavigationController(rootViewController: vc)
        firstVC.tabBarItem.title = "Games"
        firstVC.tabBarItem.image = UIImage(systemName: "gamecontroller")
        
        let vc2 = FavoriteGamesViewController()
        let secondVC = UINavigationController(rootViewController: vc2)
        secondVC.tabBarItem.title = "Favorites"
        secondVC.tabBarItem.image = UIImage(systemName: "star")
        
        let vc3 = DevelopersViewController()
        let thirdVC = UINavigationController(rootViewController: vc3)
        thirdVC.tabBarItem.title = "Developers"
        thirdVC.tabBarItem.image = UIImage(systemName: "rectangle.stack.person.crop")
        
        vc.navigationController?.navigationBar.tintColor = UIColor.black
        vc.navigationController?.navigationBar.topItem?.title = "List Of Games"
        vc.navigationController?.navigationBar.isTranslucent = true
        vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        vc.navigationController?.navigationBar.backgroundColor = .clear
        
        vc2.navigationController?.navigationBar.isTranslucent = true
        vc2.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        vc2.navigationController?.navigationBar.tintColor = UIColor.black
        vc2.navigationController?.navigationBar.topItem?.title = "Favorite Games"
        
        vc3.navigationController?.navigationBar.isTranslucent = true
        vc3.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        vc3.navigationController?.navigationBar.tintColor = UIColor.black
        vc3.navigationController?.navigationBar.topItem?.title = "Developers"
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor.black
        tabBarController.tabBar.tintColor = UIColor.white
        tabBarController.viewControllers = [firstVC, secondVC, thirdVC]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}



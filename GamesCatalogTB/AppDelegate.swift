//
//  AppDelegate.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import UIKit
import Foundation

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
        
        let secondVC = UINavigationController(rootViewController: SecondViewController())
        secondVC.tabBarItem.title = "Favorites"
        secondVC.tabBarItem.image = UIImage(systemName: "star")
        vc.navigationController?.navigationBar.tintColor = UIColor.black
        vc.navigationController?.navigationBar.topItem?.title = "List Of Games"

        vc.navigationController?.navigationBar.isTranslucent = true
        vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        vc.navigationController?.navigationBar.backgroundColor = .clear
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor.black
        tabBarController.tabBar.tintColor = UIColor.white
        tabBarController.viewControllers = [firstVC, secondVC]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}


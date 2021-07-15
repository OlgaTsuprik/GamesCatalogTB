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
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GameCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


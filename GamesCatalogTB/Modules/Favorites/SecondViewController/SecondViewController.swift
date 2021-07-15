//
//  SecondViewController.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import UIKit
import CoreData


class SecondViewController: UIViewController {
    
    @IBAction func readData(_ sender: Any) {
        print("read")
        CoreDataManager.shared.readDatawithName(name: "SavedGames")
    }
    
    
    @IBAction func deleteAll(_ sender: Any) {
        CoreDataManager.shared.removeAll(withName: "SavedGames")
        
    }
    
}

//
//  CoreDataManager.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 15.07.21.
//

import UIKit
import CoreData

class CoreDataManager {
    // MARK: Static properties
    static let entityName: String = "GameCoreData"
    static let shared = CoreDataManager()
    
    //MARK: Init
    private init() {
        
    }
    
    // MARK: CoreData
    private lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataManager.entityName)
        container.loadPersistentStores { (description, error) in
            Swift.debugPrint("\(description)")
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    
    private var context: NSManagedObjectContext {
        self.persistantContainer.viewContext
    }
    
    // MARK: Methods
    func writeData(withName name: String, withRating rating: String, withImageUrl imageUrl: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "SavedGame", in: self.context) else { return }

        let gameObject = SavedGame(entity: entity, insertInto: self.context)
        gameObject.setValue(name, forKeyPath: "nameOfGame")
        gameObject.setValue(rating, forKeyPath: "ratingOfGame")
        gameObject.setValue(imageUrl, forKey: "imageUrl")

        do {

            print(name)
            print(rating)
            try self.context.save()
            print("success")

        }
        catch let error as NSError {
            Swift.debugPrint("I couldn't save data. \(error) \(error.localizedDescription)")
        }
    }
    
}


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
    
    func writeGameWithID(with game: Game) {
        let gameObject = SavedGame(context: self.context)
        gameObject.nameOfGame = game.name
        gameObject.ratingOfGame = game.ratingString
        gameObject.imageUrl = game.backgroundImage
        gameObject.id = Int64(game.id)
        
        do {
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try self.context.save()
            
        } catch let error as NSError {
            Swift.debugPrint("I couldn't save data. \(error) \(error.localizedDescription)")
        }
    }
    
    func getData() -> [SavedGame] {
        let fetchRequest: NSFetchRequest<SavedGame> = SavedGame.fetchRequest()
        
        do {
            let objects = try context.fetch(fetchRequest)
            return objects
            
        } catch let error as NSError {
            Swift.debugPrint("I couldn't read data. \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    func removeAll() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName.rawValue)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try self.context.fetch(fetchRequest)
            result.forEach {
                self.context.delete($0)
            }
            try self.context.save()
            
        } catch let error as NSError {
            Swift.debugPrint("I couldn't delete data. \(error) \(error.localizedDescription)")
        }
    }
    
    func removeOne(id1: Int64) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName.rawValue)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try self.context.fetch(fetchRequest)
            result.forEach {
                if let id = $0.value(forKey: "id") as? Int64, id == id1 {
                    self.context.delete($0)
                }
            }
            do {
                try self.context.save()
            } catch let error as NSError {
                Swift.debugPrint("I couldn't delete data. \(error) \(error.localizedDescription)")
            }
            
        } catch let error as NSError {
            Swift.debugPrint("I couldn't delete data. \(error) \(error.localizedDescription)")
        }
    }
}



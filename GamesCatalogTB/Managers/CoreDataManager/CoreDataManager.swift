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
        gameObject.isSaved = false
        
        do {
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try self.context.save()
            gameObject.isSaved = true
            
        } catch let error as NSError {
            Swift.debugPrint("I couldn't save data. \(error) \(error.localizedDescription)")
            gameObject.isSaved = false
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
    
    func isFavorite(id: Int) -> Bool {
        let fetchRequest: NSFetchRequest<SavedGame> = SavedGame.fetchRequest()
        var favorite = Bool()
        do {
            let objects = try context.fetch(fetchRequest)
            for i in 0..<objects.count {
                if id == objects[i].id {
                    favorite = true
                    objects[i].isSaved = true
                }
            }
            
        } catch let error as NSError {
            Swift.debugPrint("\(error) \(error.localizedDescription)")
        }
       return favorite
    }
    
    func removeAll() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedGame")
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedGame")
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



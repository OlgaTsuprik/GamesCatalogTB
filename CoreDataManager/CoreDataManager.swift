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
    
    var objects: [SavedGame] = []
    
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
    
    func writeGameWithID(withName name: String, with game: Game, id: String) {
        let gameObject = SavedGame(context: self.context)
        gameObject.nameOfGame = game.name
        gameObject.ratingOfGame = game.ratingString
        gameObject.imageUrl = game.backgroundImage
        gameObject.idString = game.idString
        
        do {
            context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            try self.context.save()
            self.objects.append(gameObject)
        }
        
        catch let error as NSError {
            Swift.debugPrint("I couldn't save data. \(error) \(error.localizedDescription)")
        }
    }
    
    func getData() {
        let fetchRequest: NSFetchRequest<SavedGame> = SavedGame.fetchRequest()
        
        do {
            objects = try context.fetch(fetchRequest)
        } catch let error as NSError {
            Swift.debugPrint("I couldn't read data. \(error) \(error.localizedDescription)")
        }
    }
    
    func removeAll(withName: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedGame")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try self.context.fetch(fetchRequest)
            result.forEach { self.context.delete($0)
            }
            try self.context.save()
        } catch let error as NSError {
            Swift.debugPrint("I couldn't delete data. \(error) \(error.localizedDescription)")
        }
    }
    
    func removeOne(withName: String, id: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedGame")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try self.context.fetch(fetchRequest)
            result.forEach {
                if let idString = $0.value(forKey: "idString") as? String, idString == id {
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


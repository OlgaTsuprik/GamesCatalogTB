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
    
    func getContext() -> NSManagedObjectContext {
        
        return persistantContainer.viewContext
    }
    
    
    // MARK: Methods
    func writeData2(withName name: String, with game: Game) {
        getContext()
        let gameObject = SavedGame(context: self.context)
        gameObject.nameOfGame = game.name
        gameObject.ratingOfGame = game.ratingString
        gameObject.imageUrl = game.backgroundImage
        gameObject.idString = game.idString
        
        do {
            try self.context.save()
            print("success")
            self.objects.append(gameObject)
            print(objects.last?.nameOfGame)
            print(objects.count)
            

        }
        
        catch let error as NSError {
            Swift.debugPrint("I couldn't save data. \(error) \(error.localizedDescription)")
        }
    }
    
//    func writeData(withName name: String, withRating rating: String, withImageUrl imageUrl: String, withId idString: String) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "SavedGame", in: self.context) else { return }
//
//        let gameObject = SavedGame(entity: entity, insertInto: self.context)
//
//        gameObject.setValue(name, forKeyPath: "nameOfGame")
//        gameObject.setValue(rating, forKeyPath: "ratingOfGame")
//        gameObject.setValue(imageUrl, forKeyPath: "imageUrl")
//        gameObject.setValue(idString, forKeyPath: "idString")
//
//        do {
//            print(name)
//            print(rating)
//            try self.context.save()
//            print("success")
//
//        }
//        catch let error as NSError {
//            Swift.debugPrint("I couldn't save data. \(error) \(error.localizedDescription)")
//        }
//    }
    
    
   // func readDatawithName(name: String, withRating rating: String, withImageUrl imageUrl: String)
    
//    func readDatawithName(name: String)
//    {
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedGame")
//        do {
//            guard let result = try self.context.fetch(fetchRequest) as? [SavedGame] else { return }
//            result.forEach() {
//                Swift.debugPrint("name: \($0.nameOfGame)")
//            }
//        } catch let error as NSError {
//            Swift.debugPrint("I couldn't read data. \(error) \(error.localizedDescription)")
//        }
//    }
    
    func readData(withName name: String, with id: String) {
        getContext()
        let gameResult = SavedGame(context: self.context)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedGame")
        do {
            let result = try self.context.fetch(fetchRequest)
            result.forEach {
               
                Swift.debugPrint("id: \($0.value(forKey: "idString" ?? "id error"))")
                
            }
        } catch let error as NSError {
            Swift.debugPrint("I couldn't read data. \(error) \(error.localizedDescription)")
        }
        
    }
    
    func getData() {
        getContext()
        let fetchRequest: NSFetchRequest<SavedGame> = SavedGame.fetchRequest()
        
        do {
            objects = try context.fetch(fetchRequest)
            print(objects.count)
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
            Swift.debugPrint("I couldn't read data. \(error) \(error.localizedDescription)")
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
                Swift.debugPrint("I couldn't read data. \(error) \(error.localizedDescription)")
            }
            
            
           
        } catch let error as NSError {
            Swift.debugPrint("I couldn't read data. \(error) \(error.localizedDescription)")
        }

    }
}


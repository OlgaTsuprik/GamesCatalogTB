//
//  SavedGame+CoreDataProperties.swift
//  GamesCatalogTB
//
//  Created by Оля on 14.07.2021.
//
//

import Foundation
import CoreData

extension SavedGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedGame> {
        return NSFetchRequest<SavedGame>(entityName: Constants.entityName.rawValue)
    }

    @NSManaged public var nameOfGame: String?
    @NSManaged public var rating: Double
    @NSManaged public var imageUrl: String?
    @NSManaged public var id: Int64
    
}

extension SavedGame : Identifiable {

}

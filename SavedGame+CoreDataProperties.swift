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
        return NSFetchRequest<SavedGame>(entityName: "SavedGame")
    }

    @NSManaged public var nameOfGame: String?
    @NSManaged public var ratingOfGame: String?
}

extension SavedGame : Identifiable {

}

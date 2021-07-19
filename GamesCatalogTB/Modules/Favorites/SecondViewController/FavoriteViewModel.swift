//
//  FavoriteViewModel.swift
//  GamesCatalogTB
//
//  Created by Оля on 16.07.2021.
//

import UIKit
import CoreData


class FavoriteViewModel {
    // MARK: Properties
    
    var savedObjests: [SavedGame] = []
   
    // MARK: Methods
    
    func loadImage(index: Int, completion: @escaping((UIImage?) -> Void)) {
        NetworkingManager.shared.fetchImage(url: savedObjests[index].imageUrl ?? "") { image in
            completion(image)
        }
    }
    
    func loadData(completion: @escaping ([SavedGame]) -> Void) {
        savedObjests = CoreDataManager.shared.objects
        CoreDataManager.shared.getData()
       self.savedObjests = CoreDataManager.shared.objects
        completion(savedObjests)
    }
    
    func deleteItem(index: Int) {
        CoreDataManager.shared.removeOne(withName: "SavedGame", id: savedObjests[index].idString ?? "")
        savedObjests.remove(at: index)
    }
    
    func deleteAll() {
        CoreDataManager.shared.removeAll(withName: "SavedGame")
        savedObjests = []
    }
}

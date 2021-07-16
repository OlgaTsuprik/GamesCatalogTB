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

}

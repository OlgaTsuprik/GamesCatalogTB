//
//  DetailViewModel.swift
//  GamesCatalogTB
//
//  Created by Оля on 12.07.2021.
//

import UIKit

class DetailViewModel {
    // MARK: Properties
   
    private(set) var game: Game?
    init(game: Game) {
        self.game = game
    }
     
    func loadImage(url: String, completion: @escaping((UIImage?) -> Void)) {
        NetworkingManager.shared.fetchImage(url: url) { image in
            completion(image)
        }
    }
}

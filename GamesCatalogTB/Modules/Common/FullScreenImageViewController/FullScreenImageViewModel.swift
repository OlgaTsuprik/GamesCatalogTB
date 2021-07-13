//
//  FullScreenImageViewModel.swift
//  GamesCatalogTB
//
//  Created by Оля on 12.07.2021.
//

import UIKit
class FullScreenImageViewModel {
    var bigImage: String
    init(biImage: String) {
        self.bigImage = biImage
    }
    
    func loadScreenshotImage(url: String, completion: @escaping((UIImage?) -> Void)) {
        NetworkingManager.shared.fetchImage(url: url) { image in
            completion(image)
        }
    }
    
}

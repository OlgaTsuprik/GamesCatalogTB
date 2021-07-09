//
//  StructGameViewModel.swift
//  GamesCatalogTB
//
//  Created by Оля on 09.07.2021.
//

import UIKit

struct GameViewModel {
    let gameVM: Game
    var nameGame: String {
        return gameVM.name
    }
    var rating: String {
        return String(gameVM.rating)
    }
    var urlToImage: String {
        return gameVM.backgroundImage
    }
    var description: String {
        return gameVM.description ?? "Desctiption is absent"
    }
    var released: String {
        return gameVM.released
    }

    var screenShotsOfGame: [String] {
        return gameVM.screenShots.map { screenShots in
            screenShots.image
        }
    }
    
    var genresOfGame: [String] {
        return gameVM.genres.map { genres in
            genres.name
        }
    }
    func loadScreenshotImage(index: Int, completion: @escaping((UIImage?) -> Void)) {
        NetworkingManager.shared.fetchImage(url: screenShotsOfGame[index]) { image in
            completion(image)
        }
    }
}

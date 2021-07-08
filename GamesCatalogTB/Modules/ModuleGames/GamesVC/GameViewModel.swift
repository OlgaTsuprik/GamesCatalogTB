//
//  GamesViewModel.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import Foundation
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
}

class GamesViewModel {
    // MARK: Properties
    var gamesVM = [GameViewModel]()
    var networkingManager = NetworkingManager()
    var isLoadingListNow: Bool = false
    var errorCauched: NetworkError?
    let pageSize: Int = 20
    
    var paging: ClosedRange<Int> {
        get {
            (gamesVM.count - pageSize)...(gamesVM.count - 1)
        }
    }
    
    // MARK: Methods
    func loadData(completion: @escaping ([GameViewModel]) -> Void, errorHandler: @escaping (NetworkError) -> Void ) {
        networkingManager.fetchGames { (games) in
            self.isLoadingListNow = true
            let gamesVM = games.map(GameViewModel.init)
            DispatchQueue.main.async {
                self.gamesVM = gamesVM
                completion(gamesVM)
            }
        } errorHandler: { (errorI) in
            self.errorCauched = errorI
            DispatchQueue.main.async {
                errorHandler(errorI)
            }
        }
    }
    
    func loadImage(index: Int, completion: @escaping((Data?) -> Void)) {
        networkingManager.fetchImage(url: gamesVM[index].urlToImage) { data in
            guard let data = data else { return }
            completion(data)
        }
    }

    func loadMoreData(completion: @escaping ([GameViewModel]) -> Void) {
        networkingManager.pageNumber += 1
        if isLoadingListNow == true {
            networkingManager.fetchGames { (games) in
                let  newGames = games.map(GameViewModel.init)
                self.gamesVM.append(contentsOf: newGames)
                DispatchQueue.main.async {
                    completion(self.gamesVM)
                }
            } errorHandler: { (error) in
            }
            isLoadingListNow = false
        }
    }
    
}

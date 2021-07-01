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
}

class GamesViewModel {
    // MARK: Properties
    var gamesVM = [GameViewModel]()
    var networkingManager = NetworkingManager()
    var isLoadingListNow: Bool = false
    var errorCauched: NetworkError?
    
    
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

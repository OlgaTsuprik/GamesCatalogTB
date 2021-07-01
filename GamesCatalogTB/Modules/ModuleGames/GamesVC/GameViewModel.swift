//
//  GamesViewModel.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import Foundation

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
    
    // MARK: Methods
    func loadData(completion: @escaping ([GameViewModel]) -> Void) {
        networkingManager.fetchGames { (games) in
            self.isLoadingListNow = true
            let gamesVM = games.map(GameViewModel.init)
            DispatchQueue.main.async {
                self.gamesVM = gamesVM
                completion(gamesVM)
            }
        }
    }
    
    
    func loadMoreData(completion: @escaping ([GameViewModel]) -> Void) {
        //isLoadingListNow = true
        networkingManager.pageNumber += 1
        if isLoadingListNow == true {
            networkingManager.fetchGames { (games) in
                let  newGames = games.map(GameViewModel.init)
                self.gamesVM.append(contentsOf: newGames)
                DispatchQueue.main.async {
                    completion(self.gamesVM)
                }
            }
            isLoadingListNow = false
        }
    }
}

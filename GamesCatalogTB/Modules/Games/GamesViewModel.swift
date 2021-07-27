//
//  GamesViewModel.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import Foundation
import UIKit

class GamesViewModel {
    // MARK: Properties
    var gamesVM = [Game]()
    var errorCauched: NetworkError?
    let pageSize: Int = 20
    var pageNumber: Int = 1
    var isLoadingList: Bool = false
    var paging: ClosedRange<Int> {
        get {
            (gamesVM.count - pageSize)...(gamesVM.count - 1)
        }
    }
    var savedToCDGames = [SavedGame]()
    
    // MARK: Methods
    func loadData(completion: @escaping ([Game]) -> Void, errorHandler: @escaping (NetworkError) -> Void ) {
        NetworkingManager.shared.fetchGames(isLoadingList: isLoadingList, pageNumber: pageNumber){ (games) in
            self.isLoadingList = true
            
            let gamesVM = games
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
    
    func loadDataFromCD() {
        savedToCDGames = CoreDataManager.shared.getData()
     }
    
    func loadImage(index: Int, completion: @escaping((UIImage?) -> Void)) {
        NetworkingManager.shared.fetchImage(url: gamesVM[index].backgroundImage) { image in
            completion(image)
        }
    }

    func loadMoreData(completion: @escaping ([Game]) -> Void) {
        pageNumber += 1
        if isLoadingList == true {
            NetworkingManager.shared.fetchGames(isLoadingList: isLoadingList, pageNumber: pageNumber) { (games) in
                let  newGames = games
                self.gamesVM.append(contentsOf: newGames)
                DispatchQueue.main.async {
                    completion(self.gamesVM)
                }
            } errorHandler: { (error) in
            }
            isLoadingList = false
        }
    }
    
    func saveUniqueGame(_ index: Int) {
        CoreDataManager.shared.writeGameWithID(with: gamesVM[index])
        if CoreDataManager.shared.getData().last != nil {
            savedToCDGames.append(CoreDataManager.shared.getData().last!)
        } else {
            return
        }
    }
    
    func checkIsFavorite(id: Int) -> Bool {
        var checkFavorite = Bool()
        for i in 0..<savedToCDGames.count {
            if id == savedToCDGames[i].id {
                checkFavorite = true
            }
        }
        return checkFavorite
    }
}

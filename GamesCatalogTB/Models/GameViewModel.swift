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
    var gamesVM = [GameViewModel]()
    //var isLoadingListNow: Bool = false
    var errorCauched: NetworkError?
    let pageSize: Int = 20
    var pageNumber: Int = 1
    var isLoadingList: Bool = false
    
    var paging: ClosedRange<Int> {
        get {
            (gamesVM.count - pageSize)...(gamesVM.count - 1)
        }
    }
    
    // MARK: Methods
    func loadData(completion: @escaping ([GameViewModel]) -> Void, errorHandler: @escaping (NetworkError) -> Void ) {
        NetworkingManager.shared.fetchGames(isLoadingList: isLoadingList, pageNumber: pageNumber){ (games) in
            self.isLoadingList = true
    
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
    
    func loadImage(index: Int, completion: @escaping((UIImage?) -> Void)) {
        NetworkingManager.shared.fetchImage(url: gamesVM[index].urlToImage) { image in
            completion(image)
        }
    }

    func loadMoreData(completion: @escaping ([GameViewModel]) -> Void) {
        pageNumber += 1
        if isLoadingList == true {
            NetworkingManager.shared.fetchGames(isLoadingList: isLoadingList, pageNumber: pageNumber) { (games) in
                let  newGames = games.map(GameViewModel.init)
                self.gamesVM.append(contentsOf: newGames)
                DispatchQueue.main.async {
                    completion(self.gamesVM)
                }
            } errorHandler: { (error) in
            }
            isLoadingList = false
        }
    }
}

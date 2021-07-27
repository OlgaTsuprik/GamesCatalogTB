//
//  DevelopersViewModel.swift
//  GamesCatalogTB
//
//  Created by Оля on 27.07.2021.
//

import Foundation
import UIKit

class DevelopersViewModel {
    //MARK: Properties
    var developersVM = [Developer]()
    var errorCauched: NetworkError?
    let pageSize: Int = 10
    var isLoadingList: Bool = false
    var pageNumber: Int = 1
    var paging: ClosedRange<Int> {
        get {
            (developersVM.count - pageSize)...(developersVM.count - 1)
        }
    }
    
    // MARK: Methods
    func loadData(completion: @escaping ([Developer]) -> Void, errorHandler: @escaping (NetworkError) -> Void ) {
        NetworkingManager.shared.fetchDevelopers(isLoadingList: isLoadingList, pageNumber: pageNumber){ (developers) in
            self.isLoadingList = true
            
            let developersVM = developers
            DispatchQueue.main.async {
                self.developersVM = developersVM
                completion(developersVM)
            }
        } errorHandler: { (error) in
            self.errorCauched = error
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }
    
    func loadImage(index: Int, completion: @escaping((UIImage?) -> Void)) {
        NetworkingManager.shared.fetchImage(url: developersVM[index].backgroundImage) { image in
            completion(image)
        }
    }
    
    func loadMoreData(completion: @escaping ([Developer]) -> Void) {
        pageNumber += 1
        if isLoadingList == true {
            NetworkingManager.shared.fetchDevelopers(isLoadingList: isLoadingList, pageNumber: pageNumber) { (developers) in
                let  newDevelopers = developers
                self.developersVM.append(contentsOf: newDevelopers)
                DispatchQueue.main.async {
                    completion(self.developersVM)
                }
            } errorHandler: { (error) in
            }
            isLoadingList = false
        }
    }
    
}

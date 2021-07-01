//
//  NetworkingManager.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import Foundation

enum NetworkError {
    //case networkError(error: Error)
    case networkError
    case unknown
}

class NetworkingManager {
    // MARK: Properties
    let baseURL = "https://api.rawg.io/api/games"
    var pageNumber: Int = 1
    var isLoadingList: Bool = false
    
    // MARK: Methods
    
    func fetchGames(completion: @escaping (([Game]) -> Void),
                    errorHandler: @escaping (NetworkError) -> Void) {
        self.isLoadingList = false
        guard let urlString =  URL(string: baseURL + "?key=" + Constants.apiKey.rawValue + "&page=" + String(pageNumber)) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlString) { data, response, error in
            if error != nil {
                errorHandler(NetworkError.networkError)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let gamesData = try decoder.decode(ListOfGames.self, from: data)
                    completion(gamesData.results)
                }
                catch let error as NSError {
                    errorHandler(.unknown)
                }
            }
        }
        task.resume()
    }
}

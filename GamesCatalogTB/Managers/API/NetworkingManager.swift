//
//  NetworkingManager.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import UIKit

enum NetworkError {
    case networkError
    case unknown
}

class NetworkingManager {
    // MARK: Properties
    let baseURL = "https://api.rawg.io/api/games"
    let developersURL = "https://api.rawg.io/api/developers"
    
    let imageCache = NSCache<NSString, UIImage>()
    
    //MARK: Static
    static let shared = NetworkingManager()
  
    private init() {}

    // MARK: Methods
    
    func fetchGames(isLoadingList: Bool,
                    pageNumber: Int,
                    completion: @escaping (([Game]) -> Void),
                    errorHandler: @escaping (NetworkError) -> Void) {
        guard let urlObj =  URL(string: "\(baseURL)?key=\(Constants.apiKey.rawValue)&page=\(pageNumber)") else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlObj) { data, response, error in
            if error != nil {
                errorHandler(NetworkError.networkError)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let gamesData = try decoder.decode(ListOfGames.self, from: data)
                    completion(gamesData.results)
                }
                catch _ as NSError {
                    errorHandler(.unknown)
                }
            }
        }
        task.resume()
    }
    
    func fetchImage(url: String, completion: @escaping ((UIImage?) -> Void)) {
        guard let urlObject =  URL(string: url) else {
            return
        }
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else {
            let session = URLSession(configuration: .default)
            let _ = session.dataTask(with: urlObject) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: url as NSString)
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
    
    func fetchDevelopers(isLoadingList: Bool,
                    pageNumber: Int,
                    completion: @escaping (([Developer]) -> Void),
                    errorHandler: @escaping (NetworkError) -> Void) {
        guard let urlObj =  URL(string: "\(developersURL)?key=\(Constants.apiKey.rawValue)&page=\(pageNumber)") else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlObj) { data, response, error in
            if error != nil {
                errorHandler(NetworkError.networkError)
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let developersData = try decoder.decode(ListOfDevelopers.self, from: data)
                    completion(developersData.results)
                }
                catch _ as NSError {
                    errorHandler(.unknown)
                }
            }
        }
        task.resume()
    }
}

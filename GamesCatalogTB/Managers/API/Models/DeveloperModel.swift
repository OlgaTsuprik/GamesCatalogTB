//
//  DeveloperModel.swift
//  GamesCatalogTB
//
//  Created by Оля on 27.07.2021.
//

import Foundation
// MARK: - ListOfDevelopers
struct ListOfDevelopers: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Developer]
}


// MARK: - Developer
struct Developer: Decodable {
    let id: Int
    let name: String
    let slug: String
    let gamesCount: Int
    let backgroundImage: String
    let games: [GameOfDeveloper]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case backgroundImage = "image_background"
        case games
    }
}

// MARK: - Game
struct GameOfDeveloper: Decodable {
    let id: Int
    let slug: String
    let name: String
   
    var added: Int

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case added
     
    }
}


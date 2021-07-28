//
//  GameModel.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import Foundation

// MARK: - ListOfGames
struct ListOfGames: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Game]
}

// MARK: - Game
struct Game: Decodable {
    let id: Int
    let name: String
    let description: String?
    let released: String
    let backgroundImage: String
    var rating: Double
    var added: Int
    let screenShots: [ScreenShots]
    let genres: [Genres]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case released
        case backgroundImage = "background_image"
        case rating
        case added
        case screenShots = "short_screenshots"
        case genres
    }
}

struct ScreenShots: Decodable {
    let image: String

    enum CodingKeys: String, CodingKey {
        case image
    }
}

struct Genres: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}


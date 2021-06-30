//
//  TableViewCell.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import UIKit

class GameCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameOfGame: UILabel!
    
    var gameViewModel: GameViewModel?
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "gameCell")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func config(model: GameViewModel?) {
        self.ratingLabel.text = gameViewModel?.rating
        self.nameOfGame.text = gameViewModel?.nameGame
    }
}

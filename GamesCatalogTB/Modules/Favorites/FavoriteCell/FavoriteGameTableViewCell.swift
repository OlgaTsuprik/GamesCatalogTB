//
//  FavoriteGameTableViewCell.swift
//  GamesCatalogTB
//
//  Created by Оля on 16.07.2021.
//

import UIKit

class FavoriteGameTableViewCell: UITableViewCell {
    @IBOutlet weak var designView: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designView.addShadow()
        designView.addBorder()
    }
    
    func config(model: SavedGame?, index: String) {
        self.ratingLabel.text = model?.ratingOfGame
        self.nameLabel.text = model?.nameOfGame
        self.indexLabel.text = index
        self.idLabel.text = model?.idString
    }
    
    
}

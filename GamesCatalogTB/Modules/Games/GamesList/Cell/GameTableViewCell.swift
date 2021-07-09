//
//  GameTableViewCell.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameOfGame: UILabel!
    @IBOutlet weak var desingView: UIView!
    @IBOutlet weak var photoView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        desingView.addShadow()
        desingView.addBorder()
        photoView.image = UIImage(named: "default")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoView.image = UIImage(named: "default")
    }
    
    func config(model: GameViewModel?, index: String) {
        self.ratingLabel.text = model?.rating
        self.nameOfGame.text = model?.nameGame
        self.indexLabel.text = index
    }
    
    func addImage(image: UIImage?) {
        self.photoView.image = image
    }
}

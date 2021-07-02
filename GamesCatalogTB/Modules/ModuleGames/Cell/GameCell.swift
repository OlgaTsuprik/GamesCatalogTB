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
    @IBOutlet weak var desingView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
  
    func config(model: GameViewModel?, index: String) {
        self.ratingLabel.text = model?.rating
        self.nameOfGame.text = model?.nameGame
        self.indexLabel.text = index
    }
}

extension UIView {
    func addShadow(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.init(named: "borderLine")?.cgColor
    }
}

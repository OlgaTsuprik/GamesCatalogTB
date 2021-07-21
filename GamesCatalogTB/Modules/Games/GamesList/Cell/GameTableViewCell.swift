//
//  GameTableViewCell.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import UIKit
import CoreData

class GameTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameOfGame: UILabel!
    @IBOutlet weak var desingView: UIView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveAction(_ sender: Any) {
        saveAction?()
       
    }
    
    var saveAction: (() -> Void)?
    private var index: Int?
    
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
    
    func config(model: Game?, indexOfCell: Int) {
        self.ratingLabel.text = model?.ratingString
        self.nameOfGame.text = model?.name
        self.idLabel.text = String(model?.id ?? 0)
        self.indexLabel.text = String(indexOfCell + 1)
        self.index = indexOfCell
    }
    
    func configFavoriteGame(model: SavedGame?, indexOfCell: Int) {
        self.ratingLabel.text = model?.ratingOfGame
        self.nameOfGame.text = model?.nameOfGame
        self.indexLabel.text = String(indexOfCell + 1)
        self.idLabel.text = String(Int(model?.id ?? 0))
        self.saveButton.isHidden = true
    }
    
    func addImage(image: UIImage?) {
        self.photoView.image = image
    }
}

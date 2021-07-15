//
//  GameTableViewCell.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import UIKit
import CoreData

protocol GameTableViewDelegate: class {
    func saveGame(index: Int)
}

class GameTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameOfGame: UILabel!
    @IBOutlet weak var desingView: UIView!
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveGame(_ sender: Any) {
    print("hello")
        guard let index = index else { return}
        //delegate?.saveGame(index: index)
        saveAction?()
    }
    
    var saveAction: (() -> Void)?
    
    private var index: Int?
    weak var delegate: GameTableViewDelegate?
    
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
    
    func config(model: Game?, index: String, indexOfCell: Int) {
        self.ratingLabel.text = model?.ratingString
        self.nameOfGame.text = model?.name
        self.indexLabel.text = index
        self.index = indexOfCell
    }
    
    func addImage(image: UIImage?) {
        self.photoView.image = image
    }
}

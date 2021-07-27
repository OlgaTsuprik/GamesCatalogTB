//
//  DeveloperTableViewCell.swift
//  GamesCatalogTB
//
//  Created by Оля on 27.07.2021.
//

import UIKit

class DeveloperTableViewCell: UITableViewCell {

    @IBOutlet weak var designView: UIView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var gamesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designView.addShadow()
        designView.addBorder()
        backgroundImage.image = UIImage(named: "default")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundImage.image = UIImage(named: "default")
    }
    
    func config(model: Developer?, index: Int) {
        self.indexLabel.text = String(index + 1)
        self.nameLabel.text = model?.name
        self.idLabel.text = String(model?.id ?? 0)
        self.gamesCountLabel.text = String(model?.gamesCount ?? 0)
    }
    
    func addImage(image: UIImage?) {
        self.backgroundImage.image = image
    }
    
}

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
    
    @IBOutlet weak var photoView: UIImageView!
    
    //let network = NetworkingManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        desingView.addShadow()
        photoView.image = UIImage(named: "default")
    }
  
    func config(model: GameViewModel?, index: String) {
        self.ratingLabel.text = model?.rating
        self.nameOfGame.text = model?.nameGame
        self.indexLabel.text = index
        self.photoView?.load(url: URL(string: model!.urlToImage)!)
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}

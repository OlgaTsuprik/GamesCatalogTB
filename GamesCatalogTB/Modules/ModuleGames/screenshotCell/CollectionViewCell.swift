//
//  CollectionViewCell.swift
//  GamesCatalogTB
//
//  Created by Оля on 06.07.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(model: GameViewModel?) {
        self.collectionImage?.load(url: URL(string: (model!.screenShotsOfGame[2]))!)

    }
    func set(image: UIImage) {
        self.collectionImage.image = image
    }
}

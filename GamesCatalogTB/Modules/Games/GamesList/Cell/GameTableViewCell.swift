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
    
    @IBAction func saveGame(_ sender: Any) {
    print("hello")
        self.saveGameToCD(withName: nameOfGame.text ?? "n", rating: ratingLabel.text ?? "y")

    }
    private func saveGameToCD(withName name: String, rating: String) {
        print("game saved")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "SavedGame", in: context) else { return }
        let gameObject = SavedGame(entity: entity, insertInto: context)
        gameObject.nameOfGame = name
        gameObject.ratingOfGame = rating
        
        do {
            try context.save()
            print(gameObject.nameOfGame)
            print(gameObject.ratingOfGame)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
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
    
    func config(model: Game?, index: String) {
        self.ratingLabel.text = model?.ratingString
        self.nameOfGame.text = model?.name
        self.indexLabel.text = index
    }
    
    func addImage(image: UIImage?) {
        self.photoView.image = image
    }
}

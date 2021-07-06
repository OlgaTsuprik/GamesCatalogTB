//
//  DetailViewController.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.06.21.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var imageOfGame: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var screenshortsCollection: UICollectionView!
    
    //MARK: Properties
    var modelDetailed: GameViewModel?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showInfo()
    }
    
    //MARK: Methods
    func showInfo() {
        nameLabel.text = modelDetailed?.nameGame
        releasedLabel.text = modelDetailed?.released
        descriptionLabel.text = modelDetailed?.description
        genresLabel.text = modelDetailed?.genresOfGame.joined(separator: ",")
        ratingLabel.text = modelDetailed?.rating
        imageOfGame?.load(url: URL(string: modelDetailed!.urlToImage)!)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        return cell
    }
    
    
}

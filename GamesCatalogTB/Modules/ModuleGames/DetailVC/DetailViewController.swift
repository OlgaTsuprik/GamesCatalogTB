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
    var modelScreens: [String] = []
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        screenshortsCollection.delegate = self
        screenshortsCollection.dataSource = self
        let nibName = UINib(nibName: "CollectionViewCell", bundle: nil)
        screenshortsCollection.register(nibName, forCellWithReuseIdentifier: "collectionViewCell")
        showInfo()
        screenshortsCollection.isScrollEnabled = false
        screenshortsCollection.contentSize = CGSize(width: self.screenshortsCollection.bounds.width, height: 1000)
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
        
        return modelDetailed?.screenShotsOfGame.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.collectionImage.loadFromStringURL(url: modelDetailed!.screenShotsOfGame[indexPath.row])
        return cell
    }
}


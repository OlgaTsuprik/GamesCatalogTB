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
    @IBOutlet weak var heightCollection: NSLayoutConstraint!
    
    //MARK: Properties
    var modelDetailed: GameViewModel?
    var modelScreens: [String] = []
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        screenshortsCollection.delegate = self
        screenshortsCollection.dataSource = self
        let nibName = UINib(nibName: "ScreenshotCollectionViewCell", bundle: nil)
        screenshortsCollection.register(nibName, forCellWithReuseIdentifier: "collectionViewCell")
        showInfo()
        screenshortsCollection.isScrollEnabled = false
        screenshortsCollection.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        heightCollection.constant = screenshortsCollection.contentSize.height
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! ScreenshotCollectionViewCell
        cell.collectionImage.loadFromStringURL(url: modelDetailed!.screenShotsOfGame[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullScreenImageViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        //self.navigationController?.present(vc, animated: true, completion: nil)
        let model = modelDetailed?.screenShotsOfGame[indexPath.row]
        vc.imageURLString = model
     }
}


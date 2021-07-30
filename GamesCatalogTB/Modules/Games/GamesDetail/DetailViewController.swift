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
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var screenshortsCollection: UICollectionView!
    @IBOutlet weak var heightCollection: NSLayoutConstraint!
    
    //MARK: Properties
    var collectionInset: CGFloat = 7
    var itemsPerRow = 2
    var gameViewModel: DetailViewModel?
    
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
        self.navigationItem.title = gameViewModel?.game?.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back".localized)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        heightCollection.constant = screenshortsCollection.contentSize.height
    }
    
    //MARK: Methods
    func showInfo() {
        nameLabel.text = gameViewModel?.game?.name
        releasedLabel.text = gameViewModel?.game?.released
        descriptionLabel.text = gameViewModel?.game?.description ?? "Absent".localized
        genresLabel.text = gameViewModel?.game?.genres.map{ genres in
            genres.name
        }.joined(separator: ", ")
        ratingLabel.text = String(gameViewModel?.game?.rating ?? 0)
        idLabel.text = String(Int(gameViewModel?.game?.id ?? 0))
        
        gameViewModel?.loadImage(url: gameViewModel?.game?.backgroundImage ?? "", completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.imageOfGame.image = image
            }
        })
    }
}

//MARK: Extensions
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gameViewModel?.game?.screenShots.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? ScreenshotCollectionViewCell
        gameViewModel?.loadImage(url: gameViewModel?.game?.screenShots[indexPath.row].image ?? "", completion: { screen in
            DispatchQueue.main.async {
                if let cell = self.screenshortsCollection.cellForItem(at: indexPath) as? ScreenshotCollectionViewCell {
                    cell.addScreenShot(image: screen)
                }
            }
        })
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availibleWidth = (Int(collectionView.frame.width) - (Int(collectionInset) * (itemsPerRow + 1))) / itemsPerRow
        return CGSize(width: availibleWidth, height: availibleWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionInset, left: collectionInset, bottom: collectionInset, right: collectionInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return collectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullScreenImageViewController()
        let fsModel = FullScreenImageViewModel(biImage: gameViewModel?.game?.screenShots[indexPath.row].image ?? "")
        vc.fsModel = fsModel
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

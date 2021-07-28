//
//  DeveloperDetailViewController.swift
//  GamesCatalogTB
//
//  Created by Оля on 27.07.2021.
//

import UIKit

class DeveloperDetailViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gamesCountLabel: UILabel!
    @IBOutlet weak var gamesLabel: UILabel!
    
    //MARK: Properties
    var developerViewModel: DeveloperDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        showInfo()
        self.navigationItem.title = developerViewModel?.developer?.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back".localized)
   }
    
    func showInfo() {
        idLabel.text = String(developerViewModel?.developer?.id ?? 0)
        nameLabel.text = developerViewModel?.developer?.name
        gamesCountLabel.text = String(developerViewModel?.developer?.gamesCount ?? 0)
        gamesLabel.text = developerViewModel?.developer?.games.map({ games in
            games.name
        }).joined(separator: "\n")
       
        developerViewModel?.loadImage(url: developerViewModel?.developer?.backgroundImage ?? "", completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.backgroundImage.image = image
            }
        })
    }
}

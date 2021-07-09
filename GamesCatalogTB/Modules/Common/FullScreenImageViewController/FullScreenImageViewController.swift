//
//  FullScreenImageViewController.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 8.07.21.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var screenShotImageView: UIImageView!
    
    //MARK: Properties
    var imageURLString: String?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        screenShotImageView.loadFromStringURL(url: imageURLString ?? "")
    }
}

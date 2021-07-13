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
   
    var fsModel: FullScreenImageViewModel?
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fsModel?.loadScreenshotImage(url: fsModel?.bigImage ?? "", completion: { screen in
            DispatchQueue.main.async {
                guard let screen = screen else { return }
                self.screenShotImageView.image = screen
            }
        })
    }
}

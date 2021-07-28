//
//  DeveloperDetailViewModel.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 28.07.21.
//

import Foundation
import UIKit

class DeveloperDetailViewModel {
    
  // MARK: Properties
  private(set) var developer: Developer?
  init(developer: Developer) {
    self.developer = developer
  }
  //MARK: Methods
  func loadImage(url: String, completion: @escaping((UIImage?) -> Void)) {
    NetworkingManager.shared.fetchImage(url: url) { image in
      completion(image)
    }
  }
}

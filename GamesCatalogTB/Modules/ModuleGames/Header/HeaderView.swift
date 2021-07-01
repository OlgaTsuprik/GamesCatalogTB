//
//  HeaderViewTableViewCell.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import UIKit

class HeaderView: UIView {
    var sort: Bool = false
    
    @IBAction func sortAction(_ sender: Any) {
        print("sort")
        self.sort = true
        
    }
    
}

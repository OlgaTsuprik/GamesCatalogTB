//
//  HeaderViewTableViewCell.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 29.06.21.
//

import UIKit

class HeaderViewTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

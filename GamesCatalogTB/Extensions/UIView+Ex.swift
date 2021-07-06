//
//  Extensions.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 6.07.21.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.init(named: "borderLine")?.cgColor
    }
}

extension UIView {
    func addBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
}

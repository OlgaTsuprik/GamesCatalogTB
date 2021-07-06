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
        self.layer.shadowOpacity = 0.8
        self.layer.cornerRadius = 15.0
        self.layer.shadowOffset = CGSize(width: -5, height: 5)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.init(named: "borderLine")?.cgColor
        //self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: 15).cgPath
    }
}

extension UIView {
    func addBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
}

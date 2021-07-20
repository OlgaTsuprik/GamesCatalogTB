//
//  AlertHelper.swift
//  GamesCatalogTB
//
//  Created by Tsuprik Olga on 20.07.21.
//

import UIKit

class AlertHelper {
    // MARK: - Singleton
    static let shared = AlertHelper()

    // MARK: - Initialization
    private init() { }

    // MARK: - Methods
    func show(for controller: UIViewController?,
              title: String = "",
              message: String = "",
              leftButtonTitle: String? = nil,
              rightButtonTitle: String,
              leftButtonAction: (() -> Void)? = nil,
              rightButtonAction: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let leftTitle = leftButtonTitle {
            alert.addAction(UIAlertAction(title: leftTitle,
                                          style: .destructive,
                                          handler: { (_) in leftButtonAction?() }))
        }
        alert.addAction(UIAlertAction(title: rightButtonTitle,
                                      style: .cancel,
                                      handler: { (_) in
                                        rightButtonAction?()
                                      }))
        controller?.present(alert, animated: true)
    }
}

extension AlertHelper: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

//
//  UIViewController+Extension.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 18.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String = "Error", message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

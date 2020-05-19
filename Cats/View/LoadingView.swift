//
//  LoadingView.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 12.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation
import UIKit

final class LoadingView: UIView {
    
    //MARK: - Private Properties
    
    private let spinner = UIActivityIndicatorView()
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if superview?.backgroundColor != UIColor.black {
            backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
        }
        layer.cornerRadius = 10
        
        if spinner.superview == nil {
            if #available(iOS 13.0, *) {
                spinner.style = .large
                spinner.color = .white
            } else {
                // Fallback on earlier versions
                spinner.style = .whiteLarge
            }
            addSubview(spinner)
            
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            spinner.startAnimating()
        }
    }
    
    
    // MARK: - Public Methods
    
    public func animate() {
        spinner.startAnimating()
    }
}

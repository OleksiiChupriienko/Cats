//
//  Loadable Protocol.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 12.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation
import UIKit

protocol Loadable {
    func setLoadingView()
    func removeLoadingView()
}

extension Loadable where Self: UIViewController {
    func setLoadingView() {
        let loadingView = LoadingView()
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loadingView.tag = Constants.loadingViewTag
    }
    
    func removeLoadingView() {
        view.subviews.forEach { (subview) in
            if subview.tag == Constants.loadingViewTag {
                subview.removeFromSuperview()
            }
        }
    }
    
}

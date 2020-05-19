//
//  ZoomedImageViewController.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 15.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class ZoomedImageViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Public Properties
    
    var urlString: String?
    
    //MARK: - Private Properties
    private let loader = ImageLoader.shared
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackground()
        loadImage()
    }
    
    //MARK: - Private Methods
    
    private func setUpBackground() {
        view.backgroundColor = UIColor.black
    }
    
    private func loadImage() {
        setLoadingView()
        if urlString != nil, let url = URL(string: urlString!) {
            loader.loadImage(url, completion: { (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.removeLoadingView()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.removeLoadingView()
                        self.showAlert(message: "While loading image\n\(error.localizedDescription.lowercased())")
                    }
                }
            })
        }
    }
    
}

extension ZoomedImageViewController: Loadable {}

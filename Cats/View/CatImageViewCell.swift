//
//  CatImageViewCell.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 09.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class CatImageViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "cat-butt")
    }
}

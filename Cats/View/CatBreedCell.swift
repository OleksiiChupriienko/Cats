//
//  CatBreedCell.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 30.04.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class CatBreedCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    // MARK: - Public Properties
    
    var onReuse: () -> Void = {}
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        label.text = ""
        picture.image = UIImage(named: Constants.placeholderImage)
    }

}

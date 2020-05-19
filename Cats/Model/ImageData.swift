//
//  ImageUrl.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 30.04.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation

typealias ImageDataResponse = [ImageData]

struct ImageData: Decodable {
    let url: String
}

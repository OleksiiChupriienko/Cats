//
//  String+Extension.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 04.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation

extension String {
    func getFlag() -> String {
//      There is a bug in received countryCode string for Singapore, it's code is "SG"
        if self == "SP" {
            return "🇸🇬"
        }
        return self.unicodeScalars.map({127397 + $0.value})
            .compactMap(UnicodeScalar.init)
            .map(String.init)
        .joined()
    }
    
}

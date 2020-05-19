//
//  Breed.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 30.04.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation

typealias Breeds = [Breed]

struct Breed: Decodable {
    let weight: Weight
    let id: String
    let name: String
    let cfaUrl: String?
    let vetstreetUrl: String?
    let vcahospitalsUrl: String?
    let temperament: String
    let origin: String
    let countryCodes: String
    let countryCode: String
    let description: String
    let lifeSpan: String
    let indoor: Int
    let lap: Int?
    let altNames: String?
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let intelligence: Int
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressedTail: Int
    let shortLegs: Int
    let wikipediaUrl: String?
    let hypoallergenic: Int
    
    enum CodingKeys: String, CodingKey {
        case weight = "weight"
        case id = "id"
        case name = "name"
        case cfaUrl = "cfa_url"
        case vetstreetUrl = "vetstreet_url"
        case vcahospitalsUrl = "vcahospitals_url"
        case temperament = "temperament"
        case origin = "origin"
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case description = "description"
        case lifeSpan = "life_span"
        case indoor = "indoor"
        case lap = "lap"
        case altNames = "alt_names"
        case adaptability = "adaptability"
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming = "grooming"
        case healthIssues = "health_issues"
        case intelligence = "intelligence"
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation = "vocalisation"
        case experimental = "experimental"
        case hairless = "hairless"
        case natural = "natural"
        case rare = "rare"
        case rex = "rex"
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case wikipediaUrl = "wikipedia_url"
        case hypoallergenic = "hypoallergenic"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weight = try values.decode(Weight.self, forKey: .weight)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        cfaUrl = try values.decodeIfPresent(String.self, forKey: .cfaUrl)
        vetstreetUrl = try values.decodeIfPresent(String.self, forKey: .vetstreetUrl)
        vcahospitalsUrl = try values.decodeIfPresent(String.self, forKey: .vcahospitalsUrl)
        temperament = try values.decode(String.self, forKey: .temperament)
        origin = try values.decode(String.self, forKey: .origin)
        countryCodes = try values.decode(String.self, forKey: .countryCodes)
        countryCode = try values.decode(String.self, forKey: .countryCode)
        description = try values.decode(String.self, forKey: .description)
        lifeSpan = try values.decode(String.self, forKey: .lifeSpan)
        indoor = try values.decode(Int.self, forKey: .indoor)
        lap = try values.decodeIfPresent(Int.self, forKey: .lap)
        altNames = try values.decodeIfPresent(String.self, forKey: .altNames)
        adaptability = try values.decode(Int.self, forKey: .adaptability)
        affectionLevel = try values.decode(Int.self, forKey: .affectionLevel)
        childFriendly = try values.decode(Int.self, forKey: .childFriendly)
        dogFriendly = try values.decode(Int.self, forKey: .dogFriendly)
        energyLevel = try values.decode(Int.self, forKey: .energyLevel)
        grooming = try values.decode(Int.self, forKey: .grooming)
        healthIssues = try values.decode(Int.self, forKey: .healthIssues)
        intelligence = try values.decode(Int.self, forKey: .intelligence)
        sheddingLevel = try values.decode(Int.self, forKey: .sheddingLevel)
        socialNeeds = try values.decode(Int.self, forKey: .socialNeeds)
        strangerFriendly = try values.decode(Int.self, forKey: .strangerFriendly)
        vocalisation = try values.decode(Int.self, forKey: .vocalisation)
        experimental = try values.decode(Int.self, forKey: .experimental)
        hairless = try values.decode(Int.self, forKey: .hairless)
        natural = try values.decode(Int.self, forKey: .natural)
        rare = try values.decode(Int.self, forKey: .rare)
        rex = try values.decode(Int.self, forKey: .rex)
        suppressedTail = try values.decode(Int.self, forKey: .suppressedTail)
        shortLegs = try values.decode(Int.self, forKey: .shortLegs)
        wikipediaUrl = try values.decodeIfPresent(String.self, forKey: .wikipediaUrl)
        hypoallergenic = try values.decode(Int.self, forKey: .hypoallergenic)
    }
    
}

struct Weight: Decodable {
    let imperial: String
    let metric: String
}

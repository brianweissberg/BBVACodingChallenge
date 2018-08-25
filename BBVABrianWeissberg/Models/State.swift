//
//  State.swift
//  BBVABrianWeissberg
//
//  Created by Brian Weissberg on 8/25/18.
//  Copyright © 2018 Brian Weissberg. All rights reserved.
//

import Foundation

struct State: Decodable {
    
    let country: String
    let name: String
    let abbreviation: String
    let area: String
    let largestCity: String?
    let capital: String
}

extension State {
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case abbreviation = "abbr"
        case area
        case largestCity = "largest_city"
        case capital
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decode(String.self, forKey: .country)
        name = try values.decode(String.self, forKey: .name)
        abbreviation = try values.decode(String.self, forKey: .abbreviation)
        area = try values.decode(String.self, forKey: .area)
        capital = try values.decode(String.self, forKey: .capital)
        
        if values.contains(.largestCity) {
            let city = try values.decode(String.self, forKey: .largestCity)
            self.largestCity = city
        } else {
            self.largestCity = nil
        }
    }
}

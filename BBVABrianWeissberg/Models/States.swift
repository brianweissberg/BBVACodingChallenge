//
//  States.swift
//  BBVABrianWeissberg
//
//  Created by Brian Weissberg on 8/25/18.
//  Copyright © 2018 Brian Weissberg. All rights reserved.
//

import Foundation

struct States: Decodable {
    
    var states = [State]()
    
    enum CodingKeys: String, CodingKey {
        case restResponse = "RestResponse"
    }
    
    enum RestResponseKeys: String, CodingKey {
        case result
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let results = try values.nestedContainer(keyedBy: RestResponseKeys.self, forKey: .restResponse)
        let states = try results.decode([State].self, forKey: .result)
        
        self.states = states
    }
}


//
//  Manifest.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 12.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation

struct Manifest: Codable {
    
    var name: String
    var landingDate: String
    var maxSol: Int
    var maxDate: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case landingDate = "landing_date"
        case maxSol = "max_sol"
        case maxDate = "max_date"
    }
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        self.landingDate = try container.decode(String.self, forKey: CodingKeys.landingDate)
        self.maxSol = try container.decode(Int.self, forKey: CodingKeys.maxSol)
        self.maxDate = try container.decode(String.self, forKey: CodingKeys.maxDate)
        
    }
    
}

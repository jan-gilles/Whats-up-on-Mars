//
//  Camera.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 02.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation

struct Camera: Codable {
    
    var name: String
    var fullName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.fullName = try valueContainer.decode(String.self, forKey: CodingKeys.fullName)
    }
    
    init(name: String, fullName: String) {
        self.name = name
        self.fullName = fullName
    }
}

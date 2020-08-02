//
//  Photo.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 02.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation

struct Photo: Codable, Identifiable {
    
    var id: Int
    var sol: Int
    var camera: Camera
    var imageSource: URL
    var earthDate: String // Date
    var rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sol = "sol"
        case camera = "camera"
        case imageSource = "img_src"
        case earthDate = "earth_date"
        case rover = "rover"
    }
    
}

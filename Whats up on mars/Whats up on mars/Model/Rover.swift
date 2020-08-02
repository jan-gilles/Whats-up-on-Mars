//
//  Rover.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 02.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation

struct Rover: Codable, Identifiable {
    
    var id: Int
    var name: String
    var landingDate: String
    var launchDate: String
    var status: String
    var maxSol: Int?
    var maxDate: String?
    var totalImages: Int?
    var cameras: [Camera]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status = "status"
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalImages = "total_photos"
        case cameras = "cameras"
    }
}

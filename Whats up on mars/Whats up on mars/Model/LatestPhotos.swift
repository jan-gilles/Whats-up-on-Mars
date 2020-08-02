//
//  LatestPhotos.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 02.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation

struct LatestPhotos: Codable {
    
    var latestPhotos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case latestPhotos = "latest_photos"
    }
}

//
//  MissionManifestResponse.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 12.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation

struct MissionManifestResponse: Codable {
    var manifest: Manifest?
    
    enum CodingKeys: String, CodingKey {
        case manifest = "photo_manifest"
    }
}

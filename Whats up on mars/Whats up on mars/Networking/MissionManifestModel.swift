//
//  MissionManifestModel.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 12.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI
import Combine

class MissionManifestModel: ObservableObject {
    
    @Published var manifests: [Manifest] = []
    var cancellable: AnyCancellable?
    
    init() {
        getManifests()
    }
    
    func getManifests() {
        cancellable = ModelController.shared.fetchMissionManifest()
            .sink(receiveValue: { responses in
                var manifests: [Manifest] = []
                
                for response in responses {
                    if let manifest = response.manifest {
                        manifests.append(manifest)
                    }
                }
                
                
                self.manifests = manifests
            })
    }
    
}

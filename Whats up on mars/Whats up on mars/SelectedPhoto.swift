//
//  SelectedPhoto.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 08.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

class SelectedPhoto: ObservableObject {
    
    @Published var photo: UIImage?
    @Published var photoInfo: Photo?
}

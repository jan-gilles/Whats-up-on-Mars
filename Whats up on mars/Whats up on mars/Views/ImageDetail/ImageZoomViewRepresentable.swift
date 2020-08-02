//
//  ImageZoomViewRepresentable.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 08.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct ImageZoomViewRepresentable: UIViewRepresentable {
    
    var image: UIImage
    var frame: CGRect
    
    func makeUIView(context: Context) -> ImageZoomView {
        return ImageZoomView(frame: self.frame, image: self.image)
    }
    
    func updateUIView(_ uiView: ImageZoomView, context: Context) {
        uiView.imageView.image = image
    }
    
}

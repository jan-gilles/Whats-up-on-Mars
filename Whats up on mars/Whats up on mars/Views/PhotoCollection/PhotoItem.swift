//
//  PhotoItem.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 04.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct PhotoItem: View {
    
    var photo: UIImage
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: self.photo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .clipped()
                .cornerRadius(15.0)
                .shadow(radius: 8.0)
        }
    }
}

struct PhotoItem_Previews: PreviewProvider {
    static var previews: some View {
        PhotoItem(photo: UIImage())
    }
}

//
//  BrowseCameraCell.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 04.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct BrowseCameraCell: View {
    
    let camera: Camera
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.white)
                    .frame(width: nil, height: geometry.size.height, alignment: .center)
                    .cornerRadius(8.0)
                    .shadow(radius: 5.0)
                HStack {
                    Image(self.camera.name)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60, alignment: .center)
                        .clipped()
                        .clipShape(Circle())
                        .padding(8.0)
                    Text("\(self.camera.name) (\(self.camera.fullName))")
                        .padding(.trailing, 8.0)
                        .foregroundColor(Color.black)
                    Spacer()
                }
            }
        }
    }
}

struct BrowseCameraCell_Previews: PreviewProvider {
    static var previews: some View {
        BrowseCameraCell(camera: Camera(name: "abc", fullName: "defghijklnmop"))
    }
}

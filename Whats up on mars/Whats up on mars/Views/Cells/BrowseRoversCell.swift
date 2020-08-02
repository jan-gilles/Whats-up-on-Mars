//
//  BrowseRoversCell.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 03.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct BrowseRoversCell: View {
    
    let name: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Image(self.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: 150.0, alignment: .center)
                    .clipped()
                    .cornerRadius(20.0)
                
                Image(self.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: 40.0, alignment: .bottom)
                    .clipped()
                    .blur(radius: 15.0, opaque: true)
                    .cornerRadius(20.0)
                
                Text(self.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(10.0)
            }
            .shadow(color: .gray, radius: 6.0, x: 0.0, y: 0.0)
        }
        
    }
}

struct BrowseRoversCell_Previews: PreviewProvider {
    static var previews: some View {
        BrowseRoversCell(name: "Curiosity")
    }
}

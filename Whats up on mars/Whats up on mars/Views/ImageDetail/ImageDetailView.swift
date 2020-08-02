//
//  ImageDetailView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 08.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct ImageDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var photo: UIImage
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 25.0, weight: .medium, design: .default))
                            .foregroundColor(Color.gray)
                    }
                    .padding(.top, 20.0)
                    .padding(.leading, 8.0)
                    .padding(.bottom, 8.0)
                    
                    Spacer()
                }
                
                ImageZoomViewRepresentable(image: self.photo, frame: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))
            }
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(photo: UIImage())
    }
}

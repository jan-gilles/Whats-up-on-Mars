//
//  PhotoView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 08.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct PhotoView: View {
    
    var photo: UIImage
    var photoInfo: Photo?
    private let infoSpacing: CGFloat = 15.0
    
    @State var showImageDetail = false
    
    var body: some View {
        VStack {
            VStack {
                Image(uiImage: self.photo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15.0)
                    .padding(.bottom, 20.0)
                    .onTapGesture {
                        self.showImageDetail = true
                    }
                HStack(alignment: .top, spacing: 10.0) {
                    VStack(alignment: .leading, spacing: self.infoSpacing) {
                        Text("Rover:")
                        Text("Date:")
                        Text("Camera:")
                    }
                    VStack(alignment: .leading, spacing: self.infoSpacing) {
                        Text(
                            self.photoInfo?.rover.name ?? "Information not found"
                        )
                        Text(
                            "\(self.photoInfo?.earthDate ?? "Information not found") (Sol \(self.photoInfo?.sol ?? -1))"
                        )
                        Text(
                            "\(self.photoInfo?.camera.name ?? "Information not found") (\(self.photoInfo?.camera.fullName ?? ""))"
                        )
                    }
                    Spacer()
                }
                
                Spacer()
            }
        }.sheet(isPresented: $showImageDetail) {
            ImageDetailView(photo: self.photo)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: UIImage(), photoInfo: nil)
    }
}

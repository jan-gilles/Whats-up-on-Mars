//
//  BrowseCameraView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 04.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct BrowseCameraView: View {
    
    @EnvironmentObject var manifests: MissionManifestModel
    
    var cameras: [Camera] = []
    let roverName: String
    
    let navBarAppearance = UINavigationBarAppearance()
    
    init(roverName: String) {
        UITableView.appearance().separatorColor = .clear
        
        self.roverName = roverName
        
        guard let cameras = RoverInfo.rovers[roverName]?.cameras else { return }
        
        self.cameras = cameras
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                
                GeometryReader { (geometry: GeometryProxy) in
                    if geometry.frame(in: .global).minY <= 0 {
                        Image(self.roverName + "Header")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .cornerRadius(20.0)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY * 0.8)
                    } else {
                        Image(self.roverName + "Header")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .cornerRadius(20.0)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                    
                    
                }
                .zIndex(1)
                .frame(height: 150.0)
                
                
                VStack {
                    ForEach(self.cameras, id: \.name) { camera in
                        NavigationLink(destination: BrowseCameraDateView(roverName: self.roverName, camera: camera).environmentObject(self.manifests)) {
                            BrowseCameraCell(camera: camera)
                                .frame(width: nil, height: 80, alignment: .center)
                                .padding(8.0)
                        }
                    }
                }
                .zIndex(0)
                .padding()
                
            }
            
        }
        .navigationBarTitle(Text(roverName), displayMode: .large)
        .edgesIgnoringSafeArea(.top)
    }
}

struct BrowseCameraView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseCameraView(roverName: "Curiosity")
    }
}

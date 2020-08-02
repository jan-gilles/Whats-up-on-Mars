//
//  BrowseCameraDateView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 05.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct BrowseCameraDateView: View {
    
    let camera: Camera
    let roverName: String
    
    @ObservedObject var photosModel: BrowseDateViewModel
    @EnvironmentObject var manifests: MissionManifestModel
    
    //var everySol = Array(0...1000)
    @State var sol = 0
    
    @State var showPicker = true
    
    init(roverName: String, camera: Camera) {
        self.camera = camera
        self.roverName = roverName
        
        self.photosModel = BrowseDateViewModel()
    }
    
    func getAvailbaleSols(manifest: MissionManifestModel) -> [Int] {
        guard let manifestIndex = manifests.manifests.firstIndex(where: { manifest -> Bool in
            return manifest.name.lowercased() == roverName.lowercased()
        }) else { return Array(0...1000) }

        let manifest = manifests.manifests[manifestIndex]

        return Array(0...manifest.maxSol)
    }
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ZStack {
                VStack {
                    ZStack(alignment: .top) {
                        Image(self.roverName + "Header")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.safeAreaInsets.top)
                            .clipped()
                            .edgesIgnoringSafeArea(.top)
                        
                        Text(self.camera.name)
                            .foregroundColor(Color.white)
                            .offset(y: -85.0)
                            .font(.headline)
                        
                        Image(self.camera.name)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80.0, height: 80.0, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 3.0))
                            .offset(y: -40.0)
                        
                        
                        
                    }.padding(.bottom, -90.0)
                    
                    if self.showPicker {
                        Picker(selection: self.$sol, label: Text("Sol")) {
                            ForEach(self.getAvailbaleSols(manifest: self.manifests), id: \.self) { sol in
                                Text("Sol \(sol)")
                            }
                        }.labelsHidden()
                        
                        
                        HStack {
                            if self.photosModel.photos.count > 0 {
                                Button(action: {
                                    withAnimation {
                                        self.showPicker = false
                                    }
                                }) {
                                    Text("Cancel")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.gray)
                                        .foregroundColor(Color.white)
                                        .font(.headline)
                                        .cornerRadius(8.0)
                                }
                            }
                            
                            Button(action: {
                                withAnimation {
                                    self.photosModel.getPhotos(rovers: [self.roverName], sol: self.sol, date: nil, camera: self.camera, pages: nil)
                                    self.showPicker = false
                                }
                            }) {
                                Text("Load")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .font(.headline)
                                    .cornerRadius(8.0)
                            }
                        }
                        .frame(width: geometry.size.width - 40, height: nil, alignment: .center)
                        
                    } else {
                        ZStack {
                            Color.white
                                .frame(width: nil, height: 50.0, alignment: .center)
                                .cornerRadius(8.0)
                                .shadow(radius: 8.0)
                            HStack {
                                Text("Sol \(self.sol)")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }.padding()
                        }
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                self.showPicker = true
                            }
                        }
                    }
                    
                    
                    PhotoCollectionView(photos: self.photosModel.photos, photoInfos: self.photosModel.photosInfo)
                }.navigationBarTitle(Text(""), displayMode: .large)
                
                
                ActivityIndicator(shouldAnimate: self.photosModel.shouldAnimateActivityIndicator)
            }
            
        }
    }
}

struct BrowseCameraDateView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseCameraDateView(roverName: "abcd", camera: Camera(name: "efg", fullName: "hijklmnop"))
    }
}

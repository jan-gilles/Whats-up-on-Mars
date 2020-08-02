//
//  ContentView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 02.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var selectedPhoto: SelectedPhoto
    @EnvironmentObject var manifests: MissionManifestModel
    
    var body: some View {
        TabView {
            LatestPhotoView()
            .tabItem {
                Image(systemName: "clock")
                Text("Newest")
            }
            
            BrowsePhotosView().environmentObject(manifests)
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }
        }.sheet(item: $selectedPhoto.photoInfo) { photoInfo in
            PhotoView(photo: self.selectedPhoto.photo ?? UIImage(), photoInfo: photoInfo)
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  BrowsePhotosView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 03.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct BrowsePhotosView: View {
    
    @EnvironmentObject var manifests: MissionManifestModel
    
    enum BrowseModes: String {
        case rover = "Rover"
        case date = "Date"
    }
    
    @State private var browseMode = BrowseModes.rover
    @State var presentCameraView = false
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $browseMode, label: Text("Browse by")) {
                    Text(BrowseModes.rover.rawValue).tag(BrowseModes.rover)
                    Text(BrowseModes.date.rawValue).tag(BrowseModes.date)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                containedView(browseMode: browseMode)
                Spacer()
            }
            .padding(20.0)
            .navigationBarTitle(Text("Browse by \(browseMode.rawValue)"))
        }
    }
    
    func containedView(browseMode: BrowseModes) -> AnyView {
        switch browseMode {
        case .rover:
            return AnyView(
                GeometryReader { geometry in
                    List(RoverInfo.rovers.values.sorted(by: { (rover1, rover2) -> Bool in
                        rover1.id < rover2.id
                    }), rowContent: { rover in
                        ZStack {
                            BrowseRoversCell(name: rover.name)
                                .frame(width: nil, height: 130.0, alignment:.top)
                                .padding(20.0)
                        
                            NavigationLink(destination: BrowseCameraView(roverName: rover.name).environmentObject(self.manifests)) {
                                EmptyView()
                            }.buttonStyle(PlainButtonStyle())
                        }
                    })
                }
            )
        case .date:
            return AnyView(BrowseDateView())
        }
    }
}

struct BrowsePhotosView_Previews: PreviewProvider {
    static var previews: some View {
        BrowsePhotosView()
    }
}

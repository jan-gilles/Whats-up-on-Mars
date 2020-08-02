//
//  LatestPhotoView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 03.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI
import Combine

struct LatestPhotoView: View {
    
    private let infoSpacing: CGFloat = 15.0
    
    @ObservedObject var viewModel = LatestPhotoViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        HStack {
                            Text("There were last transmitted \(viewModel.numberOfPhotos) photos")
                            Spacer()
                            Button(action: {
                                self.viewModel.randomImage()
                            }) {
                                Text("Show Other")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(8.0)
                            }
                        }.padding()
                        PhotoView(photo: viewModel.latestPhoto, photoInfo: viewModel.latestPhotoInfo)
                            .padding()
                            .navigationBarTitle(Text("Newest Photo"))
                    }
                }
                
                ActivityIndicator(shouldAnimate: viewModel.shouldAnimateActivityIndicator)
            }
        }
    }
}

struct LatestPhotoView_Previews: PreviewProvider {
    
    static var previews: some View {
        LatestPhotoView()
    }
}

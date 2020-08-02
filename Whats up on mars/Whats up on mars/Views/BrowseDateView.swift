//
//  BrowseDateView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 03.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct BrowseDateView: View {
    
    @State var selectedDate = Date()
    
    @ObservedObject var photoModel = BrowseDateViewModel()
    
    @State var showPicker = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    if self.showPicker {
                        DatePicker("Date", selection: self.$selectedDate, in: Date(timeIntervalSince1970: 1073260800)...Date(), displayedComponents: .date)
                            .labelsHidden()
                        
                        HStack {
                            if self.photoModel.photos.count > 0 {
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
                                    self.photoModel.getPhotos(rovers: nil, sol: nil, date: self.selectedDate, camera: nil, pages: nil)
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
                                Text(self.selectedDate.formatted())
                                Spacer()
                                Image(systemName: "chevron.down")
                            }.padding()
                        }
                        .padding(.top, 8.0)
                        .padding(.bottom, 8.0)
                        .onTapGesture {
                            withAnimation {
                                self.showPicker = true
                            }
                        }
                    }
                    
                    
                    PhotoCollectionView(photos: self.photoModel.photos, photoInfos: self.photoModel.photosInfo)
                }
                
                ActivityIndicator(shouldAnimate: self.photoModel.shouldAnimateActivityIndicator)
            }
        }
    }
}

struct BrowseDateView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseDateView()
    }
}

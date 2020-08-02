//
//  PhotoCollectionView.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 04.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI

struct PhotoCollectionView: View {
    
    var photos: [UIImage]
    var photoInfos: [Photo]
    var rowCount: Int
    
    @EnvironmentObject var selectedPhoto: SelectedPhoto
    
    init(photos: [UIImage], photoInfos: [Photo]) {
        UITableView.appearance().separatorColor = .clear
        self.photos = photos
        self.photoInfos = photoInfos
        
        let rows = CGFloat(photos.count) / 2.0
        rowCount = Int(rows.rounded(.up))
    }
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(0..<self.rowCount, id: \.self) { i in
                    HStack {
                        PhotoItem(photo: self.photos[self.firstIndex(i)])
                            .frame(width: nil, height: 150, alignment: .center)
                            .padding(8.0)
                            .onTapGesture {
                                self.selectedPhoto.photo = self.photos[self.firstIndex(i)]
                                self.selectedPhoto.photoInfo = self.photoInfos[self.firstIndex(i)]
                            }
                        
                        if self.secondIndex(i) < self.photos.count {
                            PhotoItem(photo: self.photos[self.secondIndex(i)])
                                .frame(width: nil, height: 150, alignment: .center)
                                .padding(8.0)
                                .onTapGesture {
                                    self.selectedPhoto.photo = self.photos[self.secondIndex(i)]
                                    self.selectedPhoto.photoInfo = self.photoInfos[self.secondIndex(i)]
                                }
                        }
                    }
                }
            }
        }
    }
    
    
    func firstIndex(_ i: Int) -> Int {
        return 2*i
    }
    
    func secondIndex(_ i: Int) -> Int {
        return 2*i + 1
    }
}

struct PhotoCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCollectionView(photos: [], photoInfos: [])
    }
}

//
//  LatestPhotoViewModel.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 05.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI
import Combine

class LatestPhotoViewModel: ObservableObject {
    
    @Published var latestPhoto = UIImage()
    @Published var latestPhotoInfo: Photo?
    @Published var numberOfPhotos: Int = 0
    @Published var shouldAnimateActivityIndicator = false
    
    var latestPhotosInfoCancellable: AnyCancellable?
    var latestPhotoCancellable: AnyCancellable?
    
    private var latestInfos: [Photo] = []
    
    init() {
        getPhoto()
    }
    
    func getPhoto() {
        shouldAnimateActivityIndicator = true
        
        latestPhotosInfoCancellable = ModelController.shared.fetchNewestImages().sink(receiveValue: { latestPhotos in
            
            let photoInfo = latestPhotos.flatMap { $0.latestPhotos }
           
            guard let latestPhoto = photoInfo.last else { return }
            let url = latestPhoto.imageSource
            
            self.latestPhotoInfo = latestPhoto
            self.numberOfPhotos = photoInfo.count
            self.latestInfos = photoInfo
            
            self.fetchImage(url: url)
        })
    }
    
    
    func fetchImage(url: URL) {
        shouldAnimateActivityIndicator = true
        
        self.latestPhotoCancellable = ModelController.shared.fetchImage(fromURL: url)
        .sink(receiveValue: { image in
            self.shouldAnimateActivityIndicator = false
            guard let image = image else { return }
            self.latestPhoto = image
        })
    }
    
    
    func randomImage() {
        self.shouldAnimateActivityIndicator = true
        let rnd = Int.random(in: 0..<numberOfPhotos)
        
        self.latestPhotoInfo = latestInfos[rnd]
        
        fetchImage(url: latestPhotoInfo!.imageSource)
    }
}

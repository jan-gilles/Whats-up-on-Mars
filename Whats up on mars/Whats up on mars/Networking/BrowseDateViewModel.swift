//
//  BrowseDateViewModel.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 08.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import SwiftUI
import Combine

class BrowseDateViewModel: ObservableObject {
    
    @Published var photosInfo: [Photo] = []
    @Published var photos: [UIImage] = []
    @Published var shouldAnimateActivityIndicator = false
    
    var photosInfoCancellable: AnyCancellable?
    var photosCancellables: [AnyCancellable] = []
    
    func getPhotos(rovers: [String]?, sol: Int?, date: Date?, camera: Camera?, pages: Int?) {
        shouldAnimateActivityIndicator = true
        
        let allRovers = ["curiosity", "opportunity", "spirit"]
        
        photosInfoCancellable = ModelController.shared.fetchImageInfo(rovers: rovers ?? allRovers, earthDate: date, sol: sol, camera: camera, pages: pages)
            .sink(receiveValue: { photoResponses in
                
                self.photos = []
                self.photosCancellables = []
                
                let photosInfo = photoResponses.flatMap { $0.photos }
                self.photosInfo = photosInfo
                
                if photosInfo.count == 0 {
                    self.shouldAnimateActivityIndicator = false
                }
                
                for info in photosInfo {
                    self.photosCancellables.append(
                        ModelController.shared.fetchImage(fromURL: info.imageSource)
                            .sink(receiveValue: { image in
                                
                                if self.shouldAnimateActivityIndicator == true {
                                    self.shouldAnimateActivityIndicator = false
                                }
                                
                                guard let image = image else { return }
                                
                                self.photos.append(image)
                                
                            })
                    )
                }
            })
    }
}

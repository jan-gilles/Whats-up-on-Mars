//
//  ModelController.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 02.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


class ModelController {
    
    private let apiKey = "N4eh1v5yK7UlImOFnyQeXEG30V9v2AJHG4PJeKZQ"
    
    static let shared = ModelController()
    
    private let apiClient = APIClient()
    
    private let baseURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1")
    
    func fetchNewestImages() -> AnyPublisher<[LatestPhotos], Never> {
        
        let query = [
            "api_key" : apiKey
        ]
        
        let url = baseURL?.appendingPathComponent("rovers")
        
        var urls: [URL] = []
        
        for rover in RoverInfo.rovers.values {
            let newURL = url?.appendingPathComponent(rover.name).appendingPathComponent("latest_photos").withQueries(query)
            
            if let newURL = newURL { urls.append(newURL) }
            
            
        }
        
        
        
        let requests = urls.map { URLRequest(url: $0) }
        
        var publishers: [AnyPublisher<LatestPhotos, Never>] = []
        
        for request in requests {
            publishers.append(
                apiClient.run(request)
                    .catch { error -> Just<LatestPhotos> in
                        let error = error as NSError
                        print(error.userInfo)
                        return Just(LatestPhotos(latestPhotos: []))
                    }
                    .eraseToAnyPublisher()
            )
        }
        
        return mergePublishers(publishers: publishers)
    }
    
    
    func fetchImage(fromURL url: URL) -> AnyPublisher<UIImage?, Never> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                let data = $0.data
                let image = UIImage(data: data)
                return image
            }
            .catch { error -> Just<UIImage?> in
                let error = error as NSError
                print(error.userInfo)
                return Just(nil)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    
    func fetchImageInfo(rovers: [String], earthDate: Date?, sol: Int?, camera: Camera?, pages: Int?) -> AnyPublisher<[PhotosResponse], Never> {
        
        var useSol = true
        
        var query = [
            "api_key" : apiKey
        ]
        
        if let earthDate = earthDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            query["earth_date"] = formatter.string(from: earthDate)
            useSol = false
        }
        
        if useSol, let sol = sol {
            query["sol"] = String(sol)
        }
        
        if let camera = camera {
            query["camera"] = camera.name
        }
        
        if let pages = pages {
            query["page"] = String(pages)
        }
        
        var urls: [URL] = []
        
        for rover in rovers {
            let url = baseURL?
                .appendingPathComponent("rovers")
                .appendingPathComponent(rover)
                .appendingPathComponent("photos")
                .withQueries(query)
            
            if let url = url { urls.append(url) }
        }
        
        let requests = urls.map { URLRequest(url: $0) }
         
        var publishers: [AnyPublisher<PhotosResponse, Never>] = []
        
        for request in requests {
            publishers.append(
                apiClient.run(request)
                    .catch({ error -> Just<PhotosResponse> in
                        let error = error as NSError
                        print(error.userInfo)
                        return Just(PhotosResponse(photos: []))
                    })
                    .eraseToAnyPublisher()
            )
        }
        
        return mergePublishers(publishers: publishers)
        
    }
    
    
    func fetchMissionManifest() -> AnyPublisher<[MissionManifestResponse], Never> {
        let query = [
            "api_key" : apiKey
        ]
        
        let url = baseURL?.appendingPathComponent("manifests")
        
        var urls: [URL] = []
        
        for rover in RoverInfo.rovers.values {
            let newURL = url?.appendingPathComponent(rover.name).withQueries(query)
            
            if let newURL = newURL { urls.append(newURL) }
        }
        
        let requests = urls.map { URLRequest(url: $0) }
        var publishers: [AnyPublisher<MissionManifestResponse, Never>] = []
        
        for request in requests {
            publishers.append(
                apiClient.run(request)
                    .catch({ error -> Just<MissionManifestResponse> in
                        let error = error as NSError
                        print(error.userInfo)
                        return Just(MissionManifestResponse(manifest: nil))
                    })
                    .eraseToAnyPublisher()
            )
        }
        
        return mergePublishers(publishers: publishers)
    }
    
    
    private func mergePublishers<T>(publishers: [AnyPublisher<T, Never>]) -> AnyPublisher<[T] , Never> {
        
        let publisherOfPublishers = Publishers.Sequence<[AnyPublisher<T, Never>], Never>(sequence: publishers)
        return publisherOfPublishers
            .flatMap { $0 }
            .collect()
            .eraseToAnyPublisher()
        
    }
}

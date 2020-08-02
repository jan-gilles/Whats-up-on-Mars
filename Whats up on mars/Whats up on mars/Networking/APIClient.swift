//
//  APIClient.swift
//  Whats up on mars
//
//  Created by Jan Gilles on 03.06.20.
//  Copyright © 2020 Jan Gilles. All rights reserved.
//

import Foundation
import Combine

struct APIClient {
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

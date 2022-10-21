//
//  NetworkManager.swift
//  MVVM
//
//  Created by MRGS on 23.10.2022.
//

import Foundation
class NetworkManager: NSObject {
    
    func fetchMovies(completion: ([String]) -> ()) {
        completion(["Movie 1", "Movie 2", "Movie 3"])
    }
}

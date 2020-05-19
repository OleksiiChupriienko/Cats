//
//  ImageLoader.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 13.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    //MARK: - Private Properties
    
    private var cache = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    
    // MARK: - Initializers
    
    private init() {}
    
    
    // MARK: - Public Methods
    
    @discardableResult
    func loadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = cache[url] {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer {self.runningRequests.removeValue(forKey: uuid)}
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.cache[url] = image
                completion(.success(image))
                return
            }
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}

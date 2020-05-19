//
//  CatsServiceAPI.swift
//  Cats
//
//  Created by Aleksei Chupriienko on 09.05.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation
import UIKit

class CatsServiceAPI {
    static let shared = CatsServiceAPI()
    private let session = URLSession.shared
    private let baseURL = Constants.baseURL
    private let decoder = JSONDecoder()
    
    enum Endpoint: String {
        case breeds
        case singleImage = "images/search?order=asc&limit=1&page=0&breed_id="
        case multipleImages = "images/search?limit=25&breed_id="
    }
    
    private enum APIServiceError: Error {
        case invalidResponse
        case canNotRetrieveData
        case statusCodeError
        case invalidURLString
    }
    
    private init() {}
    
    func fetchBreeds(completion: @escaping (Result<Breeds,Error>) -> Void) {
        let breedsURL = baseURL.appending(Endpoint.breeds.rawValue)
        
        request(url: breedsURL) { (result) in
            switch result{
            case .success(let breedsData):
                do {
                    let breeds = try self.decoder.decode(Breeds.self, from: breedsData)
                    completion(.success(breeds))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func request(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(APIServiceError.invalidURLString))
            return
        }
        var request = URLRequest(url: url)
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.apiKeyHeader)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let responseUnwrapped = urlResponse as? HTTPURLResponse else {
                completion(.failure(APIServiceError.invalidResponse))
                return
            }
            switch responseUnwrapped.statusCode {
            case 200:
                guard let data = data else {
                    completion(.failure(APIServiceError.canNotRetrieveData))
                    return
                }
                completion(.success(data))
            default:
                completion(.failure(APIServiceError.statusCodeError))
            }
        }
        task.resume()
    }
    
    func fetchImageURLs(id: String, for endpoint: Endpoint, completion: @escaping (Result<[String], Error>) -> Void) {
        let imageURL = baseURL.appending(endpoint.rawValue).appending(id)
        request(url: imageURL) {  (result) in
            switch result {
            case .success(let response):
                do {
                    let imageDataResponse = try self.decoder.decode(ImageDataResponse.self, from: response)
                    let urls = imageDataResponse.map {$0.url}
                    completion(.success(urls))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

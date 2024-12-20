//
//  ApiManager.swift
//  NewsApp
//
//  Created by Elizaveta Potapova on 11/13/24.
//

import Foundation
enum Category: String {
    case general = "general"
    case business = "business"
    case technology = "technology"
}

final class ApiManager {
    private static let apiKey = "bf02466ef2c34c509025fd744aa3a432"
    private static let baseUrl = "https://newsapi.org/v2/"
    private static let path = "top-headlines"
    
    static func getNews(from category: Category, completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        
        let stringUrl = baseUrl + path + "?category=\(category.rawValue)&language=en" + "&apiKey=\(apiKey)"
        
        
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data,
                           error: error,
                           completion: completion)
        }
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        session.resume()
        
        
    }
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        if let error = error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print("Recieved JSON: \(json ?? "No data")")
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
                completion(.success(model.articles))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
    
}


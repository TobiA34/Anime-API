//
//  NetworkingManager.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 12/08/2023.
//

import Foundation


   enum NetworkingError: Error {
       case invalidUrl
       case custom(error: Error)
       case invalidStatusCode(statusCode: Int)
       case invalidData
       case failedToDecode(error: Error)
       case failedToReloadData
   }


class NetworkingManager {
    static let shared = NetworkingManager()
    var hasError = false
    private(set) var isRefreshing =  false
    private init() {}
    
    func request<T: Codable>(_ absoluteUrl: String,
                             type: T.Type,
                             completion: @escaping (Result<T,Error>) -> Void) {
        isRefreshing = true

        guard let url = URL(string: absoluteUrl) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                if error != nil {
                    completion(.failure(NetworkingError.custom(error: error!)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...300) ~= response.statusCode else {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                    return
                    
                }
                
                
                guard let data = data else {
                    completion(.failure(NetworkingError.invalidData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch  {
                    self.hasError = true
                    completion(.failure(NetworkingError.failedToDecode(error: error)))
                }
                self.isRefreshing = false
            }
        }
        dataTask.resume()
    }
}




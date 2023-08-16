//
//  AnimeViewModel.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import Foundation

class AnimeViewModel {
    
    var showSpinner = false
    
    private(set) var animes: [Anime] = []
    
    func getAnime(completion: @escaping (Result<Void,NetworkingError>) -> Void) {
        // get request
        let url = UrlEndpoint.baseUrl.endpoint + UrlEndpoint.getAnime.endpoint
        
        NetworkingManager.shared.request(url, type: AnimeResult.self) { res in
            self.showSpinner = true
            switch res {
            case .success(let response):
               self.animes = response.data
                completion(.success(()))
            self.showSpinner = false
              case .failure:
                completion(.failure(NetworkingError.failedToReloadData))
            }
        }
        
    }
    
    func searchAnime(query: String, completion: @escaping (Result<Void,NetworkingError>) -> Void) {
        // search request
        let url = UrlEndpoint.baseUrl.endpoint + UrlEndpoint.searchAnime.endpoint + query
        
        NetworkingManager.shared.request(url, type: AnimeResult.self) { res in
            self.showSpinner = true
            switch res {
            case .success(let response):
                self.animes = response.data
                completion(.success(()))
             case .failure:
                completion(.failure(NetworkingError.failedToReloadData))
            }
            self.showSpinner = false
        }
        
    }
}

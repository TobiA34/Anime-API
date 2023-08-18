//
//  AnimeViewModel.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import Foundation

class AnimeViewModel {
        
    private(set) var animes: [Anime] = []
 
    func getAnime(page: Int, offset: Int , completion: @escaping (Result<Void,NetworkingError>) -> Void) {
        let url = BaseUrl.baseUrl.url + UrlEndpoint.getAnime.endpoint + "?" + UrlEndpoint.pagination.endpoint + "\(page)&page[offset]=\(offset)"
        
        NetworkingManager.shared.request(url, type: AnimeResult.self) { res in
 
            switch res {
            case .success(let response):
               self.animes = response.data
                completion(.success(()))
              case .failure(let error):
                completion(.failure(.custom(error: error)))
            }
         }
        
    }
    
    func searchAnime(query: String, completion: @escaping (Result<Void,NetworkingError>) -> Void) {
        // search request
        let url = BaseUrl.baseUrl.url + UrlEndpoint.searchAnime.endpoint + query
 
        NetworkingManager.shared.request(url, type: AnimeResult.self) { res in
            switch res {
            case .success(let response):
                self.animes = response.data
                completion(.success(()))
             case .failure(let error):
                completion(.failure(.custom(error: error)))
                
            }
         }
        
    }
}

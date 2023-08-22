//
//  AnimeViewModel.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import Foundation

class AnimeViewModel {
    
    private(set) var animes: [Anime] = []
    private var queryObject = QueryObject()

 
    func fetchAnime(page: Int, completion: @escaping (Result<Void,NetworkingError>) -> Void) {
        
        guard var urlComps = URLComponents(string:  BaseUrl.baseUrl.url + UrlEndpoint.getAnime.endpoint + UrlEndpoint.pagination.endpoint) else { return }


        urlComps.queryItems = queryObject.paginationQuery(pageValue: page)
        guard let animeUrl = urlComps.url else { return }
        let animeRequest = URLRequest(url: animeUrl)
        guard let animeAbsoluteString = animeRequest.url?.absoluteString else { return }

        NetworkingManager.shared.request(animeAbsoluteString, type: AnimeResult.self) { res in
            
        switch res {
            case .success(let response):
                self.animes = response.data
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.custom(error: error)))
            }
        }
        
    }
    
    func getAnime(completion: @escaping (Result<Void,NetworkingError>) -> Void) {
        
        guard let url = URL(string: BaseUrl.baseUrl.url + UrlEndpoint.getAnime.endpoint) else { return }
        let animeRequest = URLRequest(url: url)
        guard let animeAbsoluteString = animeRequest.url?.absoluteString else { return }
        
        NetworkingManager.shared.request(animeAbsoluteString, type: AnimeResult.self) { res in
            
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
         guard var urlComps = URLComponents(string:  BaseUrl.baseUrl.url + UrlEndpoint.searchAnime.endpoint + query) else { return }

        let queryItems = [URLQueryItem(name: "filter[text]", value: "\(query)")]
        
        urlComps.queryItems = queryItems
        guard let animeUrl = urlComps.url else { return }
        let animeRequest = URLRequest(url: animeUrl)
        guard let animeAbsoluteString = animeRequest.url?.absoluteString else { return }
        
        NetworkingManager.shared.request(animeAbsoluteString, type: AnimeResult.self) { res in
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

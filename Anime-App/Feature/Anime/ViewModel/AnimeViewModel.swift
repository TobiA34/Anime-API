//
//  AnimeViewModel.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import Foundation

class AnimeViewModel {
    
    private(set) var animes: [Anime] = []
 
    func fetchAnime(page: Int, completion: @escaping (Result<Void,NetworkingError>) -> Void) {
        NetworkingManager.shared.request(.fetchAnime(page: page), type: AnimeResult.self) { res in
            
        switch res {
            case .success(let response):
            response.data.forEach { anime in
                if !self.animes.contains(where: {$0.attributes?.slug == anime.attributes?.slug}) {
                    self.animes.append(anime)
                }
            }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.custom(error: error)))
            }
        }
        
    }

    
    func searchAnime(query: String, completion: @escaping (Result<Void,NetworkingError>) -> Void) {
        NetworkingManager.shared.request(.search(for: query), type: AnimeResult.self) { res in
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

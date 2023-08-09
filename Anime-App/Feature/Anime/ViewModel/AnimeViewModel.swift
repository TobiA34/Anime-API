//
//  AnimeViewModel.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import Foundation

class AnimeViewModel {
    func getAnime(completion: @escaping (Result<[Anime], Error>) -> Void) {
        // get request
        guard let url = URL(string: "https://kitsu.io/api/edge/anime") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                guard let data = data else {return}
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let anime = try decoder.decode(AnimeResult.self, from: data)
                completion(.success(anime.data))
                print(anime)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func searchAnime(query: String, completion: @escaping (Result<[Anime], Error>) -> Void) {
        // search request
        let url = "https://kitsu.io/api/edge/anime?filter[text]=\(query)"

        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                guard let data = data else {return}
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let anime = try decoder.decode(AnimeResult.self, from: data)
                completion(.success(anime.data))
                print(anime)
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}

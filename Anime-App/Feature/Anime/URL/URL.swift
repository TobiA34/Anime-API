//
//  URL.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 12/08/2023.
//

import Foundation

enum UrlEndpoint {
    case baseUrl
    case getAnime
    case searchAnime
}

extension UrlEndpoint {
    var endpoint: String {
        switch self {
        case .baseUrl:
            return "https://kitsu.io/api/edge"
        case .getAnime:
            return "/anime"
        case .searchAnime:
            return "/anime?filter[text]="
        }
    }
}

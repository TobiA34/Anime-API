//
//  URL.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 12/08/2023.
//

import Foundation

enum UrlEndpoint {
    case getAnime
}


extension UrlEndpoint {
    var endpoint: String {
        switch self {
        case .getAnime:
            return "/anime"
        }
    }
    
}


enum URLPath {
    case animepath
}

extension URLPath {
    var url: String {
        switch self {
        case.animepath:
            return "/api/edge"
        }
    }
}

enum BaseUrl {
    case baseUrl
}

extension BaseUrl {
    var url: String {
        switch self {
        case .baseUrl:
            return " https://kitsu.io/api/edge"
        }
    }
}

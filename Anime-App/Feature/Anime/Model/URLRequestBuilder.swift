//
//  QueryObject.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 22/08/2023.
//

import Foundation

struct URLRequestBuilder {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension URLRequestBuilder {

    static func search(for query: String) -> Self {
        URLRequestBuilder(path: URLPath.animepath.url + UrlEndpoint.getAnime.endpoint,
                 queryItems: [URLQueryItem(name: "filter[text]", value: query)])
    }
    static func fetchAnime(page: Int) -> Self {
        URLRequestBuilder(path:URLPath.animepath.url + UrlEndpoint.getAnime.endpoint,
                 queryItems: [URLQueryItem(name: "page[offset]", value: "\(page)")])
    }
}

extension URLRequestBuilder {
    var url: URL? {
       var urlComps = URLComponents()
        urlComps.scheme = "https"
        urlComps.host = "kitsu.io"
        urlComps.path =  path
        urlComps.queryItems = queryItems

        return urlComps.url
            
    }
}


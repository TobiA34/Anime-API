//
//  QueryObject.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 22/08/2023.
//

import Foundation

class QueryObject {
    
    func paginationQuery(pageValue: Int) -> [URLQueryItem] {
        let queryItems = [URLQueryItem(name: "page[limit]", value: "\(pageValue)")]
        return queryItems
    }
}

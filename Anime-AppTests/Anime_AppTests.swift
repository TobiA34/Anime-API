//
//  Anime_AppTests.swift
//  Anime-AppTests
//
//  Created by Tobi Adegoroye on 21/08/2023.
//

import XCTest
@testable import Anime_App


final class Anime_AppTests: XCTestCase {
    var queryObject: QueryObject!

    override func setUpWithError() throws {
        queryObject = QueryObject()
    }

    override func tearDownWithError() throws {
        queryObject = nil
    }
   
    func testPaginationEndpoint() throws {
        guard var urlComps = URLComponents(string:  BaseUrl.baseUrl.url + UrlEndpoint.getAnime.endpoint + UrlEndpoint.pagination.endpoint) else { return }
        
        urlComps.queryItems = queryObject.paginationQuery(pageValue: 10)
        guard let animeAbsoluteString = urlComps.url?.absoluteString.removingPercentEncoding else { return }
        
        XCTAssertEqual(animeAbsoluteString, "https://kitsu.io/api/edge/anime?page[limit]=10")
     }

}

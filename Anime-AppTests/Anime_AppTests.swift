//
//  Anime_AppTests.swift
//  Anime-AppTests
//
//  Created by Tobi Adegoroye on 21/08/2023.
//

import XCTest
@testable import Anime_App


final class Anime_AppTests: XCTestCase {
    var urlRequestBuilder: URLRequestBuilder!

    override func setUpWithError() throws {
        urlRequestBuilder = URLRequestBuilder.init(path: BaseUrl.baseUrl.url)
    }

    override func tearDownWithError() throws {
        urlRequestBuilder = nil
    }
 
    func test_Base_URL_IsCorrect() throws {
            if let scheme = urlRequestBuilder.url?.scheme,
               let host = urlRequestBuilder.url?.host,
               let path = urlRequestBuilder.url?.path
              {
                let baseURL = scheme + host + path
                print("Base Url \(baseURL)")
                let expectedBaseURLString = "https://kitsu.io/api/edge"
                XCTAssertEqual(baseURL, expectedBaseURLString)
            }
        }
    
    func test_API_GetAnime_URL_IsCorrect() throws {
        let getAnime = URLRequestBuilder.fetchAnime(page: 0)
        let url = getAnime.url?.absoluteString
        let expectedBaseURLString = "https://kitsu.io/api/edge/anime?page%5Boffset%5D=0"
        XCTAssertEqual(url, expectedBaseURLString)
    }
    
    func test_scheme_IsCorrect() throws {
        if let scheme = urlRequestBuilder.url?.scheme {
            let expectedScheme = "https"
            XCTAssertEqual(scheme, expectedScheme)
        }
    }
    
    func test_host_IsCorrect() throws {
        if let host = urlRequestBuilder.url?.host {
            let expectedHost = "kitsu.io"
            XCTAssertEqual(host, expectedHost)
        }
      }
    
    func test_path_IsCorrect() throws {
        if let path = urlRequestBuilder.url?.path {
            let expectedPath = URLPath.animepath.url
            XCTAssertEqual(path, expectedPath)
        }
    }
    
    func test_SearchAnime_QueryParms_IsCorrect() throws {
        let searchAnime = URLRequestBuilder.search(for: "Naruto")
        let query = searchAnime.queryItems
        let expectedSearchAnimeQuery = [URLQueryItem(name: "filter[text]", value: "Naruto")]
        XCTAssertEqual(query, expectedSearchAnimeQuery)
    }
    
    func test_GetAnime_QueryParms_IsCorrect() throws {
        let getAnime = URLRequestBuilder.fetchAnime(page: 0)
        let query = getAnime.queryItems
        let expectedGetAnimeQuery = [URLQueryItem(name: "page[offset]", value: "0")]
        XCTAssertEqual(query, expectedGetAnimeQuery)
    }
    
    func test_API_SearchAnime_URL_IsCorrect() throws {
        
        let getAnime = URLRequestBuilder.search(for: "Naruto")
        let url = getAnime.url?.absoluteString
        let expectedBaseURLString = "https://kitsu.io/api/edge/anime?filter%5Btext%5D=Naruto"
        XCTAssertEqual(url, expectedBaseURLString)
    }

}

//
//  Anime.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 09/08/2023.
//

import Foundation

struct AnimeResult: Codable {
    let data: [Anime]
}

struct Anime: Codable {
    let id: String
    let attributes: Attributes?
}

struct Attributes: Codable {
    let createdAt: String?
    let updatedAt: String?
    let slug, synopsis, description: String?
    let coverImageTopOffset: Int?
    let canonicalTitle: String?
    let abbreviatedTitles: [String]
    let averageRating: String?
    let ratingFrequencies: [String: String]
    let userCount, favoritesCount: Int?
    let startDate, endDate: String?
    let popularityRank, ratingRank: Int?
    let ageRatingGuide: String?
    let tba: String?
    let posterImage: PosterImage
    let episodeCount: Int?
    let episodeLength: Int?
    let totalLength: Int?
    let youtubeVideoId: String?
    let nsfw: Bool
}

// MARK: - PosterImage
struct PosterImage: Codable {
    let tiny, large, small, medium: String
    let original: String
}
 
 
 

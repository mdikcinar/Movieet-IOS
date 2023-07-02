//
//  MVWatchable.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Foundation

class MVWatchable: Decodable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let originalLanguage, overview: String
    let posterPath, mediaType: String
    let genreIDS: [Int]
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

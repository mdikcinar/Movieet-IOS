//
//  MVMovie.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 2.07.2023.
//

import Foundation

class MVMovie: MVWatchable {
    let title: String
    let originalTitle: String

    enum CodingKeys: String, CodingKey {
        case title
        case originalTitle = "original_title"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)

        try super.init(from: decoder)
    }
}

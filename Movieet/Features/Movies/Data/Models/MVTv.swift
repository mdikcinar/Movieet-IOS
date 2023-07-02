//
//  MVTv.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 2.07.2023.
//

import Foundation

class MVTv: MVWatchable {
    let name: String
    let originalName: String

    enum CodingKeys: String, CodingKey {
        case name
        case originalName = "original_name"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        originalName = try container.decode(String.self, forKey: .originalName)

        try super.init(from: decoder)
    }
}

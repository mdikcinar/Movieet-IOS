//
//  MVPaginated.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Foundation

struct MVPaginated<T: Decodable>: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [T]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}

//
//  MoviesService.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Foundation

protocol MoviesService {
    func fetchTrendMovies(completion: @escaping (Result<MVPaginated<MVWatchable>, DataError>) -> Void)
}

final class TmdbService: MoviesService {
    static let instance = TmdbService()
    let baseApiURL: String
    let parameters: [String: Any]

    private init() {
        let baseApiURL = ProcessInfo.processInfo.environment["baseTmdbApiURL"]
        self.baseApiURL = baseApiURL ?? ""

        let apiKey = ProcessInfo.processInfo.environment["tmdbApiKey"]
        self.parameters = ["api_key": apiKey ?? ""]
    }

    func fetchTrendMovies(completion: @escaping (Result<MVPaginated<MVWatchable>, DataError>) -> Void) {
        NetworkManager.instance.request(url: baseApiURL + "/trending/movie/week", parameters: parameters, model: MVPaginated<MVWatchable>.self) { response in
            completion(response)
        }
    }
}

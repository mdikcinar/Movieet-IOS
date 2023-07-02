//
//  MoviesService.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Foundation

protocol MoviesService {
    func fetchTrendMovies(completion: @escaping (Result<MVPaginated<MVMovie>, DataError>) -> Void)
}

final class TmdbService: MoviesService {
    static let instance = TmdbService()
    let baseApiURL: String
    let baseImageApiURL: String
    let parameters: [String: Any]

    private init() {
        let baseApiURL = ProcessInfo.processInfo.environment["baseTmdbApiURL"]
        self.baseApiURL = baseApiURL ?? ""

        let baseImageApiURL = ProcessInfo.processInfo.environment["baseTmdbImageApiURL"]
        self.baseImageApiURL = baseImageApiURL ?? ""

        let apiKey = ProcessInfo.processInfo.environment["tmdbApiKey"]
        self.parameters = ["api_key": apiKey ?? ""]
    }

    func fetchTrendMovies(completion: @escaping (Result<MVPaginated<MVMovie>, DataError>) -> Void) {
        NetworkManager.instance.request(url: baseApiURL + "/trending/movie/week", parameters: parameters, model: MVPaginated<MVMovie>.self) { response in
            completion(response)
        }
    }

    func fetchTrendSeries(completion: @escaping (Result<MVPaginated<MVTv>, DataError>) -> Void) {
        NetworkManager.instance.request(url: baseApiURL + "/trending/tv/week", parameters: parameters, model: MVPaginated<MVTv>.self) { response in
            completion(response)
        }
    }

    func fetchImage(imagePath: String, completion: @escaping (Result<Data, DataError>) -> Void) {
        NetworkManager.instance.request(url: baseImageApiURL + AppConstants.posterSize.rawValue + "/\(imagePath)", parameters: parameters) { response in
            completion(response)
        }
    }
}

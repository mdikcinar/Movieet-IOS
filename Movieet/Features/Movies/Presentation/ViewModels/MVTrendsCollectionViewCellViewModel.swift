//
//  MVTrendsCollectionViewCellViewModel.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Foundation
import UIKit

final class MVTrendsCollectionViewCellViewModel {
    public let posterPath: String?
    public let rate: String?

    // MARK: - Init

    init(
        posterPath: String?,
        rate: String?
    ) {
        self.posterPath = posterPath
        self.rate = rate
    }

    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = posterPath else {
            completion(.failure(URLError(.badURL)))
            return
        }
        TmdbService.instance.fetchImage(imagePath: url) { response in
            switch response {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

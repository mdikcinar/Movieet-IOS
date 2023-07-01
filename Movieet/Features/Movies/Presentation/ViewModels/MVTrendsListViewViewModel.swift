//
//  MVTrendsListViewModel.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Combine
import UIKit

final class MVTrendsListViewViewModel {
    @Published private(set) var trendMovies: [MVWatchable] = [] {
        didSet {
            for movie in trendMovies {
                let viewmodel = MVTrendsCollectionViewCellViewModel(
                    watchableName: movie.originalTitle
                )
                cellViewModels.append(viewmodel)
            }
        }
    }

    @Published private(set) var error: DataError? = nil

    private(set) var cellViewModels: [MVTrendsCollectionViewCellViewModel] = []

    func fetchTrends() {
        TmdbService.instance.fetchTrendMovies { [weak self] response in
            switch response {
            case .success(let data):
                self?.trendMovies = data.results
            case .failure(let error):
                self?.error = error
            }
        }
    }
}

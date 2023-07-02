//
//  MVTrendsListViewModel.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import UIKit

enum MVTrendsViewListDataSourceType {
    case movies
    case series
}

protocol MVTrendsListViewViewModelDelegate: AnyObject {
    func trendsFetched()
}

final class MVTrendsListViewViewModel: NSObject {
    public weak var delegate: MVTrendsListViewViewModelDelegate?

    public var dataSourceType: MVTrendsViewListDataSourceType = .movies {
        didSet {
            // TODO: set scroll view positions
        }
    }

    private var trendMovies: [MVMovie] = [] {
        didSet {
            trendMoviesCellViewModels = setupCellViewModels(watchables: trendMovies)
        }
    }

    private var trendSeries: [MVTv] = [] {
        didSet {
            trendSeriesCellViewModels = setupCellViewModels(watchables: trendSeries)
        }
    }

    private var error: DataError? = nil
    private var trendMoviesCellViewModels: [MVTrendsCollectionViewCellViewModel] = []
    private var trendSeriesCellViewModels: [MVTrendsCollectionViewCellViewModel] = []

    func fetchTrends() {
        TmdbService.instance.fetchTrendMovies { [weak self] response in
            switch response {
            case .success(let data):
                self?.trendMovies = data.results
                DispatchQueue.main.async {
                    self?.delegate?.trendsFetched()
                }
            case .failure(let error):
                self?.error = error
            }
        }
        TmdbService.instance.fetchTrendSeries { [weak self] response in
            switch response {
            case .success(let data):
                self?.trendSeries = data.results
                DispatchQueue.main.async {
                    self?.delegate?.trendsFetched()
                }
            case .failure(let error):
                self?.error = error
            }
        }
    }

    func setupCellViewModels(watchables: [MVWatchable]) -> [MVTrendsCollectionViewCellViewModel] {
        var cellViewModels: [MVTrendsCollectionViewCellViewModel] = []
        for watchable in watchables {
            let viewmodel = MVTrendsCollectionViewCellViewModel(
                posterPath: watchable.posterPath,
                rate: String(round(watchable.voteAverage * 10) / 10)
            )
            cellViewModels.append(viewmodel)
        }
        return cellViewModels
    }
}

extension MVTrendsListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceType == .movies ? trendMoviesCellViewModels.count : trendSeriesCellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MVWatchableCollectionViewCell.identifier,
            for: indexPath
        ) as? MVWatchableCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = dataSourceType == .movies ? trendMoviesCellViewModels[indexPath.row] : trendSeriesCellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(
            width: width,
            height: width * 1.7
        )
    }
}

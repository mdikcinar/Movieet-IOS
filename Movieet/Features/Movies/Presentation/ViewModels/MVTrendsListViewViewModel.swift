//
//  MVTrendsListViewModel.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import UIKit

protocol MVTrendsListViewViewModelDelegate: AnyObject {
    func trendsFetched()
}

final class MVTrendsListViewViewModel: NSObject {
    public weak var delegate: MVTrendsListViewViewModelDelegate?

    private var trendMovies: [MVWatchable] = [] {
        didSet {
            for movie in trendMovies {
                let viewmodel = MVTrendsCollectionViewCellViewModel(
                    posterPath: movie.posterPath,
                    rate: String(movie.voteAverage)
                )
                cellViewModels.append(viewmodel)
            }
        }
    }

    private var error: DataError? = nil
    private var cellViewModels: [MVTrendsCollectionViewCellViewModel] = []

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
    }
}

extension MVTrendsListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MVWatchableCollectionViewCell.identifier,
            for: indexPath
        ) as? MVWatchableCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = cellViewModels[indexPath.row]
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

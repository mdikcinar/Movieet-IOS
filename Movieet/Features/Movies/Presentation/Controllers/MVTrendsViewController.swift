//
//  MVTrendsViewController.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import Combine
import UIKit

final class MVTrendsViewController: UIViewController {
    private let viewModel = MVTrendsListViewViewModel()
    private let trendMoviesListView = MVWatchableListView()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Trends"
        setupBinders()
        setUpView()
        trendMoviesListView.setUpCollectionView(viewController: self)
        viewModel.fetchTrends()
    }

    private func setUpView() {
        view.addSubview(trendMoviesListView)

        NSLayoutConstraint.activate([
            trendMoviesListView.topAnchor.constraint(equalTo: view.topAnchor),
            trendMoviesListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trendMoviesListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            trendMoviesListView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func setupBinders() {
        viewModel.$trendMovies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.trendMoviesListView.moviesFetched()
            }
            .store(in: &cancellables)

        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error = error {
                    let alert = UIAlertController(title: "Error",
                                                  message: "Could not retrieve pokemons: \(error.localizedDescription)",
                                                  preferredStyle: .alert)

                    let action = UIAlertAction(title: "OK",
                                               style: .default)
                    alert.addAction(action)
                    self?.present(alert,
                                  animated: true)
                }
            }
            .store(in: &cancellables)
    }
}

extension MVTrendsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MVWatchableCollectionViewCell.identifier,
            for: indexPath
        ) as? MVWatchableCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = viewModel.cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
}

//
//  MVTrendsViewController.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import UIKit

final class MVTrendsViewController: UIViewController {
    // MARK: - Properties

    private let items = ["Movies", "Series"]

    // MARK: - UI Elements

    private let trendMoviesListView: MVWatchableListView = {
        let view = MVWatchableListView()
        view.isHidden = false
        return view
    }()

    private lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: items)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(tabChanged), for: .valueChanged)
        return view
    }()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Trends"

        view.addSubviews(segmentControl, trendMoviesListView)

        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(
                equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
                multiplier: 2
            ),
            segmentControl.leadingAnchor.constraint(
                equalToSystemSpacingAfter: view.leadingAnchor,
                multiplier: 4
            ),
            view.trailingAnchor.constraint(
                equalToSystemSpacingAfter: segmentControl.trailingAnchor,
                multiplier: 4
            ),
            trendMoviesListView.topAnchor.constraint(
                equalToSystemSpacingBelow: segmentControl.bottomAnchor,
                multiplier: 2
            ),
            trendMoviesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            trendMoviesListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            trendMoviesListView.rightAnchor.constraint(equalTo: view.rightAnchor),

        ])
    }

    @objc func tabChanged() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            trendMoviesListView.viewModel.dataSourceType = .movies
            trendMoviesListView.reloadCollectionViewData()
        case 1:
            trendMoviesListView.viewModel.dataSourceType = .series
            trendMoviesListView.reloadCollectionViewData()
        default:
            trendMoviesListView.viewModel.dataSourceType = .movies
        }
    }
}

//
//  MVTrendsViewController.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import UIKit

final class MVTrendsViewController: UIViewController {
    private let trendMoviesListView = MVWatchableListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Trends"
        setUpView()
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
}

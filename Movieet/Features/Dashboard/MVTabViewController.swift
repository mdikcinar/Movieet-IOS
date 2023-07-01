//
//  MVTabViewController.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import UIKit

final class MVTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    func setupTabs() {
        let trendsVC = MVTrendsViewController()

        let trendsNavigation = UINavigationController(rootViewController: trendsVC)
        trendsNavigation.tabBarItem = UITabBarItem(
            title: "Trends",
            image: UIImage(systemName: "tv"),
            tag: 1
        )

        let navigations = [
            trendsNavigation
        ]

        setViewControllers(navigations, animated: true)
    }
}

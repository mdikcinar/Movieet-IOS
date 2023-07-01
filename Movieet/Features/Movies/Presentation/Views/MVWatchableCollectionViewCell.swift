//
//  MVWatchableCollectionViewCell.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import UIKit

final class MVWatchableCollectionViewCell: UICollectionViewCell {
    static let identifier = "MVWatchableCollectionViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func setUpView() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(nameLabel)
        contentView.layer.cornerRadius = 10
        addConstraints()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -3),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }

    public func configure(with viewModel: MVTrendsCollectionViewCellViewModel) {
        nameLabel.text = viewModel.watchableName
    }
}

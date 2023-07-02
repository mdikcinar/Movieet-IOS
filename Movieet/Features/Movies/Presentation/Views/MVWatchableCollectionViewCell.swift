//
//  MVWatchableCollectionViewCell.swift
//  Movieet
//
//  Created by Mustafa Ali Dikcinar on 1.07.2023.
//

import UIKit

final class MVWatchableCollectionViewCell: UICollectionViewCell {
    static let identifier = "MVWatchableCollectionViewCell"

    private let rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        contentView.addSubviews(imageView, rateLabel)
        contentView.layer.cornerRadius = 10
        addConstraints()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: rateLabel.topAnchor),
            rateLabel.heightAnchor.constraint(equalToConstant: 30),
            rateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            rateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            rateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        rateLabel.text = nil
    }

    public func configure(with viewModel: MVTrendsCollectionViewCellViewModel) {
        rateLabel.text = viewModel.rate
        viewModel.fetchImage { [weak self] result in
            switch result {
            case let .success(data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

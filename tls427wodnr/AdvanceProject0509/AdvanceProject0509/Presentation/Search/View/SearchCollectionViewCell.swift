//
//  BookCell.swift
//  AdvanceProject0509
//
//  Created by tlswo on 5/9/25.
//

import UIKit
import SDWebImage

// MARK: - SearchCollectionViewCell

final class SearchCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "SearchCollectionViewCell"
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            authorLabel.bottomAnchor.constraint(lessThanOrEqualTo: imageView.bottomAnchor)
        ])
    }
    
    // MARK: - Placeholder

    private static let placeholderImage: UIImage? = {
        UIImage(systemName: "book")?.withRenderingMode(.alwaysTemplate)
    }()
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = Self.placeholderImage
    }
    
    // MARK: - Configuration

    func configure(with item: BookItem) {
        titleLabel.text = item.title
        authorLabel.text = item.author

        if let url = URL(string: item.image) {
            imageView.sd_setImage(
                with: url,
                placeholderImage: Self.placeholderImage,
                options: [.retryFailed, .scaleDownLargeImages],
                completed: nil
            )
        } else {
            imageView.image = Self.placeholderImage
        }
    }
}

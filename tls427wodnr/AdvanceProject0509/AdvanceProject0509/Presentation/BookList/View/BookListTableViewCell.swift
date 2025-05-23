//
//  Book.swift
//  AdvanceProject0509
//
//  Created by tlswo on 5/14/25.
//

import UIKit
import SDWebImage

// MARK: - BookListTableViewCell

final class BookListTableViewCell: UITableViewCell {
    
    // MARK: - Identifier

    static let identifier = "BookTableViewCell"
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(bookImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            bookImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bookImageView.widthAnchor.constraint(equalToConstant: 60),
            bookImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            authorLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    // MARK: - Placeholder
    
    private static let placeholderImage: UIImage? = {
        UIImage(systemName: "book")?.withRenderingMode(.alwaysTemplate)
    }()
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.sd_cancelCurrentImageLoad()
        bookImageView.image = Self.placeholderImage
    }
    
    // MARK: - Configuration

    func configure(with item: BookItem) {
        titleLabel.text = item.title
        authorLabel.text = item.author
        bookImageView.image = nil

        if let url = URL(string: item.image) {
            bookImageView.sd_setImage(
                with: url,
                placeholderImage: Self.placeholderImage,
                options: [.retryFailed, .scaleDownLargeImages],
                completed: nil
            )
        } else {
            bookImageView.image = Self.placeholderImage
        }
    }
}

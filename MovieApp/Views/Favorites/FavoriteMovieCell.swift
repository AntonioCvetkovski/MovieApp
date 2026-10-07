//
//  FavoriteMovieCell.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 07/10/2026.
//

import UIKit
import SnapKit
import Kingfisher
import MovieCore

class FavoriteMovieCell: UICollectionViewCell {
    
    static let identifier = "FavoriteMovieCell"
    
    // MARK: - UI
    private let imageView = UIImageView()
    private let infoView = UIView()
    private let titleLabel = UILabel()
    private let ratingStack = UIStackView()
    private let starImageView = UIImageView()
    private let ratingLabel = UILabel()
    private let yearLabel = UILabel()
    private let heartButton = UIButton()
    
    var onRemove: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        // Container
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        
        // Image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        contentView.addSubview(imageView)
        
        // Info View
        infoView.backgroundColor = .systemBackground
        contentView.addSubview(infoView)
        
        // Title
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        infoView.addSubview(titleLabel)
        
        // Star
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .systemYellow
        starImageView.contentMode = .scaleAspectFit
        
        // Rating
        ratingLabel.font = .systemFont(ofSize: 11)
        ratingLabel.textColor = .secondaryLabel
        
        // Year
        yearLabel.font = .systemFont(ofSize: 11)
        yearLabel.textColor = .secondaryLabel
        yearLabel.textAlignment = .right
        
        // Rating Stack
        ratingStack.axis = .horizontal
        ratingStack.spacing = 4
        ratingStack.alignment = .center
        ratingStack.addArrangedSubview(starImageView)
        ratingStack.addArrangedSubview(ratingLabel)
        ratingStack.addArrangedSubview(UIView()) // Spacer
        ratingStack.addArrangedSubview(yearLabel)
        infoView.addSubview(ratingStack)
        
        // Heart Button
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold)
        heartButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .normal)
        heartButton.tintColor = .red
        heartButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        heartButton.layer.cornerRadius = 14
        heartButton.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
        contentView.addSubview(heartButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(180)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(8)
        }
        
        ratingStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        
        starImageView.snp.makeConstraints { make in
            make.width.height.equalTo(10)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(8)
            make.width.height.equalTo(28)
        }
    }
    
    // MARK: - Configure
    func configure(movie: Movie) {
        titleLabel.text = movie.displayTitle
        ratingLabel.text = movie.formattedRating
        yearLabel.text = String(movie.displayDate.prefix(4))
        
        if let urlString = movie.posterURL, let url = URL(string: urlString) {
            imageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "film"),
                options: [
                    .cacheOriginalImage,
                    .transition(.fade(0.3))
                ]
            )
        }
    }
    
    @objc private func heartTapped() {
        onRemove?()
    }
}

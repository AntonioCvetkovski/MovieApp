//
//  FavoritesUIViewController.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 07/10/2026.
//

import UIKit
import SnapKit
import MovieCore

class FavoritesUIViewController: UIViewController {
    
    // MARK: - Properties
    var movies: [Movie] = []
    var onMovieSelected: ((Movie) -> Void)?
    var onMovieRemoved: ((Movie) -> Void)?
    
    // MARK: - UI
    private var collectionView: UICollectionView!
    private let emptyStateView = UIView()
    private let emptyImageView = UIImageView()
    private let emptyLabel = UILabel()
    private let emptySubLabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupEmptyState()
    }
    
    // MARK: - Layout
    private var itemsPerRow: Int {
        traitCollection.horizontalSizeClass == .regular ? 3 : 2
    }
    
    private func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }
    
    // MARK: - Setup CollectionView
    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeLayout()
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            FavoriteMovieCell.self,
            forCellWithReuseIdentifier: FavoriteMovieCell.identifier
        )
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Setup Empty State
    private func setupEmptyState() {
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)
        
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
        }
        
        emptyImageView.image = UIImage(systemName: "heart.slash")
        emptyImageView.tintColor = .systemGray
        emptyImageView.contentMode = .scaleAspectFit
        emptyStateView.addSubview(emptyImageView)
        
        emptyImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        emptyLabel.text = "No favorites yet"
        emptyLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        emptyLabel.textColor = .secondaryLabel
        emptyLabel.textAlignment = .center
        emptyStateView.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
        }
        
        emptySubLabel.text = "Tap the heart icon on any movie to add it to your favorites"
        emptySubLabel.font = .systemFont(ofSize: 14)
        emptySubLabel.textColor = .tertiaryLabel
        emptySubLabel.textAlignment = .center
        emptySubLabel.numberOfLines = 0
        emptyStateView.addSubview(emptySubLabel)
        
        emptySubLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    // MARK: - Update
    func updateMovies(_ movies: [Movie]) {
        self.movies = movies
        collectionView?.reloadData()
        emptyStateView.isHidden = !movies.isEmpty
        collectionView.isHidden = movies.isEmpty
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FavoritesUIViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoriteMovieCell.identifier,
            for: indexPath
        ) as? FavoriteMovieCell else {
            return UICollectionViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(movie: movie)
        cell.onRemove = { [weak self] in
            self?.onMovieRemoved?(movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onMovieSelected?(movies[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesUIViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing: CGFloat = 16
        let inset: CGFloat = 16
        let isLandscape = view.bounds.width > view.bounds.height
        let count: CGFloat = isLandscape ? 3 : 2
        let itemWidth = (collectionView.bounds.width - (inset * 2) - (spacing * (count - 1))) / count
        return CGSize(width: itemWidth, height: itemWidth * 1.4)
    }
}

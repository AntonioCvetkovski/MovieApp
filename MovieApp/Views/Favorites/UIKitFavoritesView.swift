//
//  UIKitFavoritesView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 07/10/2026.
//

import SwiftUI
import MovieCore

struct UIKitFavoritesView: UIViewControllerRepresentable {
    
    let movies: [Movie]
    var onMovieSelected: ((Movie) -> Void)?
    var onMovieRemoved: ((Movie) -> Void)?
    
    func makeUIViewController(context: Context) -> FavoritesUIViewController {
        let vc = FavoritesUIViewController()
        vc.onMovieSelected = onMovieSelected
        vc.onMovieRemoved = onMovieRemoved
        return vc
    }
    
    func updateUIViewController(_ uiViewController: FavoritesUIViewController, context: Context) {
        uiViewController.updateMovies(movies)
    }
}

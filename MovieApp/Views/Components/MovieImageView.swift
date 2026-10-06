//
//  MovieImageView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 06/10/2026.
//

import SwiftUI
import UIKit
import Kingfisher

struct MovieImageView: UIViewRepresentable {
    let url: URL?
    var contentMode: UIView.ContentMode = .scaleAspectFill

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.kf.indicatorType = .activity
        return imageView
    }

    func updateUIView(
        _ uiView: UIImageView,
        context: Context
    ) {
        guard let url else {
            uiView.image = UIImage(systemName: "film")
            return
        }

        uiView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "film"),
            options: [
                .cacheOriginalImage,
                .transition(.fade(0.3))
            ]
        )
    }
}

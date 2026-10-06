//
//  MainTabView.swift
//  MovieApp
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Label("Trending", systemImage: "film")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
        .tint(.red)
    }
}

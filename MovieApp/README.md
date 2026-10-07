
# MovieApp

A native iOS application built with SwiftUI that showcases trending movies using The Movie Database (TMDB) API.

## Architecture

- **MVVM** with Repository pattern
- **SwiftUI** for UI with **UIKit** integration via `UIViewRepresentable`
- **Combine** for reactive search with debounce
- **async/await** for networking

## Features

- Trending movies list with infinite scroll pagination
-  Search movies and TV shows with throttled search
-  Movie detail screen with extended information
-  Favorites list with local persistence (UserDefaults)
-  Dev/Prod environment schemes

## Tech Stack

- Swift 5
- SwiftUI + UIKit (UIViewRepresentable)
- Combine
- URLSession (native networking)
- Kingfisher (image caching) via SPM
- SwiftLint via SPM
- XCTest (Unit Tests)

## Requirements

- iOS 16+
- Xcode 15+

## Setup

1. Clone the repository
2. Open `MovieApp.xcodeproj`
3. Select `MovieApp-Dev` scheme for development
4. Run the project

## Schemes

- `MovieApp-Dev` — Development environment
- `MovieApp-Prod` — Production environment

## Testing

Run tests with `Cmd + U` in Xcode.

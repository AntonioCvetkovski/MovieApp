//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Antonio Cvetkovski on 05/10/2026.
//

import XCTest
@testable import MovieApp

final class MoviesViewModelTests: XCTestCase {
    
    var sut: MoviesViewModel!
    var mockRepo: MockMovieRepository!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockMovieRepository()
        sut = MoviesViewModel(repository: mockRepo)
    }
    
    override func tearDown() {
        sut = nil
        mockRepo = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testInitialState() {
        XCTAssertTrue(sut.movies.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }
    
    func testFetchMoviesSuccess() async {
        await sut.fetchTrendingMovies()
        let movies = await MainActor.run { sut.movies }
        XCTAssertFalse(movies.isEmpty)
        let error = await MainActor.run { sut.errorMessage }
        XCTAssertNil(error)
    }

    func testFetchMoviesFailure() async {
        await MainActor.run { mockRepo.shouldFail = true }
        await sut.fetchTrendingMovies()
        let movies = await MainActor.run { sut.movies }
        XCTAssertTrue(movies.isEmpty)
        let error = await MainActor.run { sut.errorMessage }
        XCTAssertNotNil(error)
    }

    func testLoadMoreMovies() async {
        await sut.fetchTrendingMovies()
        let initialCount = await MainActor.run { sut.movies.count }
        await sut.loadMoreMovies()
        let newCount = await MainActor.run { sut.movies.count }
        XCTAssertGreaterThan(newCount, initialCount)
    }
}

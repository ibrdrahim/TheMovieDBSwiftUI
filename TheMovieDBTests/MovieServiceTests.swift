//
//  MovieServiceTest.swift
//  TheMovieDBTests
//
//  Created by ibrahim on 26/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import XCTest
@testable import TheMovieDB

class MovieServiceTests: XCTestCase {
    
    // Test Case 1 : Test fetching movie success,
    // only test for popular because the rest of endpoint is have same format
    func testFetchMoviesSuccess(){
        let movieProvider = MovieProvider.shared
        let movieExpectaion = expectation(description: "Popular")
        var movieResponse: MovieResponse?
        
        movieProvider.list(endpoint: .popular, params: nil, onSuccess: { response in
            movieResponse = response
            movieExpectaion.fulfill()
        }, onError: {_ in
            
        })

        waitForExpectations(timeout: 30) { (error) in
          XCTAssertNotNil(movieResponse)
        }
    }
    
    // Test Case 2 : get detail movie
    func testFetchDetailMovie(){
        let movieProvider = MovieProvider.shared
        let movieExpectaion = expectation(description: "Movie Detail")
        var movieResponse: MovieDetailResponse?
        let mockMovie = Movie.dummy
        
        movieProvider.detail(id: mockMovie.id, params: nil, onSuccess: { response in
            movieResponse = response
            movieExpectaion.fulfill()
        }) { _ in
            
        }
        
        waitForExpectations(timeout: 30) { error in
            // if id is the same, get movie detail is success
            XCTAssertEqual(movieResponse?.id, mockMovie.id)
        }
        
    }
    
    // Test Case 3 : get movie review
    func testFetchMovieReview(){
        let movieProvider = MovieProvider.shared
        let movieExpectaion = expectation(description: "Movie Review")
        var reviewResponse: ReviewResponse?
        let mockMovie = Movie.dummy
        
        movieProvider.review(id: mockMovie.id, params: nil, onSuccess: { response in
            reviewResponse = response
            movieExpectaion.fulfill()
        }) { _ in
            
        }
        
        waitForExpectations(timeout: 30) { error in
            XCTAssertNotNil(reviewResponse)
        }
        
    }
    
    // Test Case 4 : set movie as Favourite, get list favourite movie
    func testFavouriteMovies(){
        let favouriteMovieService = FavouriteMovieService()
        
        // clean up all favourites movie first
        favouriteMovieService.cleanFavourites()
        
        // set mock movie id, it will be saved in local storage
        for mockMovieID in 1...10 {
            favouriteMovieService.setFavourite(id: mockMovieID)
        }
        
        // should return 10 element now
        XCTAssertEqual(favouriteMovieService.getFavourites().count, 10)
        // make sure value is equal
        XCTAssertEqual(favouriteMovieService.getFavourites().sorted(), [1,2,3,4,5,6,7,8,9,10])
        
        // remove a bunch of favourite movie id
        favouriteMovieService.removeFavourite(id: 2)
        favouriteMovieService.removeFavourite(id: 3)
        favouriteMovieService.removeFavourite(id: 5)
        
        // should return 7 element now
        XCTAssertEqual(favouriteMovieService.getFavourites().count, 7)
        
        // validate removed favourite movie
        XCTAssertEqual(favouriteMovieService.isFavourite(id: 1), true)
        XCTAssertEqual(favouriteMovieService.isFavourite(id: 2), false)
        XCTAssertEqual(favouriteMovieService.isFavourite(id: 3), false)
        XCTAssertEqual(favouriteMovieService.isFavourite(id: 4), true)
        XCTAssertEqual(favouriteMovieService.isFavourite(id: 5), false)
        
        
        // clean up all favourites movie
        favouriteMovieService.cleanFavourites()
        XCTAssertEqual(favouriteMovieService.getFavourites(), [])
    }
    

}

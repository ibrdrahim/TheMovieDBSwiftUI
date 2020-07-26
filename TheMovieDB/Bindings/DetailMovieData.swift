//
//  DetailMovieData.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import Combine
import SwiftUI

final class DetailMovieData : ObservableObject {
    
    private let movieProvider: MovieProvider
    private let favouriteMovieService = FavouriteMovieService()
    private let movieId:Int
    
    @Published var isFavourite: Bool = false
    @Published var isFetchingMovieDetail: Bool = false
    @Published var isFetchingReviewDetail: Bool = false
    @Published var movie:MovieDetailResponse?
    @Published var reviews:[Review]?
    
    init(id:Int) {
        movieId = id
        movieProvider = MovieProvider.shared
        isFavourite = favouriteMovieService.isFavourite(id: movieId)
    }
    
    func fetchData(){
        fetchMovieDetail()
        fetchReviews()
    }
    
    private func fetchMovieDetail() {
        isFetchingMovieDetail = true
        
        self.movieProvider.detail(id: movieId, params: nil,onSuccess: { [weak self] (response) in
            
            guard let self = self else { return }
            self.isFetchingMovieDetail = false
            self.movie = response
            
        }) { (error) in
            self.isFetchingMovieDetail = false
            print(error.localizedDescription)
        }
    }
    
    private func fetchReviews(){
        isFetchingReviewDetail = true
        
        self.movieProvider.review(id: movieId, params: nil,onSuccess: { [weak self] (response) in
            
            guard let self = self else { return }
            self.isFetchingReviewDetail = false
            self.reviews = response.results
            
        }) { (error) in
            self.isFetchingReviewDetail = false
            print(error.localizedDescription)
        }
    }
    
    // set movie as favourite , if already stored remove it from favourites
    func toggleFavourite(){
        if favouriteMovieService.isFavourite(id: movieId){
            // remove from favourite
            isFavourite = false
            favouriteMovieService.removeFavourite(id: movieId)
        }else{
            // add new favourite
            isFavourite = true
            favouriteMovieService.setFavourite(id: movieId)
        }
    }
}

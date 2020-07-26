//
//  FavouriteMovieData.swift
//  TheMovieDB
//
//  Created by ibrahim on 26/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import Combine
import SwiftUI

final class FavouriteMovieData: ObservableObject {
    
    private let movieProvider: MovieProvider
    
    @Published var isLoading: Bool = false
    @Published var movies: [Movie] = []
    
    init() {
        movieProvider = MovieProvider.shared
    }
    
    func loadFavouriteMovies() {
        let favouriteMovies = FavouriteMovieService().getFavourites()
        guard favouriteMovies.count > 0 else{
            isLoading = false
            return
        }
        
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .background)
        var favouriteMoviesTemp: [Movie] = []
        
        isLoading = true
        for movieId in favouriteMovies {
            queue.async(group: group) {
                group.enter()
                self.movieProvider.detail(id: movieId, params: nil, onSuccess: {(response) in
                    favouriteMoviesTemp.append(Movie(popularity: response.popularity, voteCount: response.voteCount, video: response.video, posterPath: response.posterPath, id: response.id, adult: response.adult, backdropPath: response.backdropPath, originalTitle: response.originalTitle, genreIds: response.genres.compactMap{ $0.id } , title: response.title, voteAverage: response.voteAverage, overview: response.overview, releaseDate: response.releaseDate))
                    group.leave()
                }) { (error) in
                    print(error.localizedDescription)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            self.movies = favouriteMoviesTemp
        }
        
    }
}

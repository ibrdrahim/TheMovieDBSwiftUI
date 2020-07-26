//
//  HomeMovieData.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import Combine
import SwiftUI

final class MovieHomeData: ObservableObject {
    
    private var page = 1
    private let movieProvider: MovieProvider
    
    @Published var activeCategory: MovieEndpoint = .nowPlaying
    @Published var isLoading: Bool = false
    @Published var isFetchingMore: Bool = false
    @Published var movies: [Movie] = []
    
    init() {
        movieProvider = MovieProvider.shared
        self.loadMovies(activeCategory)
    }
    
    func loadMovies(_ endpoint: MovieEndpoint) {
        self.activeCategory = endpoint
        self.isLoading = true

        self.movieProvider.list(endpoint: endpoint, params: nil, onSuccess: { [weak self] (response) in
            // add 0.5 second delay to make the transisition smoother
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let self = self else { return }
                    self.isLoading = false
                    self.movies = response.results
            }
        }) { (error) in
            self.isLoading = false
            print(error.localizedDescription)
        }
    }
    
    func loadMoreMovies() {
        // dont load more if is is Fetching More data
        guard !isFetchingMore else {
            return
        }
        
        self.isFetchingMore = true
        self.movieProvider.list(endpoint: self.activeCategory, params: ["page" : "\(page)"], onSuccess: { [weak self] (response) in
            // add 0.5 second delay to make the transisition smoother
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let self = self else { return }
                    self.page += 1
                    self.isFetchingMore = false
                    self.movies += response.results
            }
        }) { (error) in
            self.isLoading = false
            print(error.localizedDescription)
        }
    }
}

fileprivate extension MovieEndpoint {

    var movieIndex: Int {
        switch self {
        case .nowPlaying: return 1
        case .upcoming: return 2
        case .popular: return 3
        case .topRated: return 4
        }
    }
    
}

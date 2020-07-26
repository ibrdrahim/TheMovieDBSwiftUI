//
//  MovieService.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import Foundation

// define available service
protocol MovieService {
    // get list for of movies form available endpoint
    func list(endpoint:MovieEndpoint , params: [String:String]?, onSuccess: @escaping (_ response: MovieResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    // get movie detail
    func detail(id: Int , params: [String:String]?, onSuccess: @escaping (_ response: MovieDetailResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    // get movie review
    func review(id: Int , params: [String:String]?, onSuccess: @escaping (_ response: ReviewResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
}

// list of available movie endpoint
public enum MovieEndpoint:String, CaseIterable, Identifiable {
    public var id: String { self.rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming
    case popular
    case topRated = "top_rated"
}

// define custom error
public enum MovieError: Error {
    case errorFromApi
    case noData
    case invalidEndpoint
    case invalidResponse
    case serializationError
}

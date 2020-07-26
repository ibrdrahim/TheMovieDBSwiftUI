//
//  Movie.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? newJSONDecoder().decode(Movie.self, from: jsonData)

import Foundation

// MARK: - Movie
struct MovieResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable,Identifiable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String?
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalTitle: String
    let genreIds: [Int]
    let title: String
    let voteAverage: Double
    let overview : String
    let releaseDate: Date
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    public var cleanMovieReleaseDate: String {
        return Movie.dateFormatter.string(from: self.releaseDate)
    }
    
    public var isFavourite:Bool {
        return FavouriteMovieService().isFavourite(id: self.id)
    }
    
}

extension Movie {
    
    static var dumies: [Movie] {
        return [
            Movie.dummy,
            Movie.dummy,
            Movie.dummy,
            Movie.dummy,
            Movie.dummy,
            Movie.dummy
        ]
    }
    
    static var dummy: Movie {
        Movie(popularity: 149.982, voteCount: 216, video: false, posterPath: "/jHo2M1OiH9Re33jYtUQdfzPeUkx.jpg", id: 385103, adult: false, backdropPath: "/fKtYXUhX5fxMxzQfyUcQW9Shik6.jpg", originalTitle: "Scoob!", genreIds: [12,16,35,9648,10751], title: "Scoob", voteAverage: 5.0, overview: "In Scooby-Doo’s greatest adventure yet, see the never-before told story of how lifelong friends Scooby and Shaggy first met and how they joined forces with young detectives Fred, Velma, and Daphne to form the famous Mystery Inc. Now, with hundreds of cases solved, Scooby and the gang face their biggest, toughest mystery ever: an evil plot to unleash the ghost dog Cerberus upon the world. As they race to stop this global “dogpocalypse,” the gang discovers that Scooby has a secret legacy and an epic destiny greater than anyone ever imagined.", releaseDate: Date())
    }
    
}

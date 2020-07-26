//
//  Review.swift
//  TheMovieDB
//
//  Created by ibrahim on 25/07/20.
//  Copyright © 2020 ibrahim. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieReview = try? newJSONDecoder().decode(MovieReview.self, from: jsonData)

import Foundation

// MARK: - Review
struct ReviewResponse: Codable {
    let id, page: Int
    let results: [Review]
    let totalPages, totalResults: Int
}

// MARK: - Result
struct Review: Codable,Identifiable,Hashable {
    let author, content, id: String
    let url: String
}

//
//  SavedMovie.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import Foundation

struct SavedMovie: Codable, Identifiable {
    let id: Int
    let title: String
    let year: String
    let poster: Data
    var watched: Bool
    var reviews: [Review]
}

struct Review: Codable {
    let date: Date
    let score: Int
    let title: String
    let body: String
}

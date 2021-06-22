//
//  MovieReviewViewModel.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//  based on https://www.hackingwithswift.com/books/ios-swiftui/adding-a-custom-star-rating-component

import Foundation

class MovieReviewViewModel: ObservableObject {
    let movieDetails: MovieDetails
    let moviePoster: Data
    
    @Published var score: Int = 0
    @Published var title = ""
    @Published var body = ""
    
    var review: Review {
        Review(date: Date(), score: score, title: title, body: body)
    }
    
    init(movieDetails: MovieDetails, moviePoster: Data) {
        self.movieDetails = movieDetails
        self.moviePoster = moviePoster
    }
}

//
//  MovieReviewView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-21.
//

import SwiftUI

struct MovieReviewView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var movieList: MovieListViewModel
    @ObservedObject var viewModel: MovieReviewViewModel
    
    init(movieDetails: MovieDetails, moviePoster: Data) {
        viewModel = MovieReviewViewModel(movieDetails: movieDetails, moviePoster: moviePoster)
    }
    
    var body: some View {
        NavigationView {
            List {
                TextField("review title", text: $viewModel.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("review body", text: $viewModel.body)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Stepper("rating", value: $viewModel.score, in: 1...10)
            }
            .navigationBarTitle("Review")
            .navigationBarItems(leading: Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: "xmark")
            },
            trailing:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    movieList.reviewMovie(movieDetails: viewModel.movieDetails, moviePoster: viewModel.moviePoster, movieReview: viewModel.review)
                }) {
                    Image(systemName: "checkmark")
                })
        }
    }
}

//struct MovieReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieReviewView()
//    }
//}

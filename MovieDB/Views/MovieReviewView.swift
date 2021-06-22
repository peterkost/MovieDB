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
            Form {
                Section {
                    TextField("title", text: $viewModel.title)
                }
                
                Section {
                    TextField("body", text: $viewModel.body)
                }
                RatingView(rating: $viewModel.score)
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
//    static let movieList = MovieListViewModel()
//    static var previews: some View {
//        MovieReviewView(movieDetails: <#MovieDetails#>, moviePoster: <#Data#>)
//            .environmentObject(movieList)
//
//    }
//}

//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Peter Kostin on 2021-06-20.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    @EnvironmentObject var movieList: MovieListViewModel
    
    init(movieID: Int) {
        viewModel = MovieDetailViewModel(for: movieID)
    }
    
    var body: some View {
        Group {
            if viewModel.movieDetails != nil && viewModel.moviePoster != nil {
                let movie = viewModel.movieDetails!
                List {
                    Image(uiImage: UIImage(data: viewModel.moviePoster!) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                    
                    Text(movie.releaseDate)
                
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(movie.genres) {
                                Text($0.name)
                            }
                        }
                    }
                    
                    Button("Add to Watchlist") {
                        movieList.addMovieToWatchlist(movieDetails: movie, moviePoster: viewModel.moviePoster!)
                    }
                    Button("Review") {
                        viewModel.showingAddReview = true
                    }
                }
                .navigationBarTitle(movie.title)
                .sheet(isPresented: $viewModel.showingAddReview, content: {
                    MovieReviewView(movieDetails: movie, moviePoster: viewModel.moviePoster!)
                        .environmentObject(movieList)
                })
            } else {
                ProgressView()
            }
        }
        
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieID: 14609)
    }
}
